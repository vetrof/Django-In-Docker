#!/bin/sh

if [ "$DATABASE" = "postgres" ]
then
    echo "DB not yet run..."

    while ! nc -z $POSTGRES_HOST $POSTGRES_PORT; do
      sleep 0.1
    done

    echo "DB did run."
fi

python manage.py migrate
#python manage.py collectstatic
gunicorn project.wsgi:application --bind 0.0.0.0:8000 --workers=$GUNICORN_WORKERS --threads=$GUNICORN_THREADS --reload

#gunicorn project.wsgi:application \
#  --bind 0.0.0.0:8000 \
#  --workers 9 \
#  --threads 4 \
#  --access-logfile /var/log/gunicorn/access.log \
#  --error-logfile /var/log/gunicorn/error.log \
#  --timeout 120

#daphne project.asgi:application -b 0.0.0.0 -p 8000

exec "$@"