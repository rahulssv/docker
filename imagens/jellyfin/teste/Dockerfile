FROM alpine:3.16.2

ENV JF_VERSION=10.8.7
ENV HEALTHCHECK_URL=http://localhost:8096/health

WORKDIR /tmp
RUN apk add --update --no-cache \
    ffmpeg \
    curl \
    dotnet6-runtime \
    aspnetcore6-runtime && \
    set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		x86_64)  binArch='amd64-musl'; checksum='88ed1c10a4ded9e5bbe9f18a6e5773449b8b3135c7690224f3c8e07f996352a3' ;; \
        armv7)   binArch='armhf'; checksum='3dec2d3b62a0976701df6397339f10b4641ce019267fe6d95db939dc90a36a6b' ;; \
		aarch64) binArch='arm64'; checksum='bc252c4365ef1aa485a6f3115ae3be8ca3d0eb53ed7801b2439483d65b11ac5b' ;; \
		*) echo >&2 "error: unsupported architecture ($apkArch)"; exit 1 ;;\
	esac; \
	wget -O jf.tar.gz "https://repo.jellyfin.org/releases/server/linux/versions/stable/combined/${JF_VERSION}/jellyfin_${JF_VERSION}_${binArch}.tar.gz"; \
	echo "$checksum  jf.tar.gz" | sha256sum -c - \
    && mkdir -p /jellyfin /config /cache \
    && tar -oxzf jf.tar.gz \
    && rm jf.tar.gz \
    && cp -r jellyfin_${JF_VERSION}/* /jellyfin/ \
    && rm -r * \
    && cd /jellyfin \
    && mv jellyfin jellyfinAPP \
    && rm -r /media/*

WORKDIR /

EXPOSE 8096
VOLUME /cache /config
ENTRYPOINT ["./jellyfin/jellyfinAPP", \
    "--datadir", "/config", \
    "--cachedir", "/cache", \
    "--ffmpeg", "/usr/bin/ffmpeg"]

HEALTHCHECK --interval=30s --timeout=30s --start-period=10s --retries=3 \
    CMD curl -Lk -fsS "${HEALTHCHECK_URL}" || exit 1