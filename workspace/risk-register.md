# Security Risk Register
*Last Updated: 2026-03-09*
*Risk Owner: CISO*
*Review Cycle: Monthly*

## Risk Scoring Methodology

**Risk Score = Likelihood × Impact**

- **Likelihood**: 1 (Rare) to 5 (Almost Certain)
- **Impact**: 1 (Negligible) to 5 (Catastrophic)
- **Risk Score**: 1-5 (Low), 6-12 (Medium), 15-20 (High), 25 (Critical)

---

## Active Risks

### Critical Risks (Score 20-25)

| ID | Risk Description | Category | Likelihood | Impact | Score | Status | Owner | Mitigation | Target Date |
|----|------------------|----------|------------|--------|-------|--------|-------|------------|-------------|
| R001 | No complete system inventory - unknown attack surface | Asset Management | 5 | 5 | 25 | 🔴 Open | CISO | Asset registry initialization in progress | 2026-03-31 |
| R002 | Critical systems undocumented (Corsair CPOE) | Documentation | 5 | 4 | 20 | 🔴 Open | Clinical | Documentation sprint planned | 2026-03-15 |

### High Risks (Score 15-19)

| ID | Risk Description | Category | Likelihood | Impact | Score | Status | Owner | Mitigation | Target Date |
|----|------------------|----------|------------|--------|-------|--------|-------|------------|-------------|
| R003 | HITRUST Phase 1 gaps - AI governance incomplete | Compliance | 4 | 4 | 16 | 🟡 Mitigating | CISO | AI policy approved, Vanta integration pending | 2026-04-30 |
| R004 | No SLA monitoring - potential breach penalties | Vendor Management | 4 | 4 | 16 | 🔴 Open | IT Ops | Monitoring setup planned | 2026-03-31 |
| R005 | Legacy systems with unknown vulnerabilities | Infrastructure | 4 | 4 | 16 | 🔴 Open | Engineering | Discovery scan scheduled | 2026-03-20 |

### Medium Risks (Score 6-12)

| ID | Risk Description | Category | Likelihood | Impact | Score | Status | Owner | Mitigation | Target Date |
|----|------------------|----------|------------|--------|-------|--------|-------|------------|-------------|
| R006 | Understaffed security team (2 vs 5+ needed) | Resources | 5 | 2 | 10 | 🟡 Accepted | Leadership | AI force multiplier (C3PO) deployed | Ongoing |
| R007 | Incomplete DevSecOps tooling | SDLC Security | 3 | 3 | 9 | 🟡 Mitigating | Engineering | Tool inventory in progress | 2026-04-15 |
| R008 | AI model change management not defined | AI Governance | 3 | 3 | 9 | 🟡 Mitigating | CISO/IT | Jira workflow design | 2026-03-31 |
| R009 | Vendor risk assessments outdated | Third Party | 3 | 3 | 9 | 🔴 Open | Procurement | Assessment refresh planned | 2026-04-30 |

### Low Risks (Score 1-5)

| ID | Risk Description | Category | Likelihood | Impact | Score | Status | Owner | Mitigation | Target Date |
|----|------------------|----------|------------|--------|-------|--------|-------|------------|-------------|
| R010 | Board reporting templates not standardized | Governance | 2 | 2 | 4 | 🟢 Accepted | CISO | MERGE dashboard deployed | Complete |

---

## Risk Treatment Summary

| Treatment | Count | Risk IDs |
|-----------|-------|----------|
| 🔴 Open (Untreated) | 5 | R001, R002, R004, R005, R009 |
| 🟡 Mitigating | 4 | R003, R006, R007, R008 |
| 🟢 Accepted | 1 | R010 |
| ✅ Closed | 0 | - |

---

## Risk Trends

### New Risks (Added This Month)
- R001-R010: Initial baseline established

### Escalated Risks
- None (initial baseline)

### Closed Risks
- None yet

---

## Top Risk Indicators

1. **System Inventory Gap**: 50%+ of systems undocumented
2. **HITRUST Readiness**: 2 Phase 1 gaps remaining (AI risk assessment, change management)
3. **SLA Monitoring**: 0% automated coverage
4. **Team Capacity**: 40% of required staffing
5. **Vendor Assessments**: 60%+ overdue for refresh

---

## Risk Appetite Statement

The agency maintains a **LOW** risk appetite for:
- Compliance violations (HITRUST, FedRAMP, FISMA)
- PHI/PII data breaches
- System availability below SLA thresholds
- Unmanaged AI/ML model risks

The agency accepts **MODERATE** risk for:
- Resource constraints (mitigated by automation)
- Legacy system technical debt (managed migration)
- Non-critical system documentation gaps

---

## Action Priority Matrix

### Do First (Critical + Quick Win)
1. Complete Corsair CPOE documentation (R002)
2. Finish system inventory (R001)
3. Set up SLA monitoring for AIgency (R004)

### Schedule (Critical + Complex)
1. Complete HITRUST Phase 1 remediation (R003)
2. Legacy system vulnerability assessment (R005)

### Delegate (Important + Others Can Do)
1. Vendor risk assessment refresh (R009)
2. DevSecOps tool inventory (R007)

### Monitor (Low Impact)
1. Team capacity constraints (R006)
2. Board reporting standardization (R010)

---

## Compliance Implications

### HITRUST r2 Impact
- R001, R002, R005: Direct evidence gaps for assessment
- R003: Phase 1 must-fix items
- R004: SLA evidence required for vendor management controls

### HITRUST AI2 Impact
- R003, R008: AI governance control gaps
- R001: AI system inventory incomplete

---

## Executive Summary

**Overall Risk Posture**: HIGH ⚠️

**Key Messages**:
1. **Critical Gap**: No complete system inventory creates blind spots
2. **Compliance Risk**: HITRUST deadlines approaching with open gaps
3. **Operational Risk**: No SLA monitoring risks penalties and breaches
4. **Mitigation Progress**: AI governance approved, asset registry started

**Recommendations**:
1. Emergency documentation sprint for critical systems
2. Automate SLA monitoring immediately
3. Complete Phase 1 HITRUST items before April
4. Consider contractor support for system discovery

---

## Notes

**Data Quality**:
- Confidence: 7/10 (Good initial assessment)
- Based on current knowledge and Wood team inputs
- Many risks likely undiscovered due to inventory gaps

**Next Review**: 2026-04-09
**Escalation Threshold**: Any risk scoring 20+ or compliance deadline miss