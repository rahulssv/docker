# phpBB3 docker image

Lightweight, Alpine based [phpBB](https://www.phpbb.com/) docker image.

- Forked from: [selim13](https://github.com/selim13/docker-phpbb)
- Added theme: [Prosilver Dark Edition](https://www.phpbb.com/customise/db/style/prosilver_dark/)
- Added extensions: [Media Embed PlugIn](https://www.phpbb.com/customise/db/extension/mediaembed), [Advanced BBCode Box](https://www.phpbb.com/customise/db/extension/advanced_bbcode_box/)
- Added pt_BR language support

# Supported tags and respective `Dockerfile` links

- [`3.3.8`, `latest`](https://github.com/igorferreir4/docker/blob/main/imagens/phpbb/Dockerfile) bundled with PHP 8.1.12

# How to use this image

## Initial installation

```sh
version: '3'

services:
  phpbb:
    image: igorferreir4/phpbb:3.3.8
    container_name: phpbb
    ports:
      - '8888:80'
    volumes:
      - ./phpbb/sqlite:/phpbb/sqlite
      - ./phpbb/files:/phpbb/www/files
      - ./phpbb/store:/phpbb/www/store
      - ./phpbb/avatars:/phpbb/www/images/avatars/upload
    environment:
      - PHPBB_INSTALL=true
      - PUID=65432
      - PGID=65432
      - PHPBB_DB_AUTOMIGRATE=true
      - PHPBB_DB_DRIVER=mysqli
      - PHPBB_DB_HOST=db-host
      - PHPBB_DB_PORT=3306
      - PHPBB_DB_NAME=db-name
      - PHPBB_DB_USER=db-user
      - PHPBB_DB_PASSWD=db-user-password
```
To use sqlite3, just use "PHPBB_INSTALL=true", ignoring all other environments, except PUID and PGID.

In all cases, after installing, comment out the line: PHPBB_INSTALL=true

```sh
version: '3'

services:
  phpbb:
    image: igorferreir4/phpbb:3.3.8
    container_name: phpbb
    ports:
      - '8888:80'
    volumes:
      - ./phpbb/sqlite:/phpbb/sqlite
      - ./phpbb/files:/phpbb/www/files
      - ./phpbb/store:/phpbb/www/store
      - ./phpbb/avatars:/phpbb/www/images/avatars/upload
    environment:
      # - PHPBB_INSTALL=true
      - PUID=65432
      - PGID=65432
```

## Environment variables 

This image utilises environment variables for basic configuration. Most of
them are passed directly to phpBB's `config.php` or to the startup script.

### PUID and PGID
When using volumes, permissions issues can arise between the host OS and the container, we avoid this issue by allowing you to specify the user PUID and group PGID.

Ensure any volume directories on the host are owned by the same user you specify and any permissions issues will vanish like magic.

In this instance PUID=65432 and PGID=65432, to find yours use id user as below:
```sh
$ id username
    uid=65432(phpbb) gid=65432(phpbb) groups=65432(phpbb)
```

### PHPBB_INSTALL
If set to `true`, container will start with an empty `config.php` file and
phpBB `/install/` directory intact. This will allow you to initilalize 
a forum database upon fresh installation.

### PHPBB_DB_DRIVER

Selects a database driver. phpBB3 ships with following drivers:
- `mysqli` - MySQL via newer php extension
- `postgres` - PostgreSQL
- `sqlite3` - SQLite 3

This image is bundled with support of `sqlite3`, `mysqli` and `postgres` drivers.

Default value: sqlite3
 
### PHPBB_DB_HOST

Database hostname or ip address.

For the SQLite3 driver sets database file path. 

Default value: /phpbb/sqlite/sqlite.db
 
### PHPBB_DB_PORT

Database port.

### PHPBB_DB_NAME

Supplies database name for phpBB3.

### PHPBB_DB_USER

Supplies a user name for phpBB3 database.

### PHPBB_DB_PASSWD

Supplies a user password for phpBB3 database.

If you feel paranoid about providing your database password in an environment
variable, you can always ship it with a custom `config.php` file using volumes
or by extending this image.

### PHPBB_DB_TABLE_PREFIX

Table prefix for phpBB3 database.

Default value: phpbb_ 

### PHPBB_DB_AUTOMIGRATE

If set to `true`, instructs a container to run database migrations by
executing `bin/phpbbcli.php db:migrate` on every startup.

If migrations fail, container will refuse to start.

### PHPBB_DB_WAIT
If set to `true`, container will wait for database service to become available.
You will need to explicitly set `PHPBB_DB_HOST` and `PHPBB_DB_PORT` for this
to work.

Use in conjunction with `PHPBB_DB_AUTOMIGRATE` to prevent running migrations
before database is ready.

Won't work for SQLite database engine as it is always available.

## Volumes

By default there are four volumes created for each container:
- /phpbb/sqlite
- /phpbb/www/files
- /phpbb/www/store
- /phpbb/www/images/avatars/upload

# Additional configuration

This image is based on a stock official Alpine image with apache2 and php81
packages from the Alpine Linux repository, so you can drop their custom 
configuration files to `/etc/apache2/conf.d` and `/etc/php81/conf.d`.

## Pass user's IP from proxy

If you are planning to start a container behind proxy 
(like [nginx-proxy](https://github.com/jwilder/nginx-proxy)), it will probably
be a good idea to get user's real IP instead of proxy one. For this, you can use
Apache RemoteIP module. Create a configuration file:

```apache
LoadModule remoteip_module modules/mod_remoteip.so

RemoteIPHeader X-Real-IP
RemoteIPInternalProxy nginx-proxy
```

Here `X-Real-IP` is a header name, where proxy passed user's real IP and
`nginx-proxy` is proxy host name.

Then push it to `/etc/apache2/conf.d/` directory, for example, by extending this
image:

```dockerfile
FROM igorferreir4/phpbb:3.3.8

COPY remoteip.conf /etc/apache2/conf.d
```
