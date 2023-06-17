#!/bin/bash

# apply database migrations
python manage.py migrate --noinput

# collect static files
python manage.py collectstatic --noinput

# python manage.py runserver 0.0.0.0:8000

# copy vue files to www
cp -a /vue/. /www/app/
rm /www/app/index.html

# Start Gunicorn processes
echo Starting Gunicorn.

exec gunicorn \
   --preload \
   --bind 0.0.0.0:8000 \
   --name app \
   --workers 3 \
   --log-level=info \
   --capture-output --enable-stdio-inheritance \
   --log-file=/app/logs/gunicorn.log \
   --access-logfile=/app/logs/access.log \
   obozstudentowProject.wsgi:application
