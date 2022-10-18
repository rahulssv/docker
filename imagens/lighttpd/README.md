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
