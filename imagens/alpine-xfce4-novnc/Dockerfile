FROM alpine:3.17

COPY config /etc/skel/.config

RUN set -xe && \
  apk add --no-cache --repository=https://dl-cdn.alpinelinux.org/alpine/edge/testing && \
  apk --update --no-cache add xvfb x11vnc xfce4 xfce4-terminal paper-icon-theme chromium python3 bash sudo htop procps && \
  mkdir -p /usr/share/wallpapers && \
  echo "CHROMIUM_FLAGS=\"--no-sandbox --no-first-run --disable-gpu\"" >> /etc/chromium/chromium.conf && \
  addgroup alpine && \
  adduser -G alpine -s /bin/bash -D alpine && \
  echo "alpine:alpine" | /usr/sbin/chpasswd && \
  echo "alpine ALL=NOPASSWD: ALL" >> /etc/sudoers

COPY android-5-0-lollipop-material-5355.jpg /usr/share/wallpapers/android-5-0-lollipop-material-5355.jpg

USER alpine

ENV USER=alpine \
    DISPLAY=:1 \
    LANG=pt_BR.UTF-8 \
    LANGUAGE=pt_BR.UTF-8 \
    HOME=/home/alpine \
    TERM=xterm \
    SHELL=/bin/bash \
    VNC_PASSWD=alpinelinux \
    VNC_PORT=5900 \
    VNC_RESOLUTION=1024x768 \
    VNC_COL_DEPTH=24  \
    NOVNC_PORT=6080 \
    NOVNC_HOME=/home/alpine/noVNC 

RUN set -xe && \
  sudo apk --update add ca-certificates && \
  sudo update-ca-certificates && \
  mkdir -p $NOVNC_HOME/utils/websockify && \
  wget -qO- https://github.com/novnc/noVNC/archive/v1.3.0.tar.gz | tar xz --strip 1 -C $NOVNC_HOME && \
  wget -qO- https://github.com/novnc/websockify/archive/v0.10.0.tar.gz | tar xzf - --strip 1 -C $NOVNC_HOME/utils/websockify && \
  chmod +x -v $NOVNC_HOME/utils/novnc_proxy && \
  ln -s $NOVNC_HOME/vnc_lite.html $NOVNC_HOME/index.html && \
  sudo rm -rf /var/cache/apk/*

WORKDIR $HOME
EXPOSE $VNC_PORT $NOVNC_PORT

COPY run_novnc /usr/bin/

CMD ["run_novnc"]
