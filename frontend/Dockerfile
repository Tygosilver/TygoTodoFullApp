FROM gcc AS builder
WORKDIR /todo-app/frontend/nginx
COPY ./nginx .
RUN apt-get update && apt-get install -y \
    make \
    libpcre2-dev \
    zlib1g-dev
RUN auto/configure && \
    make && \
    make install

FROM debian:trixie-slim 
WORKDIR /

RUN apt-get update && apt-get install -y --no-install-recommends \
    libpcre2-8-0 \
    zlib1g \
    gettext-base \
    && rm -rf /var/lib/apt/lists/*


COPY --from=builder /usr/local/nginx /usr/local/nginx

COPY ./nginx.conf.template /usr/local/nginx/conf/nginx.conf.template

COPY ./docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

COPY ./index.html /usr/local/nginx/html

EXPOSE 80

ENTRYPOINT [ "/usr/local/bin/docker-entrypoint.sh" ]
CMD ["/usr/local/nginx/sbin/nginx", "-g", "daemon off;"]