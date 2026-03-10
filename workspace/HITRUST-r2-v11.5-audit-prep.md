# Audit Prep: HITRUST r2 Validated Assessment -- CSF v11.5

Prepared: 2026-02-21
Prepared by: Roze San Nicolas, CISO
Last Updated: 2026-02-21
Status: ACTIVE WORKING DOCUMENT

---

## Objective

Achieve HITRUST r2 Validated Assessment certification against CSF v11.5. Primary focus is AI governance and infrastructure security for Google Vertex/Gemini systems. Success = passing scores across all applicable control specifications with no critical CAPs blocking certification. Intermediate success = Phase 1 (governance gaps) fully closed before incubation opens in May.

---

## Scope

| Field | Value |
| ----- | ----- |
| Certification | HITRUST r2 Validated Assessment |
| CSF Version | 11.5 |
| Assessment type | External validated |
| Assessor | A-LIGN |
| GRC Platform | Vanta |
| Gap assessment completed | 2026-02-11 |
| Gap assessment file | `content/Merge - 2026 - HITRUST r2 Gap Assessment - Test Plan Updates 2.11.26 (1).xlsx` |
| AI infrastructure in scope | Google Vertex AI / Gemini |
| Incubation period | May -- July 2026 |
| Fieldwork & assessment | August 2026 |
| Target certification | Q4 2026 |

**Timeline pressure**: Incubation starts May 2026 -- ~10 weeks from 2026-02-21. Phase 1 (governance gaps) must be closed before incubation opens. Phase 2 technical controls must be operational by August fieldwork.

---

## Business Case

This is not just a compliance checkbox. Three drivers:

- **Market Trust**: Validates security controls to enterprise customers -- a differentiator
- **Risk Mitigation**: Proactively addresses AI-specific threats (prompt injection, model drift, data leakage) specific to Vertex/Gemini infrastructure
- **Regulatory Readiness**: Positions the agency ahead of emerging federal AI security standards

---

## Background & Context

### Current Compliance Posture

Gap assessment completed by A-LIGN on 2026-02-11. Four high-priority gap areas identified, all AI-governance focused. The program is moving from ad-hoc to formalized governance. Key platform supporting evidence collection: **Vanta GRC**.

| Gap Area | Current State | Severity | Phase |
| -------- | ------------- | -------- | ----- |
| AI Governance & Policy | No centralized, approved AI security policies | High | Phase 1 |
| AI Risk Management | No structured AI-specific threat assessment process | High | Phase 1 |
| Asset Visibility & Control | Incomplete AI model and dataset inventory | High | Phase 2 |
| Change Management | AI model updates lack formal change control | High | Phase 2 |

**Overall posture**: Gaps are well-defined. The remediation path is clear. The risk is timeline execution with a 2-person team.

---

## Certified Gap Analysis (from A-LIGN Assessment, 2026-02-11)

| Gap | Area | Severity | Current State | Remediation | Owner | Phase | Status |
| --- | ---- | -------- | ------------- | ----------- | ----- | ----- | ------ |
| No AI Governance Policy | AI Governance | High | Ad-hoc; no approved policy | Draft and approve master "AI Governance Policy" covering security, SDLC, acceptable use | Roze | 1 | Open |
| No AI Risk Assessment process | AI Risk Management | High | No structured process; AI-specific threats (e.g., prompt injection) unaddressed | Integrate recurring AI Risk Assessment (every 180 days) into Vanta GRC | Roze | 1 | Open |
| Incomplete AI asset inventory | Asset Visibility | High | AI models and datasets not fully cataloged | Implement centralized AI Asset Inventory + "AI Model Cards" for all internal models | Roze | 2 | Open |
| No change control for AI models | Change Management | High | AI model updates deployed without formal review | Integrate AI dev into Jira change workflows -- testing and approval required before deployment | Roze / Engineering | 2 | Open |

**All gaps from assessment**: High severity. No Critical findings blocking immediate operation. Confidence: 8/10 (Reported -- from executive summary; full test plan in Excel file).

---

## HITRUST r2 Remediation Roadmap

### Phase 1: Foundation (Now -- Q2 2026) -- URGENT

**Goal**: Close all critical governance gaps before incubation opens in May.

**Deliverables:**

- [ ] Draft "AI Governance Policy" -- security, SDLC, acceptable use across the organization
- [ ] Get AI Governance Policy reviewed by Legal and approved by leadership
- [ ] Set up AI Risk Assessment process in Vanta GRC (recurring, every 180 days)
- [ ] Run first AI Risk Assessment -- document AI-specific threats for Vertex/Gemini
- [ ] Get executive sign-off on governance policies (per Executive Ask #3 -- expedited approvals)
- [ ] Engage Engineering and Legal as SMEs (per Executive Ask #1 -- resource allocation)

**Phase 1 deadline**: Before end of April 2026 (buffer before May incubation)

---

### Phase 2: Implementation (Q3 2026)

**Goal**: Operationalize technical controls and complete inventory.

**Deliverables:**

- [ ] Build centralized AI Asset Inventory -- all Vertex/Gemini models and datasets
- [ ] Create "AI Model Cards" for all internal models (purpose, data inputs, risk level, owner)
- [ ] Integrate AI model updates into Jira change workflows -- testing and approval gates
- [ ] Enforce MFA on all accounts with access to in-scope AI systems
- [ ] Implement immutable backups for AI model artifacts and training data
- [ ] Begin evidence collection in Vanta for all Phase 2 controls
- [ ] Fieldwork begins: August 2026 -- all controls must be operational with evidence

**Phase 2 deadline**: Before August 2026 fieldwork

---

### Phase 3: Readiness (Q4 2026)

**Goal**: Full certification readiness.

**Deliverables:**

- [ ] Final documentation review -- all 19 HITRUST control categories
- [ ] Internal mock assessment -- simulate A-LIGN fieldwork questions
- [ ] Vanta evidence package review -- check completeness before submission
- [ ] Remediate any findings from mock assessment
- [ ] External validated assessment complete
- [ ] Certification received

**Phase 3 deadline**: End of year 2026

---

## Executive Asks (Active)

These require leadership action -- track until resolved.

| Ask | What's needed | From | Status |
| --- | ------------- | ---- | ------ |
| Resource Allocation | Authorize Engineering, Legal, TechOps SMEs to dedicate time to policy review and control implementation | Executive leadership | Open |
| Governance Championing | Reinforce new security processes within departments to ensure rapid adoption | Department heads | Open |
| Expedited Approvals | Prioritize review and sign-off of new governance policies to prevent Phase 1 bottlenecks | Leadership | Open |

---

## Key Control Areas: HITRUST r2 Full Checklist

*Beyond the 4 identified gaps, all 19 HITRUST CSF control categories require evidence. Status where known.*

### High-Priority (tied to identified gaps)

- [ ] **AI Governance Policy** -- approved and distributed
- [ ] **AI Risk Assessment** -- process established, first run documented
- [ ] **AI Asset Inventory** -- complete, current
- [ ] **AI Model Cards** -- created for all internal models
- [ ] **Change Management** -- AI model changes in Jira workflow

### Standard Controls (evidence still required)

- [ ] Access Control -- IAM configs, access reviews, least privilege (MFA enforcement in Phase 2)
- [ ] Audit Logging & Monitoring -- log coverage across Vertex/GCP, retention, alerting
- [ ] Vulnerability Management -- scan cadence documented, remediation SLAs tracked
- [ ] Incident Management -- IR policy, Vertex-specific runbooks, tabletop exercise
- [ ] Business Continuity & DR -- BCP/DRP docs, immutable backup evidence (Phase 2)
- [ ] Risk Management -- risk register including AI-specific risks
- [ ] Third-Party Assurance -- Google (GCP/Vertex) vendor assessment, SOC 2 / FedRAMP inherited controls
- [ ] Configuration Management -- baseline configs, change logs via Jira
- [ ] Endpoint Protection -- AV/EDR coverage
- [ ] Data Protection & Privacy -- encryption at rest/in transit, data classification
- [ ] Transmission Protection -- TLS configs, API security
- [ ] Education & Training -- security awareness completion records
- [ ] Password Management -- MFA enforcement evidence
- [ ] Network Protection -- firewall rules, GCP network segmentation
- [ ] Physical & Environmental -- inherited from GCP; collect Google compliance attestations
- [ ] Portable Media Security -- policy and controls
- [ ] Mobile Device Security -- MDM or prohibition policy
- [ ] Wireless Protection -- wireless security policy
- [ ] Information Protection Program -- overarching security policy documentation

---

## Vanta GRC -- Evidence Collection Notes

Vanta is the primary evidence collection and GRC platform. Key actions:

- [ ] Confirm Vanta is connected to GCP / Vertex AI environments
- [ ] Confirm HITRUST r2 framework is activated in Vanta
- [ ] Assign control owners in Vanta for each control family
- [ ] Set up AI Risk Assessment workflow in Vanta (180-day cadence)
- [ ] Validate that Jira integration is active for change management evidence
- [ ] Review Vanta's auto-collected evidence vs. what requires manual upload

---

## Anticipated Assessor Questions (A-LIGN Fieldwork)

| Likely Question | Prepared Response | Status |
| --------------- | ----------------- | ------ |
| Show me your AI Governance Policy and approval record | Policy being drafted in Phase 1 | Phase 1 |
| What is your process for assessing AI-specific risks like prompt injection? | Vanta AI Risk Assessment, 180-day cadence | Phase 1 |
| Provide your AI asset inventory -- all models and datasets | Building in Phase 2; Model Cards being created | Phase 2 |
| Walk me through your change control process for AI model updates | Jira workflow integration in Phase 2 | Phase 2 |
| Show MFA enforcement for all privileged accounts | Technical control -- Phase 2 | Phase 2 |
| How do you handle backups and DR for AI model artifacts? | Immutable backups -- Phase 2 | Phase 2 |
| What inherited controls do you leverage from Google/GCP? | FedRAMP authorization, SOC 2 reports -- collect attestations | Now |
| Who is the executive owner of the security program? | Roze San Nicolas, CISO | Ready |
| How are AI security requirements communicated to Engineering? | AI Governance Policy + Jira workflow (Phase 1-2) | Phase 1 |

---

## Leadership Notification Assessment

**Notification needed**: YES -- executive summary already prepared

**Status**: Executive asks are active. Leadership needs to:

1. Authorize SME time (Engineering, Legal, TechOps)
2. Champion new processes in their departments
3. Expedite policy approvals in Phase 1

**Recommended briefing cadence**: Monthly update to leadership on phase completion and open executive asks.

---

## Success Metrics

| Metric | Target | Current | Phase |
| ------ | ------ | ------- | ----- |
| AI Governance Policy approved | Yes | No | Phase 1 |
| AI Risk Assessment process in Vanta | Active, 180-day cadence | No | Phase 1 |
| First AI Risk Assessment run | Completed | No | Phase 1 |
| AI Asset Inventory complete | 100% of Vertex/Gemini models | No | Phase 2 |
| AI Model Cards created | All internal models | No | Phase 2 |
| Jira change workflow for AI | Active | No | Phase 2 |
| MFA enforced on in-scope systems | 100% | Unknown | Phase 2 |
| Immutable backups implemented | Yes | Unknown | Phase 2 |
| Vanta evidence package complete | 100% | Unknown | Phase 3 |
| A-LIGN mock assessment passed | Yes | Not yet | Phase 3 |
| r2 Certification received | Yes | No | Phase 3 |

---

## Immediate Next Steps (Phase 1 -- Before May 2026)

- [ ] Draft AI Governance Policy (security, SDLC, acceptable use) -- Roze -- March 2026
- [ ] Route AI Governance Policy to Legal and leadership for expedited review -- Roze -- March 2026
- [ ] Set up AI Risk Assessment workflow in Vanta -- Roze -- March 2026
- [ ] Run first AI Risk Assessment; document Vertex/Gemini-specific threats -- Roze -- April 2026
- [ ] Collect Google/GCP inherited controls (FedRAMP ATO, SOC 2 reports) -- Roze -- March 2026
- [ ] Confirm Vanta is connected to GCP and HITRUST r2 framework is activated -- Roze -- This week
- [ ] Get formal executive authorization for SME time (Engineering, Legal, TechOps) -- Roze -- This week

---

## Open Questions

- Which specific Vertex/Gemini models and workflows are in scope? (Needed for Asset Inventory)
- Is Vanta already connected to GCP/Vertex? What evidence is being auto-collected?
- Is the HITRUST r2 framework activated in Vanta? What's the current control completion percentage?
- Are there any existing AI governance documents (even informal) that can seed the policy draft?
- Which Legal contact owns AI governance policy review?
- Are there other AI systems in scope beyond Vertex/Gemini?

---

*Source document*: `content/Merge - 2026 - HITRUST r2 Gap Assessment - Test Plan Updates 2.11.26 (1).xlsx`
*Run `/reflect audit-prep` after working sessions to capture learnings and update memory files.*
