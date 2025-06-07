 docker run -it --rm \
  --network host \
  -v "$PWD/snowplow/config:/config" \
  -v "$PWD/snowplow/enrichments:/enrichments" \
  -v "$PWD/snowplow/key.json:/snowplow-gcp-account.json" \
  -e GOOGLE_APPLICATION_CREDENTIALS=/snowplow-gcp-account.json \
  -e JAVA_OPTS="-Dorg.slf4j.simpleLogger.defaultLogLevel=debug -Dlogging.level.com.snowplowanalytics=debug" \
  snowplow/snowplow-enrich-pubsub:5.3.0 \
  --enrichments /enrichments \
  --iglu-config /config/resolver.json \
  --config /config/config.hocon

  docker run -d \
  --restart=always \
  --name enrich-pubsub \
  --network host \
  -v "$PWD/snowplow/config:/config" \
  -v "$PWD/snowplow/enrichments:/enrichments" \
  -v "$PWD/snowplow/key.json:/snowplow-gcp-account.json" \
  -e GOOGLE_APPLICATION_CREDENTIALS=/snowplow-gcp-account.json \
  -e JAVA_OPTS="-Dorg.slf4j.simpleLogger.defaultLogLevel=debug -Dlogging.level.com.snowplowanalytics=debug" \
  snowplow/snowplow-enrich-pubsub:5.3.0 \
  --enrichments /enrichments \
  --iglu-config /config/resolver.json \
  --config /config/config.hocon


