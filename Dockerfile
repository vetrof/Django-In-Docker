# образ на основе которого создаём контейнер
FROM python:3.8-slim

RUN mkdir -p /home/app

ENV HOME=/home/app
ENV APP_HOME=/home/app/web

RUN mkdir $APP_HOME
RUN mkdir $APP_HOME/static
RUN mkdir $APP_HOME/media

# рабочая директория внутри проекта
WORKDIR $APP_HOME

# переменные окружения для python
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Устанавливаем зависимости для Postgre
RUN apt-get update && apt-get -y install libcairo2-dev pkg-config python3-dev libpq-dev postgresql-contrib gcc netcat-traditional python3-cffi libpango-1.0-0 libpangoft2-1.0-0


# устанавливаем зависимости
RUN pip install --upgrade pip
COPY requirements.txt .
RUN pip install -r requirements.txt


# копируем содержимое текущей папки в контейнер
COPY . $APP_HOME

RUN chmod +x $APP_HOME/entrypoint.sh
RUN #chmod +x $APP_HOME/celery_entrypoint.sh
