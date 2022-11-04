# Github Repository

- [CLICK](https://github.com/igorferreir4/docker/tree/main/imagens)

# Supported tags and respective `Dockerfile` links

- [`teste`](https://github.com/igorferreir4/docker/blob/main/imagens/jellyfin/teste/Dockerfile)
- [`10.8.7`,`latest`](https://github.com/igorferreir4/docker/blob/main/imagens/jellyfin/10.8.7/Dockerfile)

# How to use
```sh
version: '3.5'
services:
  jellyfin:
    image: igorferreir4/jellyfin
    container_name: jellyfin
    network_mode: 'host'
    volumes:
      - /path/to/config:/config
      - /path/to/cache:/cache
      - /path/to/media:/media:ro
    restart: 'unless-stopped'
```

Then just connect to the address http://localhost:8096 or replace localhost with your ip.