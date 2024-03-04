#!/bin/bash

LOKI_API_URL="http://localhost:3100/loki/api/v1/push"

generate_random_status() {
  local statuses=("200" "400" "500")
  echo "${statuses[$((RANDOM % ${#statuses[@]}))]}"
}

generate_random_log() {
  local timestamp=$(date -u +%s%N)  # Timestamp in Unix epoch with nanoseconds
  local status=$(generate_random_status)
  echo "{\"streams\":[{\"stream\":{\"status_codes\":\"$status\"},\"values\":[[\"$timestamp\", \"value1\", \"value2\"]]}]}"
}

send_logs_to_loki() {
  local logs_count=$1
  for ((i = 1; i <= logs_count; i++)); do
    local log=$(generate_random_log)
    echo "Sending log: $log"
    curl -X POST -H "Content-Type: application/json" --data "$log" "$LOKI_API_URL"
    echo -e "\n"
    sleep 1  # Optional: Adjust the sleep duration between requests
  done
}

main() {
  local logs_to_send=500
  send_logs_to_loki "$logs_to_send"
}

main
