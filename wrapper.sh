#!/usr/bin/env bash
PORT=${PORT:-8080}

# 1) Dummy HTTP para health checks en el puerto esperado
while true; do
  echo -e "HTTP/1.1 200 OK\n\nok" | nc -l -p "$PORT"
done &

# 2) Ejecuta el enricher real con Java
exec java \
  -Dnashorn.args=--language=es6 \
  -jar /home/snowplow/lib/com.snowplowanalytics.snowplow-enrich-pubsub-5.3.0-launcher.jar \
  --enrichments=/enrichments \
  --iglu-config=/config/resolver.json \
  --config=/config/config.hocon
