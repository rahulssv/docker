#!/bin/ash

# terminate on errors
set -e

# Check if volume is empty
if [ ! "$(ls -A "/phpbb/www" 2>/dev/null)" ]; then
    echo 'Setting up phpbb volume'
    # Unzip phpbb from /tmp/www src to volume
    unzip /tmp/www/phpbb3.zip -d /phpbb/www
    # Copy config.php to /phpbb/www
    cp /tmp/config.php /phpbb/www/config.php
    # Fix chown
    chown -R phpbb.phpbb /phpbb
fi

[[ "${PHPBB_INSTALL}" = "true" ]] && rm config.php
[[ "${PHPBB_INSTALL}" != "true" ]] && rm -rf install

db_wait() {
        if [[ "${PHPBB_DB_WAIT}" = "true" &&  "${PHPBB_DB_DRIVER}" != "sqlite3" && "${PHPBB_DB_DRIVER}" != "sqlite" ]]; then
            until nc -z ${PHPBB_DB_HOST} ${PHPBB_DB_PORT}; do
                echo "$(date) - waiting for database on ${PHPBB_DB_HOST}:${PHPBB_DB_PORT} to start before applying migrations"
                sleep 3
            done
        fi
}

db_migrate() {
    if [[ "${PHPBB_DB_AUTOMIGRATE}" = "true" && "${PHPBB_INSTALL}" != "true" ]]; then
        echo "$(date) - applying migrations"
        su-exec phpbb php81 bin/phpbbcli.php db:migrate
    fi
}

usermod --non-unique --uid $PUID phpbb

groupmod --non-unique --gid $PGID phpbb

chown -R phpbb.phpbb /phpbb

exec /usr/bin/supervisord -c /etc/supervisord.conf "$@"