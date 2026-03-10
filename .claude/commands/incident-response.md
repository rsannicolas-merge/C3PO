# /incident-response

Coordinate security incident response with automated workflows and documentation.

## Usage
```
/incident-response [severity] [type] "[description]"
```

## Severity Levels
- `P0` - Critical: Production down, data breach
- `P1` - High: Service degraded, security compromise
- `P2` - Medium: Performance issues, potential risk
- `P3` - Low: Minor issues, no immediate impact

## Incident Types
- `security` - Security breach or compromise
- `availability` - Service outage
- `data` - Data loss or exposure
- `compliance` - Compliance violation
- `performance` - Performance degradation

## Implementation

1. **Initial Response**:
   - Create incident ticket
   - Notify stakeholders
   - Start incident timeline
   - Assign incident commander

2. **Investigation**:
   - Collect logs and evidence
   - Analyze with Sec-Gemini
   - Identify root cause
   - Document findings

3. **Containment**:
   - Isolate affected systems
   - Stop data exfiltration
   - Preserve evidence
   - Implement temporary fixes

4. **Remediation**:
   - Apply permanent fixes
   - Update configurations
   - Patch vulnerabilities
   - Verify resolution

5. **Post-Incident**:
   - Generate incident report
   - Update runbooks
   - Create lessons learned
   - Update risk register

## Automated Actions
- Slack/email notifications
- Evidence collection
- Log aggregation
- Timeline generation
- Report creation

## Integration Points
- Jira for ticket tracking
- Slack for communications
- GCP for infrastructure
- GitHub for code changes
- Vanta for compliance

## Templates Used
- Incident report template
- Communication templates
- Runbook updates
- Post-incident review

## Output
- Incident ticket
- Timeline of events
- Root cause analysis
- Remediation actions
- Post-incident report
- Lessons learned