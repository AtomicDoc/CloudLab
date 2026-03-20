import requests

BASE_URL = "http://pcvm604-3.emulab.net:8080"


def test_health():
    print("Testing /health...")
    r = requests.get(f"{BASE_URL}/health")
    print("Status:", r.status_code)
    print("Response:", r.text)
    print()


def test_shorten():
    print("Testing /shorten...")

    payload = {
        "url": "https://youtube.com"
    }

    r = requests.post(f"{BASE_URL}/shorten", json=payload)

    print("Status:", r.status_code)
    print("Response:", r.text)
    print()

    if r.status_code != 200:
        print("shorten failed")
        return None

    data = r.json()
    return data.get("short_code")


def test_redirect(code):
    print(f"Testing redirect /{code}...")

    r = requests.get(f"{BASE_URL}/{code}", allow_redirects=False)

    print("Status:", r.status_code)
    print("Headers:", r.headers)
    print()

    if r.status_code in (301, 302, 307, 308):
        print("redirect working")
    else:
        print("redirect failed")


if __name__ == "__main__":
    test_health()

    code = test_shorten()

    if code:
        test_redirect(code)