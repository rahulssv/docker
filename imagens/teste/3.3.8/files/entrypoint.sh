#!/bin/ash

# terminate on errors
set -e

usermod --non-unique --uid $PUID phpbb

groupmod --non-unique --gid $PGID phpbb

chown -R phpbb.phpbb /phpbb

# Check if volume is empty
if [ ! "$(ls -A "/phpbb/www" 2>/dev/null)" ]; then
    echo 'Setting up phpbb volume'
    # Unzip phpbb from /tmp/www src to volume
    unzip /tmp/www/phpbb3.zip -d /phpbb/www
    # Copy config.php to /phpbb/www
    # cp /tmp/config.php /phpbb/www/config.php
    # Fix chown
    chown -R phpbb.phpbb /phpbb
fi

exec "$@"