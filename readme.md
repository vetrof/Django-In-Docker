# Django Docker Project

Этот проект представляет собой заготовку для развертывания Django-приложения в Docker. Он включает все необходимые контейнеры, такие как веб-сервер, Celery, база данных PostgreSQL, Redis и Nginx, а также Flower для мониторинга задач Celery.

## Структура проекта

Проект включает следующие Docker-сервисы:

- **web**: Основной сервис, содержащий Django-приложение.
- **celery**: Сервис для выполнения фоновых задач с использованием Celery.
- **celery_beat**: Сервис для запуска периодических задач Celery.
- **db**: Контейнер с PostgreSQL для хранения данных.
- **nginx**: Nginx-сервер, использующийся в качестве обратного прокси и для обслуживания статических файлов.
- **redis**: Redis-сервер для очередей задач Celery.
- **flower**: Интерфейс для мониторинга задач Celery.

## .env
SERVER_NAME=localhost  
DEBUG=False  
ALLOWED_HOSTS=localhost, 127.0.0.1, localhost:8001  
CSRF_TRUSTED_ORIGINS=http://localhost:8000, http://localhost:8001, http://127.0.0.1:8001  
GUNICORN_WORKERS=2  
GUNICORN_THREADS=4
POSTGRES_ENGINE=django.db.backends.postgresql  
POSTGRES_DB=postgres_database  
POSTGRES_USER=postgres_user  
POSTGRES_PASSWORD=password
POSTGRES_HOST=db  
POSTGRES_PORT=5432  
DATABASE=postgres  
CELERY_BROKER_URL=redis://redis:6379/0

## run
````
docker-compose up --build
docker-compose exec web python manage.py migrate
docker-compose exec web python manage.py collectstatic --noinput
````

Порты
Web (Django): 8000 (доступен внутри контейнера, Nginx проксирует на 8001)  
Nginx: 8001 (доступен на хост-машине)  
Flower: 5555 (для мониторинга задач Celery)  

Для мониторинга задач Celery используйте Flower по адресу http://localhost:5555.


Этот `README.md` охватывает основные аспекты настройки и использования вашего Docker-проекта, включая инструкцию по запуску и настройке контейнеров, а также информацию о портах и мониторинге задач.  
Этот проект лицензирован под MIT License.