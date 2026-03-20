from fastapi import FastAPI, HTTPException
from fastapi.responses import RedirectResponse
from pydantic import BaseModel
import redis
import os
import string
import random

app = FastAPI()

REDIS_HOST = os.getenv("REDIS_HOST", "redis")
REDIS_PORT = int(os.getenv("REDIS_PORT", 6379))
BASE_URL = os.getenv("BASE_URL", "http://localhost:8080")

r = redis.Redis(host=REDIS_HOST, port=REDIS_PORT, decode_responses=True)


class URLRequest(BaseModel):
    url: str


def generate_code(length: int = 6) -> str:
    chars = string.ascii_letters + string.digits
    return "".join(random.choices(chars, k=length))


@app.get("/health")
def health():
    try:
        r.ping()
        return {"status": "ok", "redis": "connected"}
    except redis.RedisError:
        raise HTTPException(status_code=500, detail="Redis is unavailable")


@app.post("/shorten")
def shorten_url(request: URLRequest):


    code = generate_code()

    while r.exists(code):
        code = generate_code()

    r.set(code, request.url)

    return {
        "short_code": code,
        "short_url": f"{BASE_URL}/{code}"
    }


@app.get("/{code}")
def redirect_to_url(code: str):
    original_url = r.get(code)

    if not original_url:
        raise HTTPException(status_code=404, detail="Short code not found")

    return RedirectResponse(url=original_url)