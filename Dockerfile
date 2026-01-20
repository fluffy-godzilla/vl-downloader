FROM node:lts-alpine AS builder
WORKDIR /vl-downloader
COPY . .

RUN npm install -g pnpm
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
RUN pnpm run ci
RUN pnpm run build

FROM node:lts-alpine
WORKDIR /vl-downloader
RUN apk add --no-cache \
    chromium \
    nss \
    freetype \
    harfbuzz \
    ca-certificates \
    ttf-freefont \
    redis \
    shadow

COPY --from=builder /vl-downloader/src ./src
COPY --from=builder /vl-downloader/package.json ./package.json
COPY --from=builder /vl-downloader/pnpm-lock.yaml ./pnpm-lock.yaml
COPY --from=builder /vl-downloader/pnpm-workspace.yaml ./pnpm-workspace.yaml
COPY --from=builder /vl-downloader/src/backend/.env.default ./.env

RUN npm install -g pnpm
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser
RUN pnpm run ci-prod

# place everything in its final location and clean up
RUN mv src/backend/dist ./backend
RUN mv src/frontend/dist ./frontend
RUN cp -r src/backend/node_modules .
RUN cp -r src/backend/node_modules .
RUN rm -rf src package.json pnpm-lock.yaml pnpm-workspace.yaml

COPY docker/entrypoint.sh /docker/entrypoint.sh

VOLUME /vl-downloader/backend/downloads

ENV PORT=3500
EXPOSE $PORT

ENV PUID=1000
ENV PGID=1000

# add the user that will be running the backend
RUN groupadd --non-unique --gid $PGID abc
RUN useradd --non-unique --create-home --uid $PUID --gid abc abc

ENTRYPOINT  ["sh", "/docker/entrypoint.sh"]
