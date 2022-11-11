#!/bin/ash

# terminate on errors
set -e

usermod --non-unique --uid $PUID phpbb

groupmod --non-unique --gid $PGID phpbb

chown -R phpbb.phpbb /phpbb/www

# Check if volume is empty
if [ ! "$(ls -A "/var/www/wordpress" 2>/dev/null)" ]; then
    echo 'Setting up wordpress volume'
    # Copy Wordpress from /tmp src to volume
    cp -r /tmp/wordpress/* /var/www/wordpress/
    chown -R phpbb.phpbb /phpbb/www

    # Generate secrets
    curl -f https://api.wordpress.org/secret-key/1.1/salt/ >> /var/www/wordpress/wp-secrets.php
fi

exec "$@"