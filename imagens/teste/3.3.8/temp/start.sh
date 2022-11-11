#!/bin/sh

usermod --non-unique --uid $PUID phpbb

groupmod --non-unique --gid $PGID phpbb

chown -R phpbb:phpbb /phpbb

set -e

[[ "${PHPBB_INSTALL}" = "true" ]] && rm config.php
[[ "${PHPBB_INSTALL}" != "true" ]] && rm -rf install

exec /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf "$@"