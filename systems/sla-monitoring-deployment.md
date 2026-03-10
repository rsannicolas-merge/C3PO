# AIgency SLA Monitoring Deployment Guide
*Created: 2026-03-09*
*Priority: CRITICAL - $10K/month penalty risk*

## Quick Start

### 1. Configure Environment Variables

```bash
# Add to /etc/environment or ~/.bashrc
export AIGENCY_ENDPOINT="https://aigency.agency.gov/health"
export SLACK_WEBHOOK="https://hooks.slack.com/services/YOUR/WEBHOOK/URL"
```

### 2. Install Dependencies

```bash
# Ubuntu/Debian
sudo apt-get update
sudo apt-get install -y curl jq bc

# RHEL/CentOS
sudo yum install -y curl jq bc

# MacOS (for testing)
brew install curl jq bc
```

### 3. Deploy as SystemD Service (Production)

```bash
# Create service file
sudo tee /etc/systemd/system/aigency-sla-monitor.service <<EOF
[Unit]
Description=AIgency SLA Monitoring Service
After=network.target

[Service]
Type=simple
User=sla-monitor
Group=sla-monitor
WorkingDirectory=/opt/sla-monitoring
ExecStart=/opt/sla-monitoring/aigency-sla-monitoring.sh monitor
Restart=always
RestartSec=10
StandardOutput=journal
StandardError=journal

[Install]
WantedBy=multi-user.target
EOF

# Create user and directories
sudo useradd -r -s /bin/false sla-monitor
sudo mkdir -p /opt/sla-monitoring
sudo mkdir -p /var/log/sla-monitoring
sudo cp aigency-sla-monitoring.sh /opt/sla-monitoring/
sudo chown -R sla-monitor:sla-monitor /opt/sla-monitoring
sudo chown -R sla-monitor:sla-monitor /var/log/sla-monitoring

# Start service
sudo systemctl daemon-reload
sudo systemctl enable aigency-sla-monitor
sudo systemctl start aigency-sla-monitor
```

### 4. Deploy as Kubernetes CronJob (Alternative)

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: sla-monitor-script
data:
  aigency-sla-monitoring.sh: |
    [SCRIPT CONTENT HERE]
---
apiVersion: batch/v1
kind: CronJob
metadata:
  name: aigency-sla-monitor
spec:
  schedule: "* * * * *"  # Every minute
  jobTemplate:
    spec:
      template:
        spec:
          containers:
          - name: monitor
            image: alpine:latest
            command:
            - /bin/sh
            - -c
            - |
              apk add --no-cache curl jq bc bash
              bash /scripts/aigency-sla-monitoring.sh monitor
            env:
            - name: AIGENCY_ENDPOINT
              value: "https://aigency.agency.gov/health"
            - name: SLACK_WEBHOOK
              valueFrom:
                secretKeyRef:
                  name: sla-monitor-secrets
                  key: slack-webhook
            volumeMounts:
            - name: script
              mountPath: /scripts
            - name: logs
              mountPath: /var/log/sla-monitoring
          volumes:
          - name: script
            configMap:
              name: sla-monitor-script
              defaultMode: 0755
          - name: logs
            persistentVolumeClaim:
              claimName: sla-logs-pvc
          restartPolicy: OnFailure
```

## Monitoring Dashboard Setup

### Prometheus Metrics Export

```yaml
# prometheus-exporter.yaml
apiVersion: v1
kind: Service
metadata:
  name: sla-metrics-exporter
spec:
  ports:
  - port: 9090
    targetPort: 9090
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: sla-metrics-exporter
spec:
  replicas: 1
  template:
    spec:
      containers:
      - name: exporter
        image: prom/node-exporter:latest
        ports:
        - containerPort: 9090
        volumeMounts:
        - name: metrics
          mountPath: /var/log/sla-monitoring
          readOnly: true
```

### Grafana Dashboard JSON

```json
{
  "dashboard": {
    "title": "AIgency SLA Monitoring",
    "panels": [
      {
        "title": "Current Month SLA",
        "type": "gauge",
        "targets": [
          {
            "expr": "aigency_sla_current_percentage"
          }
        ],
        "thresholds": {
          "steps": [
            {"value": 0, "color": "red"},
            {"value": 99.9, "color": "green"}
          ]
        }
      },
      {
        "title": "Downtime Minutes",
        "type": "stat",
        "targets": [
          {
            "expr": "aigency_downtime_seconds / 60"
          }
        ]
      },
      {
        "title": "Penalty Risk",
        "type": "stat",
        "targets": [
          {
            "expr": "aigency_penalty_risk_dollars"
          }
        ],
        "unit": "currencyUSD"
      }
    ]
  }
}
```

## Alert Configuration

### PagerDuty Integration

```bash
# Add to monitoring script environment
export PAGERDUTY_KEY="YOUR_INTEGRATION_KEY"

# Modify send_alert function to include:
curl -X POST https://events.pagerduty.com/v2/enqueue \
  -H 'Content-Type: application/json' \
  -d "{
    \"routing_key\": \"$PAGERDUTY_KEY\",
    \"event_action\": \"trigger\",
    \"payload\": {
      \"summary\": \"AIgency SLA Breach Risk\",
      \"severity\": \"critical\",
      \"source\": \"sla-monitor\",
      \"custom_details\": {
        \"current_sla\": \"$current_sla\",
        \"penalty\": \"$PENALTY_AMOUNT\"
      }
    }
  }"
```

## Testing & Validation

### Test Script Locally

```bash
# Test health check
./aigency-sla-monitoring.sh test

# Generate test report
./aigency-sla-monitoring.sh report

# Run monitoring for 5 minutes
timeout 300 ./aigency-sla-monitoring.sh monitor
```

### Simulate Outage

```bash
# Temporarily point to bad endpoint
export AIGENCY_ENDPOINT="https://aigency.agency.gov/nonexistent"
./aigency-sla-monitoring.sh monitor

# Should see:
# [ERROR] Health check failed. HTTP code: 404
# Alert sent to Slack
```

## Metrics & Reporting

### Daily Report Automation

```bash
# Add to crontab for daily email report
0 8 * * * /opt/sla-monitoring/aigency-sla-monitoring.sh report | mail -s "AIgency SLA Daily Report" ciso@agency.gov
```

### Monthly Executive Report

```sql
-- Query for monthly summary
SELECT
  DATE_TRUNC('month', timestamp) as month,
  AVG(uptime_percentage) as avg_sla,
  SUM(CASE WHEN uptime_percentage < 99.9 THEN 10000 ELSE 0 END) as penalties,
  COUNT(DISTINCT DATE(timestamp)) as days_monitored
FROM sla_metrics
WHERE system = 'AIgency'
GROUP BY 1
ORDER BY 1 DESC;
```

## Troubleshooting

### Common Issues

| Issue | Solution |
|-------|----------|
| Script not running | Check systemd logs: `journalctl -u aigency-sla-monitor -f` |
| No alerts received | Verify SLACK_WEBHOOK is set correctly |
| Metrics not updating | Check write permissions on `/var/log/sla-monitoring/` |
| False positives | Increase timeout in curl command (--max-time) |

### Debug Mode

```bash
# Run with verbose output
bash -x aigency-sla-monitoring.sh monitor 2>&1 | tee debug.log
```

## Maintenance

### Log Rotation

```bash
# /etc/logrotate.d/sla-monitoring
/var/log/sla-monitoring/*.log {
    daily
    rotate 90
    compress
    missingok
    notifempty
    create 0644 sla-monitor sla-monitor
}
```

### Backup Metrics

```bash
# Daily backup of metrics
0 0 * * * tar -czf /backup/sla-metrics-$(date +\%Y\%m\%d).tar.gz /var/log/sla-monitoring/
```

## Next Steps

1. **Immediate**: Deploy to production monitoring infrastructure
2. **Week 1**: Integrate with existing Grafana dashboards
3. **Week 2**: Add predictive alerting (warn before breach)
4. **Month 1**: Expand to all Tier 1 systems

## Support

- Script issues: security@agency.gov
- SLA questions: contracts@agency.gov
- Penalty disputes: legal@agency.gov

---

*Deployment checklist:*
- [ ] Environment variables configured
- [ ] Dependencies installed
- [ ] Service deployed and running
- [ ] Alerts tested and received
- [ ] Metrics being collected
- [ ] Daily report scheduled
- [ ] Log rotation configured
- [ ] Backup process in place