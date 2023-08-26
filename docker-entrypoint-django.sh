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

# copy icons to root
cp /vue/favicon.ico /www/favicon.ico
cp /vue/favicon-16x16.png /www/favicon-16x16.png
cp /vue/favicon-32x32.png /www/favicon-32x32.png
cp /vue/manifest.webmanifest /www/manifest.webmanifest
cp /vue/apple-touch-icon.png /www/apple-touch-icon.png
cp /vue/android-chrome-192x192.png /www/android-chrome-192x192.png
cp /vue/android-chrome-512x512.png /www/android-chrome-512x512.png
cp /vue/safari-pinned-tab.svg /www/safari-pinned-tab.svg
cp /vue/browserconfig.xml /www/browserconfig.xml
cp /vue/mstile-150x150.png /www/mstile-150x150.png

cp /version.txt /www/version.txt

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
