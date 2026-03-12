# PROC-0002 AI System Risk Assessment Procedure

MERGE TechOps Procedure

**Document Control**

| Field | Value |
|-------|-------|
| Document Number | PROC-0002 |
| Version | 1.0 DRAFT |
| Author | Roze San Nicolas |
| Last Updated | 2026-03-11 |
| Document Type | Procedure |
| Related Policy | POL-0011 AI Governance, Security & Acceptable Use Policy |
| Status | DRAFT -- Pending Legal Review and Leadership Approval |
| Owner | Roze San Nicolas, Chief of Information Security |
| Next Review | 2027-03-11 (annual) |

**HITRUST CSF v11.5 Control Mapping**: 01.03a (AI Risk Management), 01.00a (AI Security Management Program), 01.02a (AI Roles and Responsibilities), 07.10b (AI Input Validation), 12.09ab (AI Monitoring)

**NIST 800-53 Rev 5 Control Family Mapping**: RA-3 (Risk Assessment), RA-5 (Vulnerability Monitoring and Scanning), PM-9 (Risk Management Strategy), PM-28 (Risk Framing), CA-7 (Continuous Monitoring), SA-11 (Developer Testing and Evaluation)

---

## 1. Purpose

This procedure establishes the mandatory, recurring process for identifying, assessing, treating, and monitoring risks associated with AI systems in use at MERGE, with primary focus on Google Vertex AI and Gemini deployments. It governs the 180-day AI Risk Assessment cycle required under HITRUST CSF v11.5 and provides the procedural structure for managing AI-specific threats -- including prompt injection, model hallucination, data privacy violations, model drift, and supply chain compromise -- in a documented, auditable, and evidence-ready manner.

AI systems introduce a distinct threat profile that general IT risk frameworks do not fully address. Unlike traditional software, AI models exhibit emergent, probabilistic behavior; their outputs can be manipulated through adversarial inputs; their training data may encode bias or sensitive information; and their performance degrades over time without explicit code changes. Federal agencies operating AI systems that affect service delivery, regulatory compliance, or sensitive constituent data are obligated to apply structured risk governance to those systems.

This procedure implements Section 4 of POL-0011 (AI Governance, Security & Acceptable Use Policy) and provides the operational structure for the AI Risk Management program. It integrates directly with Vanta GRC for evidence collection and control tracking, and with MERGE's active HITRUST r2 v11.5 and AI2 certification programs. Execution of this procedure at 180-day intervals produces the documented evidence required for HITRUST r2 control 01.03a (AI Risk Management) and NIST RA-3 (Risk Assessment).

**HITRUST Evidence Note**: This procedure satisfies HITRUST CSF v11.5 Control 01.03a requirement for a documented, recurring AI-specific risk management process. Each completed assessment cycle -- including risk register, treatment decisions, and evidence package -- shall be uploaded to Vanta as evidence for the AI Risk Management control family. Retain all assessment records for a minimum of three years.

---

## 2. Scope

### Applies To

- All AI systems operated or procured by MERGE, including models hosted on Google Vertex AI and Gemini
- All internal AI models developed or fine-tuned by MERGE engineering or data teams
- All third-party AI services integrated into MERGE workflows, APIs, or products
- All MERGE employees, contractors, and vendors who develop, deploy, administer, or consume AI systems in the course of MERGE operations
- All environments where AI is in use: production, staging, development, and research

### Systems Involved

| System / Platform | AI Risk Context | Scope Status |
|------------------|----------------|--------------|
| Google Vertex AI | Primary AI platform; model hosting, training, inference | In scope -- HITRUST r2 |
| Google Gemini | LLM services; generative AI outputs | In scope -- HITRUST r2 + AI2 |
| C3PO (Claude Code via Anthropic API) | CISO operations augmentation tool | In scope -- AI2 |
| Future AI tools / SaaS | Any AI capability with access to MERGE data | In scope upon adoption |

### Out of Scope

- General IT systems with no AI/ML components
- Internal analytics or statistical tools that do not use ML models

---

## 3. Roles and Responsibilities

| Role | Responsibilities |
|------|----------------|
| Chief of Information Security (CISO) -- Roze San Nicolas | Assessment owner; final risk acceptance authority; signs off on treatment decisions; uploads evidence to Vanta |
| Technical Owner (AI Systems) -- Michael Wood | Provides system-specific technical input; validates control configurations; owns technical remediation |
| Executive Leadership / Review Board | Reviews and approves risk acceptance decisions for High and Critical risks; provides resource authorization for remediation |
| Legal Counsel | Reviews regulatory and compliance risks; advises on treatment decisions with legal exposure |
| Assessment Participants | SMEs from Engineering, TechOps, and any system owners relevant to in-scope AI systems |

---

## 4. Definitions

| Term | Definition |
|------|-----------|
| AI Risk | The potential for an adverse outcome arising from the development, deployment, or operation of an AI system -- including model failure, adversarial manipulation, data leakage, bias, or regulatory non-compliance |
| Likelihood | Probability that a risk event will materialize within the 180-day assessment window: Low (<10%), Medium (10-50%), High (>50%) |
| Impact | Severity of harm if a risk event occurs: Low (<$10K), Medium ($10K-$100K), High ($100K-$1M), Critical (>$1M or regulatory action) |
| Risk Score | Likelihood × Impact; used to prioritize treatment: Critical (9-12), High (6-8), Medium (3-5), Low (1-2) |
| Inherent Risk | Risk level before any controls are applied |
| Residual Risk | Risk level after existing controls are factored in |
| Risk Treatment | The decision made for a given risk: Mitigate, Avoid, Transfer, or Accept |
| Risk Register | The master inventory of identified AI risks, their scores, treatment decisions, owners, and remediation status |
| Prompt Injection | An adversarial input technique in which malicious instructions embedded in user input manipulate an AI model's behavior or extract sensitive data |
| Model Drift | Degradation in AI model performance over time due to changes in input data distribution, real-world conditions, or environmental context |
| AI Model Card | A structured document describing an AI model's purpose, capabilities, training data, risk profile, and approved use cases |
| Vanta | MERGE's GRC automation platform used for evidence collection, control tracking, and HITRUST compliance management. The C3PO agent can query Vanta natively via MCP tools |
| 180-Day Cycle | The mandatory assessment cadence required under HITRUST CSF v11.5 for AI risk reviews |

---

## 5. Procedure

### 5.1 Triggering Conditions

A formal AI Risk Assessment shall be conducted:

1. **Recurring**: Every 180 days from the completion date of the prior assessment (scheduled in Vanta)
2. **Event-triggered**:
   - Deployment of a new AI system or model into production
   - Material change to an existing in-scope AI model (architecture, training data, API surface, access controls)
   - Discovery of a security incident involving an AI system
   - Significant change to MERGE's regulatory environment (new federal AI guidance, HITRUST framework update)
   - Acquisition of a third-party AI tool with access to MERGE data

For event-triggered assessments, scope may be limited to the affected system at the CISO's discretion. Results shall be incorporated into the next scheduled full assessment.

---

### 5.2 Phase 1 -- Preparation (Days 1-5)

**5.2.1 Confirm Scope and Participants**

1. CISO confirms which AI systems are in scope for this assessment cycle
2. CISO notifies Technical Owner, Legal, and relevant SMEs of assessment dates
3. CISO retrieves the current AI Asset Inventory from Vanta (using `list_assets` or `documents` MCP tool)
4. CISO confirms that all in-scope systems have current AI Model Cards (if not, flag as a finding)

**5.2.2 Retrieve Prior Assessment Baseline**

1. Pull the prior AI Risk Register from Vanta (`documents` MCP tool or Vanta risk module)
2. Review treatment plans from the prior cycle -- confirm which remediations were completed, which are outstanding
3. Flag any overdue remediations as immediate findings for this cycle

**5.2.3 Update Risk Register Pre-Population**

1. Open `workspace/vanta-ai-risk-register.csv` as the working risk register template
2. Carry forward all Open risks from the prior cycle with updated status
3. Add any new AI systems or threat scenarios identified since the last assessment
4. Assign preliminary owners for any new risks

---

### 5.3 Phase 2 -- Risk Identification and Scoring (Days 6-10)

**5.3.1 Structured Risk Review**

For each in-scope AI system, conduct a structured review covering the following threat categories:

| Category | Example Threats to Evaluate |
|----------|----------------------------|
| Model Risk | Hallucination, accuracy degradation, model drift, bias |
| Data Risk | PII/PHI exposure, training data leakage, retention violations |
| Security Risk | Prompt injection, unauthorized access, API exposure, supply chain compromise |
| Operational Risk | Vendor outage, cost overrun, inadequate incident response |
| Compliance Risk | HITRUST control gaps, FedRAMP/FISMA violations, IP/copyright issues |

**5.3.2 Score Each Risk**

For each identified risk, document in the risk register:

1. **Risk ID**: Sequential identifier (e.g., AI-001, AI-016 for new risks)
2. **Risk Title**: Short descriptive label
3. **Category and Subcategory**: From the threat category table above
4. **Description**: Concise description of the threat and how it applies to in-scope systems
5. **Likelihood**: Low / Medium / High (see Definitions)
6. **Impact**: Low / Medium / High / Critical (see Definitions)
7. **Risk Score**: Likelihood × Impact (see Definitions)
8. **Risk Owner**: Named individual responsible for treatment and remediation
9. **Control Requirements**: Existing or planned controls that address this risk
10. **Evidence Required**: What artifacts are needed to demonstrate control effectiveness
11. **HITRUST Mapping**: Applicable HITRUST CSF v11.5 control specification IDs

**5.3.3 Evaluate Control Effectiveness**

For each risk with existing controls:

1. Confirm the control is actually implemented (not just documented)
2. Test or verify control effectiveness where feasible (review logs, configs, scan results)
3. Calculate **residual risk** -- the score after effective controls are applied
4. Document gaps between documented and implemented controls as findings

---

### 5.4 Phase 3 -- Treatment Planning (Days 11-15)

**5.4.1 Prioritize by Residual Risk Score**

1. Address Critical (9-12) and High (6-8) risks first -- all require an active treatment plan
2. Medium (3-5) risks require a treatment decision (Mitigate, Accept, Transfer, or Avoid) with documented rationale
3. Low (1-2) risks may be accepted with documented acknowledgment

**5.4.2 Assign Treatment for Each Risk**

For each risk, select and document one treatment decision:

| Treatment | When to Use | Required Documentation |
|-----------|-------------|------------------------|
| **Mitigate** | Controls can reduce likelihood or impact to acceptable level | Remediation plan with owner, target date, and success criteria |
| **Avoid** | Risk is too high and the AI capability is not essential | Decision record; system decommission or use-case restriction |
| **Transfer** | Third-party (e.g., Google SLA, cyber insurance) absorbs the risk | Contract/SLA reference; insurance documentation |
| **Accept** | Residual risk is within MERGE's risk appetite; cost of mitigation exceeds benefit | Formal risk acceptance record signed by CISO and Executive leadership |

**5.4.3 Document Mitigation Plans**

For each Mitigate decision:

1. Define specific control improvements or new controls to implement
2. Assign a named remediation owner (not a team -- an individual)
3. Set a target completion date (Critical: 30 days; High: 90 days; Medium: 180 days)
4. Define success criteria -- what evidence will confirm the control is effective
5. Log a Jira ticket for each remediation item and link it to the risk register entry

---

### 5.5 Phase 4 -- Review, Approval, and Evidence Package (Days 16-20)

**5.5.1 Internal Review**

1. CISO reviews complete risk register and treatment plan for accuracy and completeness
2. Technical Owner validates all technical risk scores and control assessments
3. Legal reviews any risks with regulatory or contractual exposure

**5.5.2 Executive Review and Risk Acceptance**

1. CISO presents assessment findings to Executive Leadership / Review Board
2. All risk acceptance decisions for Critical and High risks require explicit executive sign-off
3. Document sign-off in the risk register (date, approver name, approval method)
4. Any accepted risks above MERGE's stated risk appetite require written justification

**5.5.3 Finalize and Upload Evidence Package to Vanta**

The following artifacts constitute the completed assessment evidence package. Upload all items to Vanta for HITRUST r2 control 01.03a:

| Artifact | Format | Vanta Location |
|----------|--------|----------------|
| Completed AI Risk Register | CSV or PDF export | Risk Management > Documents |
| Risk scoring rationale | This procedure + completed assessment notes | Risk Management > Documents |
| Treatment decisions with approvals | Signed risk acceptance records | Risk Management > Documents |
| Executive sign-off record | Email or meeting notes | Risk Management > Documents |
| Open Jira tickets for remediations | Jira links or export | Integrated evidence (if Jira connected) |
| Assessment completion date | Metadata in Vanta | Risk module assessment record |

To upload via C3PO (Vanta MCP): use the `documents` tool with appropriate framework tag (`HITRUST r2 v11.5`, control `01.03a`).

**5.5.4 Schedule Next Assessment**

1. Set next 180-day assessment date in Vanta
2. Configure Vanta notification: 30-day advance reminder to CISO and Technical Owner
3. Document the next scheduled date in the risk register header

---

### 5.6 Ongoing Monitoring Between Cycles

Between formal 180-day assessments, the following monitoring activities shall run continuously:

| Activity | Frequency | Owner | Vanta Integration |
|----------|-----------|-------|-------------------|
| Review Vanta AI risk dashboard for new findings or status changes | Weekly | CISO | Vanta risk module |
| Monitor Vertex AI model performance metrics for drift indicators | Weekly | Michael Wood | GCP Cloud Monitoring |
| Review security alerts for AI-related incidents (prompt injection, unauthorized access) | Daily | Michael Wood / MSSP | Google SecOps / Foresite |
| Track overdue remediation Jira tickets | Weekly | CISO | Jira |
| Review vendor security bulletins for Vertex AI / Gemini | Monthly | Michael Wood | Manual + Vanta vendor module |
| Confirm critical and high risk remediations are on track | Monthly | CISO | Vanta + Jira |

Any finding from ongoing monitoring that represents a material change to risk posture shall trigger a targeted event-driven assessment per Section 5.1.

---

## 6. Troubleshooting

| Situation | Resolution |
|-----------|-----------|
| Vanta risk module not showing HITRUST r2 framework controls | Confirm HITRUST r2 v11.5 framework is activated in Vanta under Settings > Frameworks; contact Vanta support if framework is missing |
| GCP / Vertex AI integration not syncing to Vanta | Verify GCP API permissions are granted (see `workspace/vanta-ai-risk-assessment-template.md` for required permissions); re-authenticate the Vanta-GCP integration |
| Risk owner is unavailable for assessment cycle | CISO assumes interim ownership; document in risk register and notify executive leadership |
| Executive sign-off cannot be obtained before upload deadline | Document the pending approval status in Vanta; upload all completed artifacts with a note that approval is pending; re-upload signed version upon receipt |
| New AI system discovered mid-cycle without an AI Model Card | Create an AI Model Card immediately using the template; add the system to the AI Asset Inventory; score and treat associated risks in the current cycle |
| Risk score disagreement between CISO and Technical Owner | Escalate to joint review; document both perspectives; use the higher (more conservative) score pending resolution |

---

## 7. Compliance

This procedure is mandatory. Failure to complete the 180-day AI Risk Assessment cycle, maintain a current risk register, or upload required evidence to Vanta constitutes a compliance gap that will be flagged by Vanta, surfaced during HITRUST fieldwork, and reported to executive leadership.

All risk acceptance decisions made outside this procedure (informal, undocumented) are not valid under MERGE's security governance framework and will not satisfy assessor requirements.

---

## 8. Enforcement

Non-compliance with this procedure will result in:

1. Immediate escalation to executive leadership
2. A formal finding documented in Vanta
3. Creation of a corrective action plan with a defined remediation timeline
4. Escalation to MERGE's board-level risk committee if the gap is not remediated within 30 days

The CISO is the enforcement authority for this procedure. The CISO reports compliance status to executive leadership on a quarterly basis.

---

## 9. Review and Change Management

This procedure shall be reviewed:

- **Annually** (next review: 2027-03-11)
- After any significant change to MERGE's AI system portfolio
- After any HITRUST CSF framework version update affecting AI governance controls
- After any AI security incident that reveals a gap in this procedure

All changes require CISO approval. Material changes (scope expansion, new control requirements) require executive sign-off. Changes shall be tracked in the document version history and reflected in Vanta.

---

## 10. Related Documents

| Document | Type | Location |
|----------|------|----------|
| AI Governance, Security & Acceptable Use Policy (POL-0011) | Policy | content/policy/drafts/DRAFT_ai-governance-policy.md |
| Incident Response Policy (POL-0013) | Policy | content/policy/drafts/DRAFT_incident-response-policy.md |
| AI Risk Register | Working Document | workspace/vanta-ai-risk-register.csv |
| Vanta AI Risk Assessment Configuration Template | Reference | workspace/vanta-ai-risk-assessment-template.md |
| HITRUST r2 Audit Prep | Working Document | workspace/HITRUST-r2-v11.5-audit-prep.md |
| HITRUST CSF v11.5 | External Framework | myCSF (HITRUST portal) |
| NIST AI Risk Management Framework (AI RMF) | External Framework | NIST website |
