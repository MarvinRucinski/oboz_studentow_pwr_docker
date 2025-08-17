#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

# Allow optional concurrency override
CONCURRENCY=${CELERY_CONCURRENCY:-0}
if [ "$CONCURRENCY" -gt 0 ]; then
	CONCURRENCY_ARGS="-c $CONCURRENCY"
else
	CONCURRENCY_ARGS=""
fi

# Use a dedicated log directory if writable
LOG_DIR="/app/logs"
if [ -w "$LOG_DIR" ]; then
	LOGFILE="$LOG_DIR/celery-worker.log"
else
	LOGFILE="/dev/stdout"
fi

# Fallback default if not provided via env
if [ -z "${CELERY_BROKER:-}" ]; then
  export CELERY_BROKER="redis://redis:6379/0"
fi

CMD=(celery -A obozstudentowProject worker \
	-l "${CELERY_LOG_LEVEL:-INFO}" \
	$CONCURRENCY_ARGS \
	--queues="${CELERY_QUEUES:-default}" \
	--hostname="worker@%h" \
	--logfile "$LOGFILE")

echo "Starting Celery worker as $(id -u):$(id -g) with broker ${CELERY_BROKER} -> ${CMD[*]}"
exec "${CMD[@]}"