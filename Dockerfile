# Use official n8n image and add FFmpeg
FROM n8nio/n8n:latest

# Switch to root to install packages
USER root

# Install FFmpeg (Debian-based image uses apt-get)
RUN apt-get update && apt-get install -y --no-install-recommends \
    ffmpeg \
    fonts-dejavu \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create working directory for clips
RUN mkdir -p /tmp/viral-clips && chown -R node:node /tmp/viral-clips

# Switch back to node user
USER node

WORKDIR /home/node

EXPOSE 5678
