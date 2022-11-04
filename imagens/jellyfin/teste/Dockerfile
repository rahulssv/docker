FROM alpine:3.16.2

ENV HEALTHCHECK_URL=http://localhost:8096/health

RUN apk add --no-cache ffmpeg \
    libsrt \
    dotnet6-runtime \
    aspnetcore6-runtime \
    && apk add --no-cache jellyfin jellyfin-web --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community \
    && mkdir -p /config /cache \
    && rm -r /media/*

WORKDIR /

EXPOSE 8096
VOLUME /cache /config
ENTRYPOINT ["jellyfin", \
    "--datadir", "/config", \
    "--cachedir", "/cache", \
    "--ffmpeg", "/usr/bin/ffmpeg"]

HEALTHCHECK --interval=30s --timeout=30s --start-period=10s --retries=3 \
    CMD curl -Lk -fsS "${HEALTHCHECK_URL}" || exit 1