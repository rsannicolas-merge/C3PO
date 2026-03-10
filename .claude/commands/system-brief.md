# /system-brief - Quick System Intelligence

Generate a rapid intelligence brief on a system. Read before incident response, compliance reviews, or stakeholder meetings involving a specific system.

## Usage

```
/system-brief [system-name]
```

## Output Structure

### 1. System Snapshot

```markdown
# [System Name] -- Intelligence Brief
Generated: YYYY-MM-DD

## At a Glance
| Field | Value |
| ----- | ----- |
| System Name | |
| Environment | GCP / On-Prem / Hybrid |
| SLA Tier | Standard / Premium / Legacy |
| Uptime Target | e.g., 99.9% |
| Current Uptime | e.g., 99.7% |
| Risk Rating | Critical / High / Medium / Low |
| Audit Readiness | Ready / Needs Work / Not Ready |
| Documentation Score | X/11 docs present |
| Compliance Status | Compliant / Gaps Found / Unknown |
| Last Audit | YYYY-MM-DD |
| Business Owner | |
| Technical Owner | |
| Terraform Managed | Yes / No / Partial |
```

### 2. CISO Risk Summary

- Overall risk rating and one-line narrative
- Top 1-2 open risks with owners
- Any risks requiring leadership awareness
- Compliance posture change since last review

### 3. Current Status

- Operational state and recent activity
- Any active incidents or open Jira tickets
- SLA compliance indicators (current vs. target)
- Documentation health -- which of the 11 core docs exist and are current

### 4. Compliance Check

- Policy verification status against Roze's security framework
- NIST / FedRAMP / FISMA control gap summary
- SLA contract type (standardized vs. legacy)
- Deployed settings vs. documented policy -- any deviations?
- Missing or outdated security documentation
- Access control review status

### 5. Infrastructure Summary

- Key components and architecture
- Terraform state (if managed) -- link to repo
- GitHub repositories associated
- Network exposure summary

### 6. Recommended Actions

- **Immediate**: Critical compliance gaps, SLA breach risk, or open high/critical risks
- **Short-term**: Documentation to generate, settings to verify, controls to close
- **Monitor**: Items to watch but not yet actionable

### 7. Open Questions

- What we don't know but should
- Intelligence gaps that need human investigation
- Settings or controls that couldn't be verified remotely

## Data Sources

1. Check `memory/systems.md` for existing registry entry
2. Check `systems/[system-name].md` for detailed system record
3. Check `workspace/[system-name].md` if currently under active investigation
4. Check Jira for open tickets related to this system
5. Check GitHub for repos and Terraform configs
6. Check GCP console for live infrastructure state
7. Note confidence level for each data point (Verified / Reported / Speculative)

## After Running

- Update `memory/systems.md` if new information found
- Save full brief to `systems/[system-name].md` if significant findings
- Flag leadership if risk posture changed

## Example

```
/system-brief billing-api
/system-brief identity-platform
```
