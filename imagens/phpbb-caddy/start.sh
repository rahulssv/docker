#!/bin/sh

caddy run --config /etc/caddy/Caddyfile --adapter caddyfile
php-fpm81 -F