# /audit-prep - CISO Audit & Compliance Preparation

Generate comprehensive preparation materials for audits, compliance reviews, and SLA verification.

## Usage

```
/audit-prep [type] [details]
```

**Types:**

- `compliance` - Security compliance review against Roze's policy framework and NIST/FedRAMP/FISMA controls
- `sla-review` - SLA contract verification and uptime analysis
- `documentation` - Documentation gap analysis across systems
- `incident-review` - Post-incident review preparation
- `inventory` - System inventory audit and gap identification
- `risk-review` - Risk register review and posture assessment
- `policy` - Policy library gap analysis against NIST 800-53 control families
- `devsecops` - DevSecOps and secure SDLC compliance review (pipeline security, IaC hygiene, dependency risk, NIST SA family)

## Output Structure

### 1. Overview

```markdown
# Audit Prep: [Type] -- [Details]
Prepared: YYYY-MM-DD

## Objective
[What success looks like -- specific, measurable outcome]

## Scope
| Field | Value |
| ----- | ----- |
| Systems in scope | |
| Time period | |
| Frameworks / Standards | |
| Previous audit date | |
| Auditor / Reviewer | |
```

### 2. Background & Context

- Current compliance posture summary (overall rating + trend)
- Systems in scope with documentation health scores and risk ratings
- SLA status for affected systems
- Known gaps from previous audits and remediation status
- Open risk register items relevant to this audit
- Recent incidents or changes that may affect compliance findings

### 3. Checklist

**For compliance audits (NIST / FedRAMP / FISMA):**

- [ ] Security documentation present and current (per Roze's templates)
- [ ] Deployed settings match documented policy
- [ ] Risk register current -- all items have owners and status
- [ ] SLA contracts on standardized format
- [ ] Incident response procedures documented and tested
- [ ] Change management logs up to date
- [ ] Terraform state matches deployed infrastructure
- [ ] Access controls properly documented and reviewed (least privilege)
- [ ] Monitoring and alerting in place and documented
- [ ] Vendor / third-party risk assessments current
- [ ] Policy library current with latest regulatory requirements

**For SLA reviews:**

- [ ] Uptime data pulled for full review period
- [ ] Response time metrics gathered per contract
- [ ] Ticket response / resolution times checked against SLA commitments
- [ ] Contract terms vs. actual performance compared
- [ ] Breach incidents documented with root cause
- [ ] Remediation actions for any breaches tracked

**For risk reviews:**

- [ ] Risk register reviewed -- all open items have owners and due dates
- [ ] New risks identified since last review
- [ ] Risks accepted, mitigated, or transferred -- decisions documented
- [ ] High / critical risks have executive awareness
- [ ] Leadership notification status confirmed

**For DevSecOps audits:**

- [ ] CI/CD pipeline configurations reviewed for secrets exposure and deployment gates
- [ ] Branch protection rules verified (required reviews, status checks, signed commits)
- [ ] Terraform / IaC files scanned for public exposure, IAM overprivilege, encryption gaps
- [ ] Dependency manifests checked for known critical/high CVEs
- [ ] Container images scanned for vulnerabilities and base image currency
- [ ] Secrets scanning active on all repositories
- [ ] Environment separation verified (dev/staging/prod isolation)
- [ ] SBOM generated or available for production artifacts
- [ ] Code review requirements documented and enforced
- [ ] NIST SA-3, SA-11, SA-15, CM-3, SI-7 control evidence collected
- [ ] HITRUST 09.aa (Change Control) and 10.b (Vulnerability Management) evidence mapped
- [ ] DevSecOps policies current in policy library index (Secure SDLC, Pipeline Security, etc.)

### 4. Gap Analysis

| System / Area | Gap Type | Severity | Framework | Remediation | Effort | Owner |
| ------------- | -------- | -------- | --------- | ----------- | ------ | ----- |
| | | Critical / High / Med / Low | | | | |

### 5. Anticipated Questions

| Likely Question | Prepared Response |
| --------------- | ----------------- |
| Why is documentation missing for X? | |
| What's our current compliance percentage? | |
| How many systems are on legacy SLAs? | |
| What are our highest open risks? | |
| Have we had any SLA breaches? | |
| What's the status of remediation from the last audit? | |

### 6. Leadership Notification Assessment

- Does this audit surface anything requiring leadership awareness?
- Any findings that affect the agency's regulatory standing?
- Risk posture change to communicate?

### 7. Success Metrics

- What does a successful audit outcome look like?
- Specific deliverables or findings to aim for
- Follow-up commitments to capture

## Data Sources

1. Check `memory/context.md` for current priorities and active work
2. Check `memory/systems.md` for system registry and status
3. Check `memory/stakeholders.md` for attendee preferences and decision map
4. Review relevant files in `systems/` for system-level detail
5. Check Jira for open compliance and risk tickets
6. Reference Roze's security documentation templates as the compliance baseline
7. Review `content/policy/policy-library-index.md` for policy currency

## After the Session

Run `/reflect audit-prep` to capture findings and update:

- `memory/systems.md` -- update compliance status for affected systems
- `content/policy/policy-library-index.md` -- flag any policy gaps found
- `memory/context.md` -- add remediation items to active work

## Example

```
/audit-prep compliance billing-api
/audit-prep risk-review full-portfolio
/audit-prep sla-review legacy-contracts
/audit-prep devsecops full-portfolio
/audit-prep devsecops vertex-ai-pipeline
```
