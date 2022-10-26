#!/bin/sh

caddy run --config /etc/caddy/Caddyfile --adapter caddyfile
nohup php81