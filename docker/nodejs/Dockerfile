FROM node:18-alpine

WORKDIR /app

COPY ../nodejs-app/package.json .

RUN npm install

EXPOSE 3000

CMD ["node", "server.js"]
