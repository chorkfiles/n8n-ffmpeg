# Stage 1: Download static FFmpeg
FROM alpine:latest AS ffmpeg-downloader
RUN apk add --no-cache wget xz
RUN wget https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-amd64-static.tar.xz -O /tmp/ffmpeg.tar.xz && \
    cd /tmp && \
    tar xf ffmpeg.tar.xz && \
    mv ffmpeg-*-amd64-static/ffmpeg /usr/local/bin/ffmpeg && \
    mv ffmpeg-*-amd64-static/ffprobe /usr/local/bin/ffprobe

# Stage 2: n8n with FFmpeg
FROM n8nio/n8n:latest

USER root

# Copy static FFmpeg binaries
COPY --from=ffmpeg-downloader /usr/local/bin/ffmpeg /usr/local/bin/ffmpeg
COPY --from=ffmpeg-downloader /usr/local/bin/ffprobe /usr/local/bin/ffprobe
RUN chmod +x /usr/local/bin/ffmpeg /usr/local/bin/ffprobe

# Create directories
RUN mkdir -p /home/node/.n8n /tmp/viral-clips

WORKDIR /home/node

EXPOSE 5678
