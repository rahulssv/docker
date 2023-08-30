FROM caddy:2.7.4-alpine

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		x86_64)  binArch='amd64' ;; \
		aarch64) binArch='arm64' ;; \
		*) echo >&2 "error: unsupported architecture ($apkArch)"; exit 1 ;;\
	esac; \
	wget -O caddy "https://github.com/igorferreir4/caddy/releases/download/v2.7.4/caddy-linux-${binArch}"; \
	rm /usr/bin/caddy; \
    mv caddy /usr/bin; \
    chmod +x /usr/bin/caddy

# Change TZ to America/Sao_Paulo
RUN apk add --update --no-cache tzdata && \
    cp /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime && \
    echo "America/Sao_Paulo" >  /etc/timezone && \
    apk del tzdata && \
    rm -rf /var/cache/apk/*