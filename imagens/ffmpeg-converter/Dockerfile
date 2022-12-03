FROM alpine:3.17

LABEL maintainer="Igor Ferreira <igorsferreir4@gmail.com>"

RUN apk --update --upgrade --no-cache add ffmpeg bash

COPY convert.sh /usr/bin/convert.sh
RUN chmod +x /usr/bin/convert.sh

WORKDIR /media
VOLUME /media

CMD ["/usr/bin/convert.sh"]