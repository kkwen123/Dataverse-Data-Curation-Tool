FROM node:14.19.1 as builder

WORKDIR /dct

COPY package.json package-lock.json ./
RUN npm install

COPY . .
RUN npm run-script build --prod --base-href=http://localhost/

FROM nginx:1.21.6-alpine as server
COPY --from=builder /dct/dist/data-curation-tool/ /usr/share/nginx/html
