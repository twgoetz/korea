FROM oven/bun:latest

WORKDIR /usr/src
COPY ./hexo/public ./public
COPY ./dist ./dist
EXPOSE 8080
CMD ["bun", "dist/index.js"]