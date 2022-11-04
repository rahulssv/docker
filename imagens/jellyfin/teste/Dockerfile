### TESTE
FROM alpine:edge

RUN apk update && apk upgrade && \
    apk add --no-cache ffmpeg \
    libsrt \
    dotnet6-runtime \
    aspnetcore6-runtime \
    jellyfin \
    jellyfin-web \
    && mkdir -p /config /cache \
    && rm -r /media/*

WORKDIR /

EXPOSE 8096
VOLUME /cache /config
ENTRYPOINT ["jellyfin", \
    "--datadir", "/config", \
    "--cachedir", "/cache", \
    "--ffmpeg", "/usr/bin/ffmpeg"]




# ### TESTE
# FROM alpine:3.16.2

# RUN apk update && apk upgrade && \
#     apk add --no-cache ffmpeg \
#     libsrt \
#     dotnet6-runtime \
#     aspnetcore6-runtime \
#     && apk add --no-cache jellyfin jellyfin-web --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community \
#     && mkdir -p /config /cache \
#     && rm -r /media/*

# WORKDIR /

# EXPOSE 8096
# VOLUME /cache /config
# ENTRYPOINT ["jellyfin", \
#     "--datadir", "/config", \
#     "--cachedir", "/cache", \
#     "--ffmpeg", "/usr/bin/ffmpeg"]