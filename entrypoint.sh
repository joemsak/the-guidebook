#!/bin/bash
set -e

FILE=/app/tmp/pids/server.pid
if test -f "$FILE"; then
  rm -f $FILE
fi

echo 'Starting webpack dev server ...' &
./bin/webpack-dev-server &

echo 'starting Rails server ...' &
bundle exec rails s -b 0.0.0.0
