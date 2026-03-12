# Security Policy Library Index

**Owner**: Roze San Nicolas, Chief of Information Security
**Last Updated**: 2026-02-23
**Purpose**: Centralized registry of all security policies, standards, and procedures. Each entry tracks status, review date, and NIST/FedRAMP control mapping.

---

## How to Use This Index

1. **Find a policy**: Search by category or control family below
2. **Check currency**: Anything >1 year old without a review date is a gap
3. **Flag for update**: Mark status as NEEDS REVIEW if outdated
4. **Ask Claude**: Run `/audit-prep policy` to get a gap analysis against NIST 800-53

---

## Policy Status Legend

| Status | Meaning |
| ------ | ------- |
| ✅ CURRENT | Reviewed within the last year, approved |
| 🟡 NEEDS REVIEW | Exists but overdue for review |
| 🔴 MISSING | Required by framework, does not exist |
| 🚧 DRAFT | In progress, not yet approved |

---

## Policy Registry

### AI Governance (AI)

| Policy / Procedure | Status | Last Review | NIST Control | Location |
| ------------------ | ------ | ----------- | ------------ | -------- |
| AI Governance, Security & Acceptable Use Policy (POL-0011) | 🚧 DRAFT | 2026-02-21 | SA-3, RA-1, PL-1 | content/policy/drafts/DRAFT_ai-governance-policy.md |

---

### Access Control (AC)

| Policy / Procedure | Status | Last Review | NIST Control | Location |
| ------------------ | ------ | ----------- | ------------ | -------- |
| Access Control Policy | 🔴 MISSING | | AC-1 | |
| Account Management Procedure | 🔴 MISSING | | AC-2 | |
| Least Privilege Standard | 🔴 MISSING | | AC-6 | |
| Remote Access Policy | 🔴 MISSING | | AC-17 | |
| Wireless Access Policy | 🔴 MISSING | | AC-18 | |

---

### Audit & Accountability (AU)

| Policy / Procedure | Status | Last Review | NIST Control | Location |
| ------------------ | ------ | ----------- | ------------ | -------- |
| Audit & Logging Policy | 🔴 MISSING | | AU-1 | |
| Audit Log Review Procedure | 🔴 MISSING | | AU-6 | |

---

### Configuration Management (CM)

| Policy / Procedure | Status | Last Review | NIST Control | Location |
| ------------------ | ------ | ----------- | ------------ | -------- |
| Configuration Management Policy | 🔴 MISSING | | CM-1 | |
| Baseline Configuration Standard | 🔴 MISSING | | CM-2 | |
| Change Management Procedure | 🔴 MISSING | | CM-3 | |
| Security Configuration Checklist | 🔴 MISSING | | CM-6 | |

---

### Contingency Planning (CP)

| Policy / Procedure | Status | Last Review | NIST Control | Location |
| ------------------ | ------ | ----------- | ------------ | -------- |
| Contingency Plan | 🔴 MISSING | | CP-1 | |
| Backup Policy | 🔴 MISSING | | CP-9 | |
| Disaster Recovery Procedure | 🔴 MISSING | | CP-10 | |

---

### Incident Response (IR)

| Policy / Procedure | Status | Last Review | NIST Control | Location |
| ------------------ | ------ | ----------- | ------------ | -------- |
| Incident Response Policy (POL-0013) | 🚧 DRAFT | 2026-02-23 | IR-1, IR-8 | content/policy/drafts/DRAFT_incident-response-policy.md |
| Incident Response Plan | 🔴 MISSING | | IR-8 | |
| Incident Reporting Procedure | 🔴 MISSING | | IR-6 | |

---

### Risk Assessment (RA)

| Policy / Procedure | Status | Last Review | NIST Control | Location |
| ------------------ | ------ | ----------- | ------------ | -------- |
| Risk Assessment Policy | 🔴 MISSING | | RA-1 | |
| AI Risk Assessment Procedure (PROC-0002) | 🚧 DRAFT | 2026-03-11 | RA-3, PM-9 | content/policy/drafts/DRAFT_ai-risk-assessment-procedure.md |
| Vulnerability Scanning Procedure | 🔴 MISSING | | RA-5 | |

---

### System & Communications Protection (SC)

| Policy / Procedure | Status | Last Review | NIST Control | Location |
| ------------------ | ------ | ----------- | ------------ | -------- |
| System & Comms Protection Policy | 🔴 MISSING | | SC-1 | |
| Encryption Standard | 🔴 MISSING | | SC-8, SC-28 | |
| Network Segmentation Standard | 🔴 MISSING | | SC-7 | |

---

### System & Information Integrity (SI)

| Policy / Procedure | Status | Last Review | NIST Control | Location |
| ------------------ | ------ | ----------- | ------------ | -------- |
| System Integrity Policy | 🔴 MISSING | | SI-1 | |
| Malware Protection Procedure | 🔴 MISSING | | SI-3 | |
| Patch Management Procedure | 🔴 MISSING | | SI-2 | |

---

### Personnel Security (PS)

| Policy / Procedure | Status | Last Review | NIST Control | Location |
| ------------------ | ------ | ----------- | ------------ | -------- |
| Personnel Security Policy | 🔴 MISSING | | PS-1 | |
| Acceptable Use Policy | 🔴 MISSING | | PS-6 | |
| Termination / Transfer Procedure | 🔴 MISSING | | PS-4, PS-5 | |

---

### Supply Chain / Vendor Risk

| Policy / Procedure | Status | Last Review | Framework | Location |
| ------------------ | ------ | ----------- | --------- | -------- |
| Third-Party Risk Management Policy | 🔴 MISSING | | SR-1 | |
| Vendor Assessment Procedure | 🔴 MISSING | | SR-3 | |
| SLA Standard Template | 🟡 NEEDS REVIEW | | Internal | |

---

### DevSecOps / Secure SDLC (DS)

| Policy / Procedure | Status | Last Review | NIST Control | Location |
| ------------------ | ------ | ----------- | ------------ | -------- |
| Secure SDLC Policy (POL-0012) | 🚧 DRAFT | 2026-02-23 | SA-3, SA-11 | content/policy/drafts/DRAFT_secure-sdlc-policy.md |
| CI/CD Pipeline Security Standard (STD-0001) | 🚧 DRAFT | 2026-02-23 | SA-15, CM-3 | content/policy/drafts/DRAFT_pipeline-security-standard.md |
| Dependency Management Procedure (PROC-0001) | 🚧 DRAFT | 2026-02-23 | SI-2, SR-3 | content/policy/drafts/DRAFT_dependency-management-procedure.md |
| Container Security Standard (STD-0002) | 🚧 DRAFT | 2026-02-23 | CM-6, SI-7, SC-7, RA-5 | content/policy/drafts/DRAFT_container-security-standard.md |
| IaC Security Standard (STD-0003) | 🚧 DRAFT | 2026-02-23 | CM-2, CM-6 | content/policy/drafts/DRAFT_iac-security-standard.md |

---

### Playbooks (PB)

| Playbook | Status | Last Review | Related Policy | Location |
| -------- | ------ | ----------- | -------------- | -------- |
| Google SecOps Playbook (PB -- Google SecOps) | 🚧 DRAFT | 2025-12 | Incident Response Policy | content/policy/drafts/ (source: Playbook Template.pdf) |

---

## Gap Summary

Run `/audit-prep policy` to get a current gap count and prioritized remediation list.

**Quick count**:

- Total documents tracked: 31
- Current (✅): 0
- Needs review (🟡): 1
- Missing (🔴): 20
- Draft (🚧): 9 (8 policies/standards/procedures + 1 playbook)

**Highest priority gaps** (HITRUST Phase 1 -- due before April 30, 2026):

1. AI Governance Policy (POL-0011) -- 🚧 DRAFT, route to Legal and leadership for approval
2. AI Risk Assessment Procedure (PROC-0002) -- 🚧 DRAFT ✅ CLOSED, route to Legal and leadership for approval; configure 180-day cadence in Vanta
3. Incident Response Policy (POL-0013) -- 🚧 DRAFT, route to Legal with DevSecOps batch; closes HITRUST AI2 Section 5.4 gap
4. DevSecOps procedures -- 🚧 ALL 5 DRAFTED (POL-0012, STD-0001, PROC-0001, STD-0002, STD-0003), route to Legal and leadership for approval alongside POL-0011

---

*Next full review*: 2027-02-23
*Reviewed by*: Roze San Nicolas
