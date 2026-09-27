# Kendi sunucunuzda barındırmak için: iki aşamalı derleme, sonuç ~25 MB
FROM alpine:3.20 AS build
ARG HUGO_VERSION=0.166.0
RUN apk add --no-cache curl tar \
 && curl -sSL "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_linux-amd64.tar.gz" \
    | tar xz -C /usr/local/bin hugo
WORKDIR /src
COPY . .
RUN hugo --minify

FROM nginx:1.27-alpine
COPY --from=build /src/public /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
