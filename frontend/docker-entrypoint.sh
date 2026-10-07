#!/bin/sh
set -e

# Подставляем только нужные переменные, оставляя nginx-переменные ($host, $uri...) нетронутыми
envsubst '$BACKEND_HOST $BACKEND_PORT' \
    < /usr/local/nginx/conf/nginx.conf.template \
    > /usr/local/nginx/conf/nginx.conf

# Передаём управление оригинальному CMD
exec "$@"