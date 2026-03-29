# CloudLab

A Dockerized Node.js + MongoDB application (Shark Info).

## Directory Structure

```
your-repo/
├── docker-compose.yml
├── docker/
│   ├── nodejs/
│   │   └── Dockerfile
│   └── mongodb/
│       └── Dockerfile
├── nodejs-app/
│   ├── server.js
│   ├── package.json
│   └── public/
│       └── index.html
└── README.md
```

## Usage

```bash
docker-compose up --build
```

The Node.js app will be available at http://localhost:3000  
MongoDB will be available at localhost:27017