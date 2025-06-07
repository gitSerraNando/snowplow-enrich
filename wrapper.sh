#!/usr/bin/env bash
PORT=${PORT:-8080}

# 1) HTTP dummy para probes
while true; do
  echo -e "HTTP/1.1 200 OK\n\nok" | nc -l -p "$PORT"
done &

# 2) Ejecuta el loader/enrich en foreground
exec /usr/bin/bigquery-loader-pubsub \
  --enrichments=/enrichments \
  --iglu-config=/config/iglu.hocon \
  --config=/config/loader.hocon
