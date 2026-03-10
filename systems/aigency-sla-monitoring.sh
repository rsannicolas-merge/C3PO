#!/bin/bash
# AIgency SLA Monitoring Script
# Purpose: Monitor AIgency availability against 99.9% SLA (43.2 min/month downtime allowed)
# Risk: $10,000/month penalty for SLA breach
# Author: CISO Security Operations
# Created: 2026-03-09

set -euo pipefail

# Configuration
SYSTEM_NAME="AIgency"
ENDPOINT="${AIGENCY_ENDPOINT:-https://aigency.agency.gov/health}"
SLA_TARGET=99.9
PENALTY_AMOUNT=10000
CHECK_INTERVAL=60  # seconds
LOG_FILE="/var/log/sla-monitoring/aigency.log"
METRICS_FILE="/var/log/sla-monitoring/aigency-metrics.json"
ALERT_WEBHOOK="${SLACK_WEBHOOK:-https://hooks.slack.com/services/XXX}"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Ensure log directory exists
mkdir -p "$(dirname "$LOG_FILE")"

# Function to log messages
log_message() {
    local level=$1
    local message=$2
    local timestamp=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
    echo "[$timestamp] [$level] $message" >> "$LOG_FILE"

    if [[ "$level" == "ERROR" ]] || [[ "$level" == "CRITICAL" ]]; then
        echo -e "${RED}[$level]${NC} $message"
    elif [[ "$level" == "WARNING" ]]; then
        echo -e "${YELLOW}[$level]${NC} $message"
    else
        echo -e "${GREEN}[$level]${NC} $message"
    fi
}

# Function to check system availability
check_availability() {
    local start_time=$(date +%s%N)
    local http_code=$(curl -s -o /dev/null -w "%{http_code}" --max-time 10 "$ENDPOINT" || echo "000")
    local end_time=$(date +%s%N)
    local response_time=$(( (end_time - start_time) / 1000000 )) # Convert to milliseconds

    if [[ "$http_code" == "200" ]] || [[ "$http_code" == "204" ]]; then
        echo "UP:$response_time"
    else
        echo "DOWN:$http_code"
    fi
}

# Function to calculate current month SLA
calculate_monthly_sla() {
    local month_start=$(date -d "$(date +%Y-%m-01)" +%s)
    local current_time=$(date +%s)
    local month_duration=$((current_time - month_start))

    # Read metrics file if exists
    if [[ -f "$METRICS_FILE" ]]; then
        local downtime=$(jq -r '.current_month.downtime_seconds // 0' "$METRICS_FILE" 2>/dev/null || echo 0)
        local uptime_percentage=$(awk "BEGIN {printf \"%.3f\", 100 - ($downtime / $month_duration * 100)}")
        echo "$uptime_percentage"
    else
        echo "100.000"
    fi
}

# Function to update metrics
update_metrics() {
    local status=$1
    local response_time=$2
    local timestamp=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

    # Initialize metrics file if not exists
    if [[ ! -f "$METRICS_FILE" ]]; then
        cat > "$METRICS_FILE" <<EOF
{
    "system": "$SYSTEM_NAME",
    "sla_target": $SLA_TARGET,
    "penalty_per_month": $PENALTY_AMOUNT,
    "current_month": {
        "start": "$(date +%Y-%m-01T00:00:00Z)",
        "checks_total": 0,
        "checks_failed": 0,
        "downtime_seconds": 0,
        "uptime_percentage": 100.0
    },
    "last_check": {
        "timestamp": "$timestamp",
        "status": "$status",
        "response_time_ms": $response_time
    }
}
EOF
    fi

    # Update metrics
    local current_metrics=$(cat "$METRICS_FILE")
    local checks_total=$(echo "$current_metrics" | jq -r '.current_month.checks_total')
    local checks_failed=$(echo "$current_metrics" | jq -r '.current_month.checks_failed')
    local downtime=$(echo "$current_metrics" | jq -r '.current_month.downtime_seconds')

    checks_total=$((checks_total + 1))

    if [[ "$status" == "DOWN" ]]; then
        checks_failed=$((checks_failed + 1))
        downtime=$((downtime + CHECK_INTERVAL))
    fi

    # Calculate current SLA
    local current_sla=$(calculate_monthly_sla)

    # Update JSON
    jq --arg timestamp "$timestamp" \
       --arg status "$status" \
       --argjson response_time "$response_time" \
       --argjson checks_total "$checks_total" \
       --argjson checks_failed "$checks_failed" \
       --argjson downtime "$downtime" \
       --argjson uptime "$current_sla" \
       '.current_month.checks_total = $checks_total |
        .current_month.checks_failed = $checks_failed |
        .current_month.downtime_seconds = $downtime |
        .current_month.uptime_percentage = $uptime |
        .last_check.timestamp = $timestamp |
        .last_check.status = $status |
        .last_check.response_time_ms = $response_time' \
       "$METRICS_FILE" > "$METRICS_FILE.tmp" && mv "$METRICS_FILE.tmp" "$METRICS_FILE"
}

# Function to send alerts
send_alert() {
    local alert_type=$1
    local message=$2
    local current_sla=$(calculate_monthly_sla)

    # Prepare alert payload
    local payload=$(cat <<EOF
{
    "text": "🚨 *SLA Alert: $SYSTEM_NAME*",
    "attachments": [{
        "color": "danger",
        "fields": [
            {"title": "Alert Type", "value": "$alert_type", "short": true},
            {"title": "System", "value": "$SYSTEM_NAME", "short": true},
            {"title": "Current SLA", "value": "${current_sla}%", "short": true},
            {"title": "Target SLA", "value": "${SLA_TARGET}%", "short": true},
            {"title": "Risk", "value": "\$$PENALTY_AMOUNT/month penalty", "short": true},
            {"title": "Message", "value": "$message", "short": false}
        ],
        "footer": "SLA Monitor",
        "ts": $(date +%s)
    }]
}
EOF
)

    # Send to Slack
    if [[ -n "$ALERT_WEBHOOK" ]] && [[ "$ALERT_WEBHOOK" != *"XXX"* ]]; then
        curl -X POST -H 'Content-type: application/json' --data "$payload" "$ALERT_WEBHOOK" 2>/dev/null
    fi

    # Log alert
    log_message "ALERT" "$alert_type: $message"
}

# Function to generate daily report
generate_daily_report() {
    if [[ -f "$METRICS_FILE" ]]; then
        local report=$(jq -r '
            "=== AIgency SLA Daily Report ===\n" +
            "Date: " + .last_check.timestamp + "\n" +
            "Current Month SLA: " + (.current_month.uptime_percentage | tostring) + "%\n" +
            "Target SLA: " + (.sla_target | tostring) + "%\n" +
            "Total Checks: " + (.current_month.checks_total | tostring) + "\n" +
            "Failed Checks: " + (.current_month.checks_failed | tostring) + "\n" +
            "Downtime (seconds): " + (.current_month.downtime_seconds | tostring) + "\n" +
            "At Risk: $" + (if .current_month.uptime_percentage < .sla_target then .penalty_per_month else 0 end | tostring) + "\n" +
            "================================"
        ' "$METRICS_FILE")

        echo "$report"
        log_message "INFO" "Daily report generated"
    fi
}

# Main monitoring loop
main() {
    log_message "INFO" "Starting SLA monitoring for $SYSTEM_NAME"
    log_message "INFO" "Target SLA: ${SLA_TARGET}%, Penalty: \$$PENALTY_AMOUNT/month"

    local consecutive_failures=0
    local last_status="UP"

    while true; do
        # Check availability
        result=$(check_availability)
        IFS=':' read -r status value <<< "$result"

        if [[ "$status" == "UP" ]]; then
            response_time=$value

            if [[ "$last_status" == "DOWN" ]]; then
                send_alert "RECOVERY" "System is back online. Response time: ${response_time}ms"
            fi

            consecutive_failures=0
            log_message "INFO" "Health check passed. Response time: ${response_time}ms"

        else
            http_code=$value
            response_time=0
            consecutive_failures=$((consecutive_failures + 1))

            log_message "ERROR" "Health check failed. HTTP code: $http_code"

            # Alert on first failure
            if [[ $consecutive_failures -eq 1 ]]; then
                send_alert "OUTAGE" "System is DOWN. HTTP code: $http_code"
            fi

            # Critical alert after 5 consecutive failures
            if [[ $consecutive_failures -eq 5 ]]; then
                send_alert "CRITICAL" "System has been down for 5 minutes! SLA at risk!"
            fi
        fi

        # Update metrics
        update_metrics "$status" "$response_time"

        # Check if SLA is about to breach
        current_sla=$(calculate_monthly_sla)
        if (( $(echo "$current_sla < $SLA_TARGET" | bc -l) )); then
            send_alert "SLA_BREACH" "Current month SLA (${current_sla}%) is below target (${SLA_TARGET}%). Penalty of \$$PENALTY_AMOUNT will apply!"
        elif (( $(echo "$current_sla < ($SLA_TARGET + 0.1)" | bc -l) )); then
            send_alert "SLA_WARNING" "Current month SLA (${current_sla}%) is approaching breach threshold"
        fi

        last_status=$status

        # Generate daily report at midnight
        if [[ $(date +%H:%M) == "00:00" ]]; then
            generate_daily_report
        fi

        # Wait before next check
        sleep $CHECK_INTERVAL
    done
}

# Handle script termination
trap 'log_message "INFO" "SLA monitoring stopped"; exit 0' SIGINT SIGTERM

# Parse command line arguments
case "${1:-monitor}" in
    monitor)
        main
        ;;
    report)
        generate_daily_report
        ;;
    test)
        log_message "INFO" "Running test health check"
        result=$(check_availability)
        echo "Test result: $result"
        ;;
    *)
        echo "Usage: $0 {monitor|report|test}"
        exit 1
        ;;
esac