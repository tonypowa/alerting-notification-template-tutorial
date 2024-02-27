#!/bin/bash

# This script generates random log messages in logfmt format and sends them to Loki using the Push API.
# For alternatives to send logs to Loki, refer to https://grafana.com/docs/loki/latest/send-data/

LOKI_URL="http://localhost:3100/loki/api/v1/push"
LOKI_APP_LABEL="alerting-demo"

MAX_LOGS=500
i=0

# Send a maximum of `MAX_LOGS` logs to Loki
while [ $i -lt $MAX_LOGS ]; do
	# unix epoch in nanoseconds
	log_time=$(($(date +%s) * 1000000000 + $(date +%N)))

	status_codes=(200 400 500)
	status_code=${status_codes[$RANDOM % ${#status_codes[@]}]}

	logfmt_message="url=/ status=$status_code level=info"

	curl -XPOST -H "Content-Type: application/json" -s $LOKI_URL \
		--data-raw "{\"streams\": [{\"stream\": {\"app\": \"$LOKI_APP_LABEL\"}, \"values\": [[\"$log_time\", \"$logfmt_message\"]] }] }"

	echo "$log_time $logfmt_message"

	if [ $? -ne 0 ]; then
		echo "curl command failed with status code. Use -v to see the full response"
	fi

	i=$((i+1))
done
