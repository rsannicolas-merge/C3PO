# /policy-draft - Security Policy, Standard, Procedure & Playbook Generator

Generate structured security governance documents aligned with the official MERGE TechOps templates, HITRUST CSF v11.5, and NIST 800-53 Rev 5. All outputs are formatted for Legal review and leadership approval routing.

## Usage

```
/policy-draft [document-name]
```

**Document names:**

**Policies (POL-):**
- `ai-governance` -- AI Security, SDLC, and Acceptable Use Policy (HITRUST Phase 1 priority)
- `access-control` -- Access Control and Identity Management Policy
- `incident-response` -- Incident Response Policy and Plan
- `risk-management` -- Risk Management Policy
- `vulnerability-management` -- Vulnerability Management Policy
- `change-management` -- Change Management Policy
- `data-classification` -- Data Classification and Handling Policy
- `vendor-risk` -- Third-Party and Vendor Risk Management Policy
- `business-continuity` -- Business Continuity and Disaster Recovery Policy
- `acceptable-use` -- Acceptable Use Policy
- `secure-sdlc` -- Secure Software Development Lifecycle Policy (NIST SA-3, SA-11)

**Standards (STD-):**
- `pipeline-security` -- CI/CD Pipeline Security Standard (NIST SA-15, CM-3)
- `container-security` -- Container Security Standard (NIST CM-6, SI-7)
- `iac-security` -- Infrastructure as Code Security Standard (NIST CM-2, CM-6)
- `encryption` -- Encryption Standard (NIST SC-8, SC-28)
- `baseline-config` -- Baseline Configuration Standard (NIST CM-2)
- `network-segmentation` -- Network Segmentation Standard (NIST SC-7)

**Procedures (PROC-):**
- `dependency-management` -- Software Composition and Dependency Management Procedure (NIST SI-2, SR-3)
- `account-management` -- Account Management Procedure (NIST AC-2)
- `audit-log-review` -- Audit Log Review Procedure (NIST AU-6)
- `incident-reporting` -- Incident Reporting Procedure (NIST IR-6)
- `risk-assessment` -- Risk Assessment Procedure (NIST RA-3)
- `vulnerability-scanning` -- Vulnerability Scanning Procedure (NIST RA-5)
- `patch-management` -- Patch Management Procedure (NIST SI-2)
- `vendor-assessment` -- Vendor Assessment Procedure (NIST SR-3)
- `termination-transfer` -- Termination / Transfer Procedure (NIST PS-4, PS-5)
- `disaster-recovery` -- Disaster Recovery Procedure (NIST CP-10)
- `backup` -- Backup Procedure (NIST CP-9)

**Playbooks (PB-):**
- `secops-playbook` -- Security Operations Playbook (platform-specific operational runbook)

## What It Does

1. **Reads context** from `memory/context.md` and `memory/systems.md` to tailor the document to the actual environment (GCP, Vertex AI, Vanta, Google SecOps, Foresite, Jira, etc.)
2. **Detects document type** from the name and applies the correct MERGE TechOps template (Policy, Standard, Procedure, or Playbook)
3. **Generates a complete draft** structured for HITRUST evidence submission using the official 9-section MERGE template
4. **Maps controls** to relevant HITRUST CSF v11.5 control specifications and NIST 800-53 Rev 5 control families
5. **Outputs the draft** to `content/policy/drafts/DRAFT_[document-name].md` ready for Legal and leadership review
6. **Updates the policy library index** at `content/policy/policy-library-index.md` to mark the document as DRAFT

## MERGE TechOps Template Structures

All documents follow the official MERGE 9-section structure. The template varies by document type:

### Policy Template (POL-)

```markdown
# POL-[NNNN] -- [Policy Name]

**MERGE TechOps Policy**

## Document Control

| Field | Value |
| ----- | ----- |
| Document Number | POL-[NNNN] |
| Version | 1.0 DRAFT |
| Author | Roze San Nicolas, Chief of Information Security |
| Last Updated | YYYY-MM-DD |
| Document Type | Policy |
| Status | DRAFT -- Pending Legal Review and Leadership Approval |
| Related Procedure | [PROC-NNNN or "TBD"] |
| HITRUST CSF v11.5 | [Control specifications] |
| NIST 800-53 Rev 5 | [Control families] |

---

## 1. Purpose
[Why this policy exists and what risk it addresses]

## 2. Scope
### 2.1 Applies To
[Roles and personnel]
### 2.2 Systems Involved
[Systems, platforms, environments]
### 2.3 Exclusions
[What is explicitly out of scope]

## 3. Roles and Responsibilities
### 3.1 [Primary Team]
### 3.2 TechOps
### 3.3 Managers
### 3.4 Security Officer (CISO)

## 4. Definitions
| Term | Definition |
| ---- | ---------- |
[Key terms used throughout the document]

## 5. Policy Overview
### 5.1 [Policy Statement Area]
[Specific, auditable requirements -- written to satisfy HITRUST control specifications]
### 5.N [Continue as needed]

## 6. Compliance
### 6.1 Exception Handling
[How exceptions are requested, documented, and approved]

## 7. Enforcement
[Consequences of non-compliance]

## 8. Review & Change Management
### 8.1 Review Frequency
[Annual minimum, or per trigger events]
### 8.2 Approval Workflow
[3-step: Author → Legal → Leadership]

## 9. Related Procedures
[Links to supporting procedures and standards]

---

## Revision History

| Version | Date | Author | Changes |
| ------- | ---- | ------ | ------- |
| 1.0 | YYYY-MM-DD | Roze San Nicolas | Initial draft |

---

Approved by: _________________ Date: _______
Title: _______________________

---

*This document is controlled and maintained by MERGE TechOps. Unauthorized alterations are prohibited.*
```

### Standard Template (STD-)

Uses the same 9-section Policy template structure, but:
- Document Type: **Standard**
- Section 5 title: **Standard Requirements** (not "Policy Overview")
- Section 5 subsections contain specific technical requirements, configurations, and measurable criteria
- Section 9 title: **Related Policy** (links up to parent policy, not down to procedures)

### Procedure Template (PROC-)

```markdown
# PROC-[NNNN] -- [Procedure Name]

**MERGE TechOps Procedure**

## Document Control
[Same structure as Policy, but Document Type: Procedure]

---

## 1. Purpose
## 2. Scope (same sub-sections as Policy)

## 3. Roles and Responsibilities
### 3.1 [Primary Team]
### 3.2 Support
### 3.3 TechOps
### 3.4 Managers
### 3.5 Security Officer (CISO)

## 4. Definitions

## 5. Procedure Overview
### 5.1 [Procedure Step Area]
Steps use numbered format with sub-steps:
1. Step one
   a. Sub-step
   b. Sub-step
2. Step two
### 5.N [Continue as needed]

## 6. Troubleshooting & Error Handling
### 6.1 Common Issues & Resolutions
| Issue | Resolution |
| ----- | ---------- |
### 6.2 Escalation Path
[Escalation tiers and contacts]

## 7. Compliance with Security Considerations
[How this procedure satisfies specific control requirements]

## 8. Review & Change Management
## 9. Related Policy
[Links up to parent policy]

---
[Revision History, Approval block, Footer -- same as Policy]
```

### Playbook Template (PB-)

```markdown
# PB -- [Playbook Name]

**MERGE TechOps Playbook**

## Document Control
[Same structure, but Document Type: Playbook, includes both Related Policy and Related Procedure]

---

## 1. Purpose
## 2. Scope

## 3. Roles and Responsibilities
### 3.1 RACI Matrix
| Activity | [Team 1] | [Team 2] | [Vendor] |
| -------- | -------- | -------- | -------- |
[R = Responsible, A = Accountable, C = Consulted, I = Informed]

## 4. Definitions

## 5. Playbook Overview
### 5.1 Critical URLs
### 5.2 Emergency Contacts
### 5.3 Daily Operations Checklist
### 5.4 Severity Classification
| Severity | Response Time | Examples |
### 5.5 Incident Response Quick Actions
### 5.6 Health Monitoring Thresholds
### 5.7 Infrastructure Reference
### 5.8 Configuration Reference
[Operational subsections vary by playbook scope]

## 6. Troubleshooting & Error Handling
## 7. Compliance with Security Considerations
## 8. Review & Change Management
## 9. Related Policy & Procedures

---
[Revision History, Approval block, Footer -- same as Policy]
```

## Document Type Detection

The command determines which template to use based on the document name:
- Names in the **Policies** list → Policy template (POL-)
- Names in the **Standards** list → Standard template (STD-)
- Names in the **Procedures** list → Procedure template (PROC-)
- Names in the **Playbooks** list → Playbook template (PB-)

## After Running

1. Route draft to Legal for review
2. Route to leadership for sign-off
3. Update status in `content/policy/policy-library-index.md` from DRAFT to CURRENT after approval
4. Upload approved document to Vanta as evidence for relevant HITRUST controls
5. Run `/reflect` after significant policy work to capture learnings

## Examples

```
/policy-draft ai-governance
/policy-draft pipeline-security
/policy-draft dependency-management
/policy-draft secops-playbook
/policy-draft incident-response
/policy-draft vendor-assessment
```
