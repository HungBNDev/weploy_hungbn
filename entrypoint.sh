#!/bin/bash
set -e

rm -f /hungbn/tmp/pids/server.pid

exec "$@"
