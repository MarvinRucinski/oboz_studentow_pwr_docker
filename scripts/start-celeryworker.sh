#!/bin/bash

set -o errexit
set -o nounset

celery -A obozstudentowProject worker -l INFO
