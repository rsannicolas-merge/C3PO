# /hitrust-prep

Prepare for HITRUST r2 v11.5 and AI2 assessments with automated gap analysis and evidence collection.

## Usage
```
/hitrust-prep [assessment] [action]
```

## Assessments
- `r2` - HITRUST r2 Validated Assessment
- `ai2` - HITRUST AI2 Assessment
- `both` - Both assessments

## Actions

### Gap Analysis
```
/hitrust-prep r2 gap-analysis
```
Identifies control gaps and missing evidence.

### Evidence Collection
```
/hitrust-prep r2 collect-evidence
```
Gathers evidence from integrated systems.

### Remediation Tracking
```
/hitrust-prep r2 track-remediation
```
Monitors remediation progress.

### Readiness Check
```
/hitrust-prep both readiness-check
```
Comprehensive readiness assessment.

## Implementation

1. **Gap Analysis**:
   - Load HITRUST control requirements
   - Check current implementation status
   - Identify missing evidence
   - Priority scoring

2. **Evidence Collection**:
   - Query Vanta for control evidence
   - Pull from GitHub repositories
   - Extract from GCP configurations
   - Generate from security scans

3. **AI-Specific Controls** (AI2):
   - AI governance policy
   - Model risk assessments
   - Data integrity controls
   - AI lifecycle management

4. **Remediation**:
   - Create Jira tickets
   - Track progress
   - Update evidence
   - Re-assess gaps

## Control Categories
- Access Control
- Audit Logging
- Risk Management
- Incident Management
- Configuration Management
- Vulnerability Management
- Third-Party Assurance
- Business Continuity

## Timeline
- Incubation: May - July 2026
- Fieldwork: August 2026
- Certification: September 2026

## Output
- Gap assessment report
- Evidence package
- Remediation plan
- Readiness score
- Control mapping matrix