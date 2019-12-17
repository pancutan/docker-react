# Lo mismo que Dockerfile.dev pero agregando a un nginx para producción
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .

# /app/build → y aca va a estar lo necesario para servir
RUN npm run build

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html

# docker build . (devuelve id)
# docker run -p 8080:80 <id>