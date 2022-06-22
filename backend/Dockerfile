FROM node:16-alpine

USER node
WORKDIR /home/node/app

COPY package*.json ./
RUN npm ci --legacy-peer-deps

COPY . .
ENV NODE_ENV production
RUN npm run build

CMD [ "node", "dist/main.js" ]