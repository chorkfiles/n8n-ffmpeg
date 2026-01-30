# Use official n8n image and add FFmpeg
FROM n8nio/n8n:latest

# Switch to root to install packages
USER root

# Install FFmpeg (Alpine-based image uses apk)
RUN apk add --no-cache ffmpeg ttf-dejavu

# Create working directory for clips
RUN mkdir -p /tmp/viral-clips && chown -R node:node /tmp/viral-clips

# Switch back to node user
USER node

WORKDIR /home/node

EXPOSE 5678
