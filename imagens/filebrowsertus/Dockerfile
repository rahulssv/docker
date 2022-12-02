FROM alpine/git:latest as src

COPY imagens/filebrowser-feature-tus-uploads/ /src/
# RUN git clone -b feature/tus-uploads https://github.com/TobiasGoerke/filebrowser.git /src

# FROM node:10.15.2-alpine as nodejs-build
FROM node:16-alpine as nodejs-build
WORKDIR /frontend
COPY --from=src /src/frontend/package.json ./
RUN npm install
COPY --from=src /src/frontend ./
RUN npm run build

FROM golang:1.19.3-alpine3.15 as builder
WORKDIR /src
COPY --from=src /src ./
RUN go mod download

COPY --from=nodejs-build /frontend ./frontend
RUN CGO_ENABLED=0 GOOS=linux go build

FROM alpine:latest
RUN apk --update add ca-certificates \
                     mailcap \
                     curl

HEALTHCHECK --start-period=2s --interval=5s --timeout=3s \
  CMD curl -f http://localhost/health || exit 1

VOLUME /srv
EXPOSE 80

COPY --from=builder /src/docker_config.json /.filebrowser.json
COPY --from=builder /src/filebrowser /filebrowser

ENTRYPOINT [ "/filebrowser" ]