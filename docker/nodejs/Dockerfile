FROM node:18-alpine

WORKDIR /app


COPY nodejs-app/package.json ./
COPY nodejs-app/package-lock.json* ./

RUN npm install

COPY nodejs-app ./

EXPOSE 3000

CMD ["node", "server.js"]
