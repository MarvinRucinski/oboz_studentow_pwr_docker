
# ----- DJANGO -----
FROM python:3.12-slim AS django

# This prevents Python from writing out pyc files
ENV PYTHONDONTWRITEBYTECODE=1

# This keeps Python from buffering stdin/stdout
ENV PYTHONUNBUFFERED=1

EXPOSE 8000

WORKDIR /app


COPY ./django .
COPY ./scripts/docker-entrypoint-django.sh ./docker-entrypoint.sh
COPY ./scripts/start-celeryworker.sh ./scripts/start-celeryworker.sh
COPY ./scripts/start-celerybeat.sh ./scripts/start-celerybeat.sh

RUN mkdir -p ./assets
RUN mkdir -p ./logs 
RUN chmod 755 .  
RUN chmod 755 ./docker-entrypoint.sh ./scripts/start-celeryworker.sh ./scripts/start-celerybeat.sh
# RUN pip3 install --no-cache-dir -r ./requirements.txt
RUN --mount=type=cache,target=/root/.cache/pip \
    pip3 install -r ./requirements.txt

RUN --mount=type=cache,target=/root/.cache/pip \
    pip3 install 'uvicorn[standard]' gunicorn

# Create unprivileged user to run application processes (e.g., Celery) instead of root
RUN groupadd -r app && useradd -r -g app app

# Ensure writable directories for the app user (pidfiles, logs, media/static if mounted later)
RUN chown -R app:app /app

# NOTE: We keep running the web container as root for collectstatic permissions; adjust if desired.

CMD ["/app/docker-entrypoint.sh", "-n"]