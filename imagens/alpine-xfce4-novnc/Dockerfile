#
FROM alpine:3.17

ENV NOVNC_TAG="v1.3.0"

ENV WEBSOCKIFY_TAG="v0.10.0"

ENV VNC_SERVER "localhost:5900"

RUN apk --no-cache --update --upgrade add \
    bash \
    python3 \
    python3-dev \
    gfortran \
    py-pip \
    build-base \
    procps \
    git

RUN pip install --no-cache-dir numpy

# RUN ln -s /usr/bin/python3 /usr/bin/python

RUN git config --global advice.detachedHead false && \
    git clone https://github.com/novnc/noVNC --branch ${NOVNC_TAG} /root/noVNC && \
    git clone https://github.com/novnc/websockify --branch ${WEBSOCKIFY_TAG} /root/noVNC/utils/websockify

RUN cp /root/noVNC/vnc.html /root/noVNC/index.html

COPY config /etc/skel/.config
RUN set -xe && \
    apk add --no-cache --repository=https://dl-cdn.alpinelinux.org/alpine/edge/testing arc-theme && \
    apk --update --no-cache add xvfb x11vnc xfce4 xfce4-terminal paper-icon-theme chromium htop  && \
    mkdir -p /usr/share/wallpapers && \
    echo "CHROMIUM_FLAGS=\"--no-sandbox --no-first-run --disable-gpu\"" >> /etc/chromium/chromium.conf

COPY bg.jpg /usr/share/wallpapers/bg.jpg

ENV USER=root \
    DISPLAY=:1 \
    LANG=pt_BR.UTF-8 \
    LANGUAGE=pt_BR.UTF-8 \
    HOME=/root \
    TERM=xterm \
    SHELL=/bin/bash \
    VNC_PASSWD=alpinelinux \
    VNC_PORT=5900 \
    VNC_RESOLUTION=1024x768 \
    VNC_COL_DEPTH=24  \
    NOVNC_PORT=6080 \
    NOVNC_HOME=/root/noVNC

COPY run_novnc /usr/bin/
RUN chmod +x /usr/bin/run_novnc

RUN sed -i "/wait ${proxy_pid}/i if [ -n \"\$AUTOCONNECT\" ]; then sed -i \"s/'autoconnect', false/'autoconnect', '\$AUTOCONNECT'/\" /root/noVNC/app/ui.js; fi" /root/noVNC/utils/novnc_proxy

RUN sed -i "/wait ${proxy_pid}/i if [ -n \"\$VNC_PASSWORD\" ]; then sed -i \"s/WebUtil.getConfigVar('password')/'\$VNC_PASSWORD'/\" /root/noVNC/app/ui.js; fi" /root/noVNC/utils/novnc_proxy

RUN sed -i "/wait ${proxy_pid}/i if [ -n \"\$VIEW_ONLY\" ]; then sed -i \"s/UI.rfb.viewOnly = UI.getSetting('view_only');/UI.rfb.viewOnly = \$VIEW_ONLY;/\" /root/noVNC/app/ui.js; fi" /root/noVNC/utils/novnc_proxy

CMD ["/usr/bin/run_novnc"]
# ENTRYPOINT [ "bash", "-c", "/root/noVNC/utils/novnc_proxy --vnc ${VNC_SERVER}" ]
