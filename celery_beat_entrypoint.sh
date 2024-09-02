#!/bin/sh

if [ "$DATABASE" = "postgres" ]
then
    echo "DB not yet run..."

    while ! nc -z $POSTGRES_HOST $POSTGRES_PORT; do
      sleep 0.1
    done

    echo "DB did run."
fi

celery -A project beat --loglevel=info

exec "$@"