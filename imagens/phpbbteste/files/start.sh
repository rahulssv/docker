#!/bin/sh

set -e

# Check if volume is empty
if [ ! "$(ls -A "/phpbb/www" 2>/dev/null)" ]; then
    echo 'Setting up phpbb volume'
    # Unzip phpbb from /tmp src to volume
    unzip /tmp/phpbb3.zip -d /phpbb/www
    # Fix chown
    chown -R phpbb.phpbb /phpbb
fi

# Fix chown
usermod --non-unique --uid $PUID phpbb

groupmod --non-unique --gid $PGID phpbb

chown -R phpbb:phpbb /phpbb

# Start supervisor
/usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf