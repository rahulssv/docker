#!/bin/ash

# terminate on errors
set -e

# Check if volume is empty
if [ ! "$(ls -A "/var/www/wordpress" 2>/dev/null)" ]; then
    echo 'Setting up wordpress volume'
    # Copy Wordpress from /tmp src to volume
    cp -r /tmp/wordpress/* /var/www/wordpress/
    chown -R caddy.caddy /var/www

    # Generate secrets
    curl -f https://api.wordpress.org/secret-key/1.1/salt/ >> /var/www/wordpress/wp-secrets.php

    # Clean /tmp folder
    rm -r /tmp/*
fi

usermod --non-unique --uid $PUID caddy

groupmod --non-unique --gid $PGID caddy

chown -R caddy.caddy /var/www

exec "$@"
