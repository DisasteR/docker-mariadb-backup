#!/bin/bash
set -eo pipefail
shopt -s nullglob

for f in /docker-entrypoint-initdb.d/*; do
  case "$f" in
    *.sh)     echo "$0: running $f"; . "$f" ;;
    *)        echo "$0: ignoring $f" ;;
  esac
done

exec "$@"
