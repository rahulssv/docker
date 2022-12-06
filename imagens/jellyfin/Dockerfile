FROM alpine:3.17

RUN apk add --update --upgrade --no-cache ffmpeg aspnetcore6-runtime

RUN wget https://repo.jellyfin.org/releases/server/portable/versions/stable/combined/10.8.8/jellyfin_10.8.8.tar.gz && \
    tar xvzf jellyfin_10.8.8.tar.gz && \
    rm jellyfin_10.8.8.tar.gz && \
    mv jellyfin_10.8.8 jellyfin

CMD dotnet /jellyfin/jellyfin.dll