FROM alpine:3.17

ENV JELLYFIN_VERSION=10.8.9

RUN apk add --update --upgrade --no-cache ffmpeg aspnetcore6-runtime

RUN wget -O jellyfin.tar.gz "https://repo.jellyfin.org/releases/server/portable/versions/stable/combined/$JELLYFIN_VERSION/jellyfin_$JELLYFIN_VERSION.tar.gz" && \
    tar xvzf jellyfin.tar.gz && \
    rm jellyfin.tar.gz && \
    mv jellyfin_$JELLYFIN_VERSION jellyfin

CMD dotnet /jellyfin/jellyfin.dll

ENV HEALTHCHECK_URL=http://localhost:8096/health

EXPOSE 8096
VOLUME /cache /config

ENTRYPOINT ["dotnet", \
    "/jellyfin/jellyfin.dll", \
    "--datadir", "/config", \
    "--cachedir", "/cache"]

HEALTHCHECK --interval=30s --timeout=30s --start-period=10s --retries=3 \
     CMD curl -Lk -fsS "${HEALTHCHECK_URL}" || exit 1