#!/bin/bash
set -eo pipefail
shopt -s nullglob

echo "$0: running pre scripts"
for f in /docker-entrypoint-initdb.d/*; do
  case "$f" in
    *.sh)     echo "$0: running $f"; . "$f" ;;
    *)        echo "$0: ignoring $f" ;;
  esac
done
echo "$0: finished pre scripts"

exec "docker-entrypoint.sh" "$@"
