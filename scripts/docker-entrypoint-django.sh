#!/bin/bash

# apply database migrations
python manage.py migrate --noinput

# collect static files
python manage.py collectstatic --noinput

# Start Gunicorn processes
echo Starting Gunicorn.

exec gunicorn \
   --preload \
   --bind 0.0.0.0:8000 \
   --name app \
   --workers 3 \
   -k uvicorn.workers.UvicornWorker \
   --forwarded-allow-ips="*" \
   --log-level=debug \
   --capture-output --enable-stdio-inheritance \
   --access-logfile '-' --error-logfile '-' \
   obozstudentowProject.asgi:application
