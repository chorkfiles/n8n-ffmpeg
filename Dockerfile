FROM node:20-alpine

RUN apk add --no-cache ffmpeg ttf-dejavu su-exec tini

RUN npm install -g n8n

RUN addgroup -S n8n && adduser -S -G n8n n8n \
    && mkdir -p /home/n8n/.n8n /tmp/viral-clips \
    && chown -R n8n:n8n /home/n8n /tmp/viral-clips

USER n8n
WORKDIR /home/n8n

ENV N8N_USER_FOLDER=/home/n8n/.n8n

EXPOSE 5678

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["n8n", "start"]
