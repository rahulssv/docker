# Use a base image that includes QEMU
FROM multiarch/qemu-user-static as qemu

# Use the original image
FROM debian:buster-slim

# Copy the QEMU binary from the QEMU image
COPY --from=qemu /usr/bin/qemu-x86_64-static /usr/bin

LABEL description="SinusBot - Discord only image"
LABEL version="1.0.2"

# Install dependencies and clean up afterwards
RUN dpkg --add-architecture amd64 && apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends ca-certificates bzip2 unzip curl python3 procps libpci3:amd64 libxslt1.1:amd64 libxkbcommon0:amd64 libc6:amd64 libstdc++6:amd64 locales && \
    rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/*

# Set locale
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && locale-gen
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en

WORKDIR /opt/sinusbot

ADD install.sh .
RUN chmod 755 install.sh

# Download/Install SinusBot
RUN bash install.sh sinusbot

# Download/Install yt-dlp
RUN bash install.sh yt-dlp

# Download/Install Text-to-Speech
RUN bash install.sh text-to-speech

ADD entrypoint.sh .
RUN chmod 755 entrypoint.sh

EXPOSE 8087

VOLUME ["/opt/sinusbot/data", "/opt/sinusbot/scripts"]

ENTRYPOINT ["/opt/sinusbot/entrypoint.sh"]

HEALTHCHECK --interval=1m --timeout=10s \
  CMD curl --no-keepalive -f http://localhost:8087/api/v1/botId || exit 1