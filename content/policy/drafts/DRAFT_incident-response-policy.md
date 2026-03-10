# POL-0013 -- Incident Response Policy

**MERGE TechOps Policy**

## Document Control

| Field | Value |
| ----- | ----- |
| Document Number | POL-0013 |
| Version | 3.0 DRAFT |
| Previous Version | MRG-023 v2.0 (Incident Response Policy) |
| Author | Roze San Nicolas, Chief of Information Security |
| Last Updated | 2026-02-23 |
| Document Type | Policy |
| Status | DRAFT -- Pending Legal Review and Leadership Approval |
| Related Procedure | PROC-0002 Incident Reporting Procedure (TBD) |
| Related Playbook | PB -- Google SecOps (v1.0, December 2025) |

**HITRUST CSF v11.5 Control Mapping:**
- 11.a -- Reporting Information Security Events
- 11.a.01 -- Reporting Information Security Events (Control Reference: 11.a-1)
- 11.b -- Management of Information Security Incidents and Improvements
- 11.c -- Responsibilities and Procedures
- 11.d -- Learning from Information Security Incidents
- 09.ab -- Monitoring System Use (AI system monitoring)

**NIST 800-53 Rev 5 Control Mapping:**
- IR-1 -- Incident Response Policy and Procedures
- IR-2 -- Incident Response Training
- IR-3 -- Incident Response Testing
- IR-4 -- Incident Handling
- IR-5 -- Incident Monitoring
- IR-6 -- Incident Reporting
- IR-7 -- Incident Response Assistance
- IR-8 -- Incident Response Plan
- SI-4 -- Information System Monitoring
- AU-6 -- Audit Record Review, Analysis, and Reporting

**HITRUST AI2 Control Mapping:**
- Section 5.4 -- AI Incident Response and Recovery
- Section 5.4.1 -- AI-Specific Incident Classification
- Section 5.4.2 -- AI Model Compromise Response
- Section 5.4.3 -- AI System Recovery Procedures

---

## 1. Purpose

This policy establishes the framework for how MERGE TechOps identifies, reports, responds to, escalates, contains, and recovers from security incidents -- including incidents involving artificial intelligence systems, data breaches, and privacy events. It ensures that MERGE maintains a structured, repeatable incident response capability that satisfies HITRUST CSF v11.5, HITRUST AI2, and NIST 800-53 requirements.

This policy supersedes MRG-023 (Incident Response Policy, v2.0) and incorporates the following updates:
- Alignment to the MERGE TechOps 9-section policy template
- Integration of Foresite MXDR as the 24/7 managed SOC provider
- Google SecOps (Chronicle) as the primary SIEM platform
- AI-specific incident types and response procedures required by HITRUST AI2 Section 5.4
- Severity classification aligned to documented response SLAs
- Explicit HITRUST CSF v11.5 and NIST 800-53 control mappings per section

---

## 2. Scope

### 2.1 Applies To

- All MERGE full-time and part-time employees
- MERGE interns and contract workers
- All providers rendering services as a Business Associate
- Foresite SOC analysts (as MSSP managing detection and initial triage)
- Third-party vendors with access to MERGE systems or data
- AI system operators and developers (AI Garage, DevSecOps, Engineering)

### 2.2 Systems Involved

| System / Platform | Role in Incident Response |
| ----------------- | ------------------------ |
| Google SecOps (Chronicle) | Primary SIEM -- detection, investigation, case management |
| Foresite Citadel MXDR | 24/7 SOC monitoring, alert triage, initial response |
| Foresite Catalyst Portal | Case management, incident tracking, reporting |
| SentinelOne | Endpoint detection and response (EDR) |
| Tenable (Nessus) | Vulnerability assessment, scanner on gcp-secops-nessus-scan01 |
| Jira | Incident ticket tracking, change control, CAP management |
| Vanta | Compliance evidence collection, incident documentation for HITRUST |
| Google Vertex AI / Gemini | AI platform -- in scope for AI-specific incident types |
| 1Password | Credential management during incident response |
| Entra ID (Azure AD) | Identity verification, account suspension during incidents |

### 2.3 Exclusions

- Physical security incidents not involving information systems (handled by Facilities)
- HR-only matters with no information security component
- Scheduled maintenance events and planned outages
- Security scanning alerts that are confirmed false positives after initial triage

---

## 3. Roles and Responsibilities

### 3.1 Incident Response Team (IRT)

MERGE maintains a cross-department Incident Response Team. Members are mandated reporters for incidents in their areas of responsibility.

1. **Chief of Information Security (CISO)** -- Incident Commander. Primary point of contact during all declared incidents. Coordinates response across all teams. Authorizes escalation to executive leadership and external notification. Maintains vendor and client contact lists for incident communication.
2. **MERGE InfoSec Team** -- Leads investigation, containment, eradication, and recovery activities. Conducts forensic analysis. Authors post-incident reports. Coordinates with Foresite SOC on detection and triage.
3. **Foresite SOC (24/7 MSSP)** -- Performs real-time alert monitoring, initial triage, and threat investigation via Google SecOps. Escalates confirmed incidents to MERGE InfoSec per severity SLAs. Manages IOC feeds and YARA-L detection rules.

### 3.2 TechOps

1. **TechOps / SysOps** -- Executes containment and recovery actions on infrastructure (network isolation, system restoration, backup recovery). Provides system access and logs during investigation.
2. **DevSecOps** -- Responds to incidents involving CI/CD pipelines, code repositories, container infrastructure, and supply chain compromise. Leads response for AI system incidents in coordination with AI Garage.

### 3.3 Managers

1. **Department Managers** -- Ensure employees report potential incidents within required timeframes. Facilitate employee cooperation with investigations. Authorize emergency work schedule adjustments during major incidents.
2. **Change Management Board** -- Reviews and approves emergency changes required during incident containment and recovery.

### 3.4 Security Officer (CISO)

1. Maintains overall accountability for the incident response program
2. Declares and closes formal incidents
3. Authorizes external notifications (clients, vendors, regulators, law enforcement)
4. Conducts or delegates post-incident investigations
5. Ensures Vanta evidence collection for HITRUST compliance
6. Reports incident metrics and trends to executive leadership quarterly
7. Maintains and tests incident response plans annually

---

## 4. Definitions

| Term | Definition |
| ---- | ---------- |
| **Security Incident** | An event that actually or potentially jeopardizes the confidentiality, integrity, or availability of an information system or the information it processes, stores, or transmits, or that constitutes a violation of security policies, procedures, or acceptable use policies |
| **Security Event** | An observable occurrence in a system or network that may indicate a security incident. Not all events are incidents. |
| **Data Breach** | Unauthorized access to or disclosure of data classified as internal, confidential, or higher -- including Protected Health Information (PHI) |
| **AI Incident** | A security event specifically involving an AI system, including but not limited to: model compromise, training data poisoning, adversarial input attacks, unauthorized model access, AI output producing harmful or incorrect results affecting business decisions or patient safety |
| **Indicator of Compromise (IOC)** | An artifact observed on a network or in an operating system that indicates a computer intrusion with high confidence (e.g., malicious IP, file hash, domain) |
| **Incident Commander** | The individual (CISO or designee) who has overall authority and responsibility for managing the incident response |
| **Containment** | Actions taken to limit the scope and impact of an incident, preventing further damage while preserving evidence |
| **Eradication** | Removal of the threat actor, malware, or vulnerability that caused the incident |
| **Recovery** | Restoration of systems and data to normal operations after containment and eradication |
| **Corrective Action Plan (CAP)** | A documented remediation plan with specific actions, owners, timelines, and success criteria to prevent incident recurrence |
| **Post-Incident Report (PIR)** | A formal written report documenting the incident timeline, root cause, impact, response actions, and lessons learned |
| **MSSP** | Managed Security Service Provider -- Foresite provides 24/7 SOC services for MERGE via Citadel MXDR |
| **SIEM** | Security Information and Event Management -- Google SecOps (Chronicle) serves as MERGE's SIEM |
| **Tabletop Exercise** | A discussion-based exercise where team members walk through an incident scenario to test the response plan without actually executing technical actions |
| **MITRE ATT&CK** | A knowledge base of adversary tactics and techniques used to classify and understand threat behavior during investigation |
| **MITRE ATLAS** | A knowledge base of adversary tactics and techniques specific to AI/ML systems, used to classify AI-specific threats |

---

## 5. Policy Overview

### 5.1 Incident Response Team Structure

1. MERGE shall maintain a cross-department Incident Response Team (IRT) with representatives from InfoSec, TechOps, DevSecOps, AI Garage, Legal, HR, and executive leadership.
2. IRT membership shall be reviewed annually by the CISO. Changes in membership shall be documented and communicated within 5 business days.
3. Incident Response Training shall be provided to IRT members within 90 days of assuming their position and annually thereafter. Training shall include:
   - NIST incident response lifecycle (Preparation, Detection, Containment, Eradication, Recovery, Post-Incident)
   - MERGE-specific IR procedures and escalation paths
   - AI-specific incident scenarios (per HITRUST AI2 Section 5.4)
   - Foresite SOC coordination procedures
   - Evidence preservation and chain-of-custody requirements
4. All MERGE employees shall receive annual security awareness training that includes how to recognize and report potential security incidents.

> **HITRUST Evidence Note**: IRT roster, training records, and attendance logs satisfy HITRUST 11.c (Responsibilities and Procedures) and NIST IR-2 (Incident Response Training).

### 5.2 Incident Reporting

1. All employees shall report suspected or actual security incidents to the Incident Response Team within **24 hours** of discovery via:
   - Foresite SOC: 877-426-0244 (phone, 24/7) or soc@foresite.com (email, 24/7)
   - MERGE InfoSec: Direct contact with CISO or InfoSec team member
   - Jira: Create an incident ticket in the designated IR project
2. The Foresite SOC and MERGE InfoSec team shall triage all reports and determine whether to declare a formal incident.
3. Upon declaration of an incident, the Incident Commander (CISO or designee) shall notify internal stakeholders, external stakeholders, clients, vendors, and other involved parties within the timeframes specified in Section 5.4 (Severity Classification).
4. The CISO shall maintain a current contact list for vendors and clients to use in case of an incident or emergency. This list shall be reviewed quarterly and stored in 1Password (TechOps - InfoSec Operations vault).
5. Employees who report suspected incidents in good faith shall not face retaliation, regardless of whether the report is confirmed as an actual incident.

> **HITRUST Evidence Note**: Reporting procedures, contact lists, and 24-hour reporting requirement satisfy HITRUST 11.a (Reporting Information Security Events) and NIST IR-6 (Incident Reporting).

### 5.3 Incident Declaration and Command

1. The Incident Response Team shall be responsible for declaring a formal incident based on the triage outcome and the team's professional judgment.
2. The CISO or their designee shall serve as Incident Commander and coordinate all response activities.
3. The Incident Commander shall:
   - Establish an incident communication channel (dedicated Slack channel, bridge call, or war room as appropriate)
   - Assign roles: Lead Investigator, Communications Lead, Technical Lead, Evidence Custodian
   - Authorize containment actions, including emergency changes without standard change control
   - Determine notification requirements (regulatory, contractual, law enforcement)
   - Set the incident cadence (status update frequency based on severity)

> **HITRUST Evidence Note**: Incident declaration procedures satisfy HITRUST 11.b (Management of Information Security Incidents) and NIST IR-4 (Incident Handling).

### 5.4 Severity Classification and Response SLAs

All incidents shall be classified using the following severity matrix, aligned to Foresite MSSP response SLAs:

| Severity | Response Time | Escalation | Update Cadence | Examples |
| -------- | ------------- | ---------- | -------------- | -------- |
| **Critical** | 15 minutes | Immediate Foresite SOC + MERGE InfoSec + Executive Leadership | Every 30 minutes until contained | Active data breach, ransomware, compromised AI model in production, widespread system outage |
| **High** | 1 hour | Foresite SOC + MERGE InfoSec notification | Every 2 hours until contained | Confirmed intrusion, credential compromise, AI training data poisoning detected, DDoS attack |
| **Medium** | 4 hours | Foresite SOC triage, MERGE InfoSec informed | Daily until resolved | Malware detection on single endpoint, suspicious account activity, failed AI guardrail triggering investigation |
| **Low** | Next business day | Standard queue | Weekly until resolved | Policy violation, phishing attempt blocked, minor misconfigurations, AI output anomaly under review |

Severity may be escalated at any time by the Incident Commander based on evolving information.

> **HITRUST Evidence Note**: Severity classification and SLA alignment satisfy HITRUST 11.c (Responsibilities and Procedures) and NIST IR-4 (Incident Handling).

### 5.5 Incident Response Plans

1. Individual Incident Response Plans (IRPs) shall be maintained to cover potential or probable incidents as outlined by the outcome of risk assessments. IRPs shall be maintained for at least the following categories:

   **Traditional Security Incidents:**
   - Virus / Malware infection
   - Digital intrusion / unauthorized access
   - Denial of Service (DoS) or Distributed Denial of Service (DDoS) attack
   - Information leak or privacy breach (including unauthorized disclosure of PHI)
   - Physical intrusion affecting information systems
   - Property theft involving IT assets or data
   - Insider threat
   - Ransomware
   - Supply chain compromise
   - Credential compromise / account takeover

   **AI-Specific Incidents (HITRUST AI2 Section 5.4):**
   - AI model compromise (unauthorized modification of model weights, parameters, or configuration)
   - Training data poisoning (injection of malicious or biased data into training pipelines)
   - Adversarial input attack (prompt injection, model evasion, jailbreaking)
   - AI output incident (model produces harmful, biased, or clinically dangerous output)
   - Unauthorized AI model deployment (unapproved model pushed to production)
   - AI data exfiltration (extraction of training data or proprietary model information)
   - AI supply chain compromise (compromised model dependencies, libraries, or pre-trained components)

2. Each IRP shall document: detection indicators, containment procedures, eradication steps, recovery procedures, communication templates, and evidence preservation requirements.
3. IRPs shall reference the relevant MITRE ATT&CK techniques (traditional incidents) or MITRE ATLAS techniques (AI incidents) for threat classification.

> **HITRUST Evidence Note**: AI-specific incident plans directly satisfy HITRUST AI2 Section 5.4 (AI Incident Response and Recovery) and NIST IR-8 (Incident Response Plan).

### 5.6 AI System Incident Response Requirements

In addition to standard incident response procedures, the following requirements apply specifically to incidents involving AI systems (Vertex AI, Gemini, and any AI/ML models deployed by MERGE):

1. **AI Incident Classification**: All incidents involving AI systems shall be classified using both the standard severity matrix (Section 5.4) and the MITRE ATLAS framework for AI-specific threat categorization.
2. **Model Isolation**: Upon declaration of an AI-specific incident, the affected model or AI service shall be isolated from production traffic within the response SLA for its severity level. Model isolation procedures shall be documented in the AI-specific IRPs.
3. **AI Evidence Preservation**: In addition to standard log preservation, AI incidents require preservation of:
   - Model version and configuration at time of incident
   - Input data that triggered or contributed to the incident
   - Model output logs for the affected time period
   - Training data pipeline state (if data poisoning suspected)
   - API access logs for the affected AI service
4. **AI Model Recovery**: Recovery from AI incidents may require model rollback, retraining, or redeployment. The DevSecOps team and AI Garage shall maintain documented rollback procedures for all production AI models.
5. **AI Incident Metrics**: The CISO shall track and report the following AI-specific incident metrics quarterly:
   - Number of AI-specific incidents by type
   - Mean time to detect AI model compromise
   - Mean time to isolate compromised AI models
   - Number of AI guardrail failures requiring investigation
   - AI incident recurrence rate

> **HITRUST Evidence Note**: AI-specific incident procedures satisfy HITRUST AI2 Section 5.4.1 (AI-Specific Incident Classification), 5.4.2 (AI Model Compromise Response), and 5.4.3 (AI System Recovery Procedures).

### 5.7 Investigation and Post-Incident Reporting

1. All investigations shall be conducted by the CISO or their designee. All personnel are mandated to cooperate with investigations.
2. An investigation report shall include, at minimum:
   - Description of the incident and supporting data from system logs, Google SecOps, SentinelOne, or other audit sources
   - Timeline of events from detection through resolution
   - List of involved employees, accounts, and/or systems
   - Immediate containment and remediation steps taken with timeline
   - Notification actions taken (clients, vendors, regulators, law enforcement)
   - Determination of fault or involvement on the part of any employee
   - Disciplinary action(s) recommended for involved employee(s)
   - Corrective Action Plan (CAP) for involved systems, employees, contractors, or vendors. Each CAP shall include a remediation timeline, assigned owner, and outcome documented in Jira.
   - Root cause analysis
   - Lessons learned and recommendations for preventing recurrence
   - HITRUST control impact assessment (which controls were affected and evidence implications)
3. If an investigation finds fault or breach on the part of any employee(s), sanctions shall be applied by the HR Department after consultation with the IRT. HR shall maintain records of investigations and sanctions in MERGE personnel files.
4. A Post-Incident Report (PIR) shall be written for each declared incident. PIRs shall identify recurring patterns, high-impact findings, and systemic weaknesses. Reports shall be used to improve Incident Response Plans during annual review.
5. Post-incident reviews shall be conducted within 10 business days of incident closure for Critical and High severity incidents, and within 30 business days for Medium severity.

> **HITRUST Evidence Note**: Investigation reports and PIRs satisfy HITRUST 11.d (Learning from Information Security Incidents) and NIST IR-4 (Incident Handling).

### 5.8 Testing and Evaluation

1. MERGE shall test its incident response capabilities at least annually through one or more of the following methods:
   - Formal tabletop exercise simulating a realistic incident scenario
   - Functional exercise involving actual system isolation and recovery
   - Response to actual incidents (documented as a test of IR capabilities)
2. Annual testing shall include at least one AI-specific incident scenario (per HITRUST AI2 Section 5.4 requirements).
3. Tests shall exercise, at minimum:
   - Reporting mechanisms (Foresite SOC, internal channels, Jira)
   - Severity classification and escalation procedures
   - Communication with external parties (clients, vendors, regulators)
   - Evidence preservation and chain-of-custody procedures
   - The appropriate Incident Response Plan execution
   - Post-incident report generation
4. Test results, findings, and improvement recommendations shall be documented and retained as HITRUST evidence.
5. Incident Response Plans shall be reviewed annually or more frequently if the IRT determines updates are needed to address new or evolving threats.

> **HITRUST Evidence Note**: Annual testing records, tabletop exercise documentation, and plan review logs satisfy HITRUST 11.b (Management of Information Security Incidents) and NIST IR-3 (Incident Response Testing).

### 5.9 MSSP Integration

1. Foresite Citadel MXDR serves as MERGE's 24/7 managed SOC. The Foresite SOC is the first line of detection and triage for all security events.
2. Alert triage and initial analysis: Foresite SOC is Responsible; MERGE InfoSec is Accountable (per RACI matrix in systems.md).
3. Foresite SOC shall escalate confirmed incidents to MERGE InfoSec within the response SLAs defined in Section 5.4.
4. MERGE InfoSec retains authority over incident declaration, external communication, and final incident disposition.
5. Foresite TAMs (Sam Waris, Mark Lavallee) serve as the primary coordination points for SOC service issues, rule tuning, and quarterly threat briefings.
6. The MSSP relationship shall be reviewed annually as part of the vendor risk assessment cycle.

> **HITRUST Evidence Note**: MSSP integration procedures satisfy HITRUST 11.c (Responsibilities and Procedures) and NIST IR-7 (Incident Response Assistance).

---

## 6. Compliance

### 6.1 Exception Handling

Exceptions to this policy must be approved by the CISO in advance and documented in Jira with:
- Business justification for the exception
- Risk assessment of the exception
- Compensating controls in place
- Expiration date (exceptions shall not exceed 12 months without renewal)

Approved exceptions shall be reviewed quarterly and reported to executive leadership annually.

---

## 7. Enforcement

1. **Compliance Measurement**: The CISO shall verify compliance through business tool reports, internal and external audits, Google SecOps log monitoring, Vanta compliance dashboards, employee feedback, and incident response testing results.
2. **Non-Compliance Consequences**: Failure to comply with this policy shall result in disciplinary action per the MERGE Employee Handbook. Consequences may include warnings, mandatory retraining, suspension, or termination, depending on the severity and intent of the violation. Violations of federal and state law may result in legal action.
3. **Mandatory Cooperation**: All personnel are required to cooperate fully with incident investigations. Failure to cooperate or deliberate obstruction of an investigation shall be treated as a separate policy violation.

---

## 8. Review & Change Management

### 8.1 Review Frequency

| Review Type | Frequency | Reviewer |
| ----------- | --------- | -------- |
| Quarterly review | Every 3 months | CISO |
| Annual review | Every 12 months | CISO + TechOps Leadership |
| Post-incident review | After each Critical/High incident | IRT |
| Ad hoc update | As needed for new threats | CISO |
| HITRUST assessment cycle | Per assessment timeline | CISO + A-LIGN |

### 8.2 Approval Workflow

All updates to this policy shall follow:

1. Review by Policy Owner (CISO)
2. Legal review (for notification requirements, regulatory compliance)
3. Compliance & Security Validation (Vanta evidence alignment)
4. Approval by TechOps Leadership

**Current Status**: DRAFT -- version 3.0 update incorporating MERGE template alignment, Foresite MSSP integration, Google SecOps platform, and HITRUST AI2 requirements.

**HITRUST Phase 1 Evidence Checklist**:
- [ ] Policy approved by TechOps Leadership
- [ ] Policy uploaded to Vanta as evidence for IR-1, IR-2, IR-3, IR-4, IR-5, IR-6, IR-7, IR-8
- [ ] Policy uploaded to Vanta as evidence for HITRUST 11.a, 11.b, 11.c, 11.d
- [ ] Policy uploaded to Vanta as evidence for HITRUST AI2 Section 5.4
- [ ] IRT roster documented and current
- [ ] Annual tabletop exercise scheduled (must include AI scenario)
- [ ] Foresite SOC escalation procedures documented and tested
- [ ] AI-specific incident response plans drafted for each AI incident type

---

## 9. Related Procedures

| Document | Relationship |
| -------- | ------------ |
| PROC-0002 Incident Reporting Procedure | Implementing procedure for this policy (TBD) |
| PB -- Google SecOps (v1.0) | Operational playbook for SIEM platform, severity SLAs, SOC contacts |
| POL-0011 AI Governance, Security & Acceptable Use Policy | Parent AI governance policy; AI incident types derive from AI risk categories in POL-0011 |
| POL-0012 Secure SDLC Policy | DevSecOps incident response for pipeline and code security incidents |
| STD-0002 Container Security Standard | Container-specific incident classification and response |

**Related Policies:**
- Access Control Policy (account suspension during incidents)
- Data Classification and Handling Policy (breach notification requirements by data class)
- Risk Management Policy (risk register updates post-incident)
- Business Continuity and Disaster Recovery Policy (DR activation criteria)

---

## Revision History

| Version | Date | Author | Approving Body | Changes |
| ------- | ---- | ------ | -------------- | ------- |
| 1.0 | 08/05/2018 | [Original Author] | Executive Leadership Team | Initial draft |
| 1.0 | 08/13/2019 | [Original Author] | Executive Leadership Team | Yearly review |
| 1.1 | 05/29/2020 | [Original Author] | Executive Leadership Team | Yearly review, clarify CAPs |
| 1.2 | 08/17/2021 | [Original Author] | Executive Leadership Team | Yearly review, clarification of language |
| 1.2 | 04/22/2022 | [Original Author] | Executive Leadership Team | Yearly review |
| 2.0 | 10/2022 | [Original Author] | IT Leadership Team | HITRUST follow-up review and branding updates |
| 2.0 | 06/2023 | [InfoSec] | Information Security | Yearly review, no changes |
| 2.0 | 12/12/2023 | [InfoSec] | InfoSec | 2024 IT acknowledgments, GRC language update |
| 2.0 | 05/28/2024 | [InfoSec] | InfoSec | HITRUST review period |
| 2.0 | 05/2025 | [InfoSec] | InfoSec | HITRUST review |
| 3.0 | 2026-02-23 | Roze San Nicolas | DRAFT -- Pending | MERGE template alignment; Foresite MSSP integration; Google SecOps SIEM; AI-specific incident types (HITRUST AI2 5.4); severity SLAs; HITRUST/NIST control mappings; expanded definitions |

---

Approved by: _________________ Date: _______

Title: _______________________

---

*This document is controlled and maintained by MERGE TechOps. Unauthorized alterations are prohibited.*
