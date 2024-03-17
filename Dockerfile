# syntax=docker/dockerfile:1.3

FROM node:lts-alpine as vue

# make the 'app' folder the current working directory
WORKDIR /app

# copy both 'package.json' and 'package-lock.json' (if available)
COPY ./vue/package*.json ./

# install project dependencies
RUN npm install

# copy project files and folders to the current working directory (i.e. 'app' folder)
COPY ./vue/ ./

ARG VUE_APP_API_URL
ENV VUE_APP_API_URL=$VUE_APP_API_URL

ARG VUE_APP_WS_API_PROTOCOL
ENV VUE_APP_WS_API_PROTOCOL=$VUE_APP_WS_API_PROTOCOL

# build app for production with minification
RUN npx vite build --base=/app/




# ----- DJANGO -----
FROM python:3.12-slim as django

# This prevents Python from writing out pyc files
ENV PYTHONDONTWRITEBYTECODE 1

# This keeps Python from buffering stdin/stdout
ENV PYTHONUNBUFFERED 1

EXPOSE 8000

WORKDIR /app


COPY ./django .
COPY ./docker-entrypoint-django.sh ./docker-entrypoint.sh

COPY --from=vue /app/dist /vue
COPY --from=vue /app/dist/index.html /app/templates/app.html

RUN mkdir -p ./assets
RUN mkdir -p ./logs 
RUN chmod 755 .  
RUN chmod 755 ./docker-entrypoint.sh
# RUN pip3 install --no-cache-dir -r ./requirements.txt
RUN --mount=type=cache,target=/root/.cache/pip \
    pip3 install -r ./requirements.txt

RUN --mount=type=cache,target=/root/.cache/pip \
    pip3 install 'uvicorn[standard]' gunicorn psycopg2-binary

CMD ["/app/docker-entrypoint.sh", "-n"]