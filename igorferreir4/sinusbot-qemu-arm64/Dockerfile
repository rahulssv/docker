FROM --platform=linux/amd64 sinusbot/docker:latest

RUN apt update && apt install xz-utils python3 -y

RUN mkdir /home/temp \
    && cd /home/temp \
    && curl -L https://github.com/yt-dlp/FFmpeg-Builds/releases/download/latest/ffmpeg-master-latest-linux64-gpl.tar.xz -o ffmpeg.tar.xz \
    && tar -xf ffmpeg.tar.xz \
    && cd /home/temp/ffmpeg-master-latest-linux64-gpl/bin \
    && cp * /usr/local/bin/ \
    && cd /usr/local/bin/ \
    && ffmpeg -version \
    && rm /usr/local/bin/youtube-dl \
    && curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o yt-dlp \
    && chmod +x yt-dlp \
    && ln -s /usr/local/bin/yt-dlp /usr/local/bin/youtube-dl \
    && rm -r /home/temp/