#!/bin/bash

# apply database migrations
python manage.py migrate --noinput

# collect static files
python manage.py collectstatic --noinput

# python manage.py runserver 0.0.0.0:8000

# copy vue files to www
cp -a /vue/. /www/app/
rm /www/app/index.html
rm /www/app/firebase-messaging-sw.js

cp /vue/firebase-messaging-sw.js /www/firebase-messaging-sw.js

# Start Gunicorn processes
echo Starting Gunicorn.

exec gunicorn \
   --preload \
   --bind 0.0.0.0:8000 \
   --name app \
   --workers 3 \
   --forwarded-allow-ips="*" \
   --log-level=debug \
   --capture-output --enable-stdio-inheritance \
   --access-logfile '-' --error-logfile '-' \
   obozstudentowProject.wsgi:application
