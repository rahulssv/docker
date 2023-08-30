FROM caddy:2.7.4-builder-alpine AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/WeidiDeng/caddy-cloudflare-ip \
    --with github.com/mholt/caddy-l4 \
    --with github.com/RussellLuo/caddy-ext/layer4

FROM caddy:2.7.4-alpine

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

# Change TZ to America/Sao_Paulo
RUN apk add --update --no-cache tzdata && \
    cp /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime && \
    echo "America/Sao_Paulo" >  /etc/timezone && \
    apk del tzdata && \
    rm -rf /var/cache/apk/*