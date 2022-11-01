# Github Repository

- [CLICK](https://github.com/igorferreir4/docker/tree/main/imagens)

# Supported tags and respective `Dockerfile` links

- [`edge`](https://github.com/igorferreir4/docker/blob/main/imagens/lighttpd/1.4.67-edge/Dockerfile.edge)
- [`1.4.64 , latest`](https://github.com/igorferreir4/docker/blob/main/imagens/lighttpd/1.4.64/Dockerfile.stable)

Image created for my personal use.
If you want to use it, at your own risk!

Created user "servidor" GUID and PUID 1001 to match host user.

Lighttpd Settings Folder: /etc/lighttpd

Server exposure folder: /srv

mod_fastcgi_fpm set to "php-fpm:9000"



# docker-compose.yml:
```sh
  lighttpd:
    image: igorsf/lighttpd-gh:1.4.64-r0
    container_name: lighttpd
    volumes:
      - ./www:/srv
      - ./lighttpd:/etc/lighttpd/
    ports:
      - "8080:80"
    tty: true
```


Source: [https://github.com/spujadas/lighttpd-docker](https://github.com/spujadas/lighttpd-docker)
