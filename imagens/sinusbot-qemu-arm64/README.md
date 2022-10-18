# [Sinusbot](https://hub.docker.com/r/sinusbot/docker) docker image with qemu to work on arm64.

## However, I recommend using [Ts3AudioBot](https://hub.docker.com/r/igorferreir4/ts3audiobot) natively.

### Docker-compose.yml example
```sh
  sinusbot:
    image: igorferreir4/sinusbot-qemu-arm64:latest
    restart: always
    container_name: sinusbot
    ports:
      - 8087:8087
    environment:
      - UID=1001
      - GID=1001
    volumes:
      - ./sinusbot/scripts:/opt/sinusbot/scripts
      - ./sinusbot/data:/opt/sinusbot/data
```
