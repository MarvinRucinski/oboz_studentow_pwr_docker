#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

LOG_DIR="/app/logs"
mkdir -p "$LOG_DIR" 2>/dev/null || true

if [ -w "$LOG_DIR" ]; then
	PID_FILE="$LOG_DIR/celerybeat.pid"
	LOGFILE="$LOG_DIR/celery-beat.log"
else
	PID_FILE="/tmp/celerybeat.pid"
	LOGFILE="/dev/stdout"
fi

rm -f "$PID_FILE"


CMD=(celery -A obozstudentowProject beat \
	-l "${CELERY_LOG_LEVEL:-INFO}" \
	--scheduler "${CELERY_SCHEDULER:-django_celery_beat.schedulers:DatabaseScheduler}" \
	--pidfile "$PID_FILE" \
	--logfile "$LOGFILE")

echo "Starting Celery beat as $(id -u):$(id -g) with broker ${CELERY_BROKER} -> ${CMD[*]}"
exec "${CMD[@]}"