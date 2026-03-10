# POL-0011 AI Governance, Security, and Acceptable Use Policy

MERGE TechOps Policy

**Document Control**

| Field | Value |
|-------|-------|
| Document Number | POL-0011 |
| Version | 2.0 |
| Status | APPROVED -- Legal and Leadership Approval Completed 2026-02-22 |
| Author | Roze San Nicolas |
| Owner | Roze San Nicolas, Chief of Information Security |
| Last Updated | 2026-02-22 |
| Next Review | 2027-02-21 (annual) |
| Document Type | Policy |
| Related Procedure | PROC - AI Garage Operations, PROC - DevSecOps AI Integration, PROC - Google SecOps |
| Based On | MERGE TechOps POL-0011 v2.0 (Feb 18, 2026) -- reformatted for HITRUST evidence submission |

**HITRUST CSF v11.5 Control Mapping**:
09.ab (AI Security Governance), 01.a (Information Security Policy), 05.h (Asset Inventory),
07.a (Information Classification), 09.a (Access Control Policy), 09.aa (Change Control),
09.ab.01 (AI Governance), 09.ab.02 (AI Risk Assessment), 09.ab.03 (AI Data Management),
09.ab.04 (AI Threat Management), 09.ab.05 (AI Model Security), 09.ab.06 (AI Accountability),
09.ab.07 (AI Access Control)

**NIST 800-53 Rev 5 Control Family Mapping**:
SA (System and Services Acquisition), RA (Risk Assessment), PL (Planning),
PM (Program Management), AC (Access Control), IR (Incident Response),
CM (Configuration Management), SI (System and Information Integrity),
SR (Supply Chain Risk Management), PT (PII Processing and Transparency)

**NIST AI RMF v1.0 Function Mapping**:
GOVERN (GV), MAP (MP), MEASURE (MS), MANAGE (MG)

---

## 1. Purpose

This policy establishes the governance framework for MERGE's secure and ethical use of Artificial Intelligence (AI) systems, ensuring comprehensive AI threat management, data protection, model security, and compliance. It aligns with:

- HITRUST CSF v11.5 r2 AI Security Assessment (ai2) requirements
- NIST AI Risk Management Framework (AI RMF) v1.0
- ISO/IEC 42001:2023
- OWASP Top 10 for LLMs
- MITRE ATLAS framework

This policy addresses the risk that MERGE's use of AI systems — including generative AI in client work and operational AI agents in production — may expose the organization to threats including prompt injection, data poisoning, model evasion, unauthorized data disclosure, and reputational harm from uncontrolled AI outputs.

This policy serves as the enterprise-level AI governance document. Vertical-specific teams — AI Garage, DevSecOps, and TechOps (Information Security, Security Operations, System Operations) — shall establish and maintain tool-specific procedures implementing these requirements.

**HITRUST Evidence Note**: Satisfies HITRUST ai2 Control Category 09.ab.01 requirement for a documented, approved AI governance policy.

---

## 2. Scope

This policy applies to all MERGE personnel and systems involved in the development, deployment, operation, and use of Artificial Intelligence systems.

**Applies To**:

- All MERGE full-time employees, part-time employees, interns, and contract workers
- All providers rendering services as a Business Associate (limited access to AI tools and data directly related to contracted work)
- All MERGE verticals: AI Garage, DevSecOps, TechOps (SysOps / InfoSec / SecOps)
- Managers overseeing AI system users
- Third-party vendors providing AI-enabled services

**Systems Involved**:

| System | Category | Risk Tier |
| ------ | -------- | --------- |
| MERGE AIgency platform and associated AI services | Production AI | High |
| Google Vertex AI / Gemini | AI infrastructure | High |
| Agency-approved generative AI tools (Claude, Gemini, Jasper, Lovable) | Generative AI | Medium-High |
| Client-facing AI integrations | External-facing AI | High |
| AI development / testing / production environments on GCP | AI infrastructure | High |
| AI model APIs and inference endpoints | AI infrastructure | High |
| Data pipelines for AI training and inference | Data | High |
| Google SecOps SIEM (AI system monitoring) | Monitoring | Medium |
| SentinelOne EDR | Security tooling | Medium |
| Vanta GRC | Compliance | Medium |

**Exclusions**:

- Personal use of public AI tools on personal devices outside MERGE work
- AI systems operated entirely by third-party SaaS with no MERGE data processed
- Sandboxed research evaluations with no production data (governed by AI Garage evaluation procedures)

**HITRUST Evidence Note**: Defines scope boundary required for HITRUST ai2 assessment scoping documentation.

---

## 3. Roles and Responsibilities

### 3.1 AI Garage and DevSecOps

| Role | Accountability |
| ---- | -------------- |
| AI Garage | AI model development, model inventories, change control, pre-deployment testing, guardrail implementation |
| DevSecOps | Secure AI SDLC, CI/CD pipeline security, environment separation, API security controls |

### 3.2 TechOps (SecOps / InfoSec)

| Role | Accountability |
| ---- | -------------- |
| TechOps / SecOps | Continuous monitoring, threat detection, AI incident response, access reviews, audit logging |
| All Employees and Contractors | Annual training, credential safeguarding, prohibited data input, incident reporting within 24 hours |

### 3.3 Managers

| Role | Accountability |
| ---- | -------------- |
| Managers | Team training compliance, AI access approvals with business justification, policy violation escalation |

### 3.4 Security Officer (CISO)

| Role | Accountability |
| ---- | -------------- |
| Chief of Information Security (CISO) | Policy ownership, AI governance program, compliance verification, HITRUST coordination |

**HITRUST Evidence Note**: Role definitions satisfy HITRUST ai2 requirement for documented roles and responsibilities in AI governance.

---

## 4. Definitions

| Term | Definition |
| ---- | ---------- |
| AI System | Any software system that uses machine learning, deep learning, or other artificial intelligence techniques to process data, generate outputs, or support decision-making. Includes generative AI, predictive models, and autonomous agents. |
| AI Model Card | A structured document describing an AI model's purpose, training data, performance characteristics, risk level, limitations, and responsible owner. Required for HITRUST AI2 evidence. |
| AI Risk Assessment | A formal evaluation of threats, vulnerabilities, and potential impacts associated with an AI system, conducted per MITRE ATLAS and OWASP Top 10 for LLMs threat taxonomies. |
| Generative AI | AI systems capable of generating text, images, code, audio, or other content based on learned patterns. Includes large language models (LLMs) and multimodal models. |
| Prompt Injection | An adversarial attack in which malicious input is crafted to manipulate an LLM into executing unintended instructions, bypassing safety controls, or disclosing restricted information. |
| Data Poisoning | An attack that compromises the integrity of AI training data by injecting malicious, biased, or misleading samples to alter model behavior. |
| Model Evasion | An adversarial technique in which inputs are deliberately crafted to cause an AI model to produce incorrect outputs or misclassifications while appearing benign. |
| HITRUST ai2 | HITRUST's AI-specific security assurance certification covering AI system governance, data integrity, model security, and AI lifecycle risk management. |
| Vanta | GRC automation platform used by MERGE for HITRUST evidence collection, control tracking, continuous compliance monitoring, and AI risk assessment scheduling. |
| Vertex AI | Google Cloud's managed AI platform for building, deploying, and managing machine learning models. Primary AI infrastructure in scope for HITRUST r2 and AI2 assessments. |
| MITRE ATLAS | Adversarial Threat Landscape for AI Systems. A knowledge base of adversary tactics and techniques targeting AI/ML systems, maintained by MITRE Corporation. |
| OWASP Top 10 for LLMs | A security-focused ranking of the most critical vulnerabilities and risks in large language model applications, published by the Open Worldwide Application Security Project. |
| Metaprompt | A system-level prompt or instruction set provided to an LLM prior to user interaction that defines the model's behavior boundaries, persona, and safety constraints. |
| Guardrail | A technical or procedural control implemented to constrain AI system behavior within acceptable boundaries, including output filtering, content moderation, input validation, and safety classifiers. |

---

## 5. Policy Overview

The following statements establish mandatory, auditable requirements for MERGE AI systems security, aligned with HITRUST CSF v11.5 r2 ai2 control domains.

### 5.1 AI System Governance

MERGE shall maintain a formal AI governance program ensuring all AI systems are inventoried, risk-assessed, and managed throughout their lifecycle.

1. All AI systems must be registered in the TechOps Systems Inventory with documented purpose, data flows, model type, risk classification, and responsible owner.
2. This policy shall be reviewed at least annually, approved by TechOps leadership, and communicated to all affected personnel.
3. AI-specific procedures shall be established by each responsible vertical (AI Garage, DevSecOps, TechOps) and reviewed at least annually.
4. The Change Management Board shall approve new AI deployments and significant model changes prior to production.

*HITRUST Mapping*: 09.ab.01 | *NIST 800-53*: PL-1, PM-1, PM-9 | *NIST AI RMF*: GV-1.1, GV-1.2

### 5.2 AI Risk Management

MERGE shall implement AI-specific risk assessments addressing threats identified in the MITRE ATLAS framework and OWASP Top 10 for LLMs.

1. AI risk assessments shall be conducted quarterly, upon material system changes, and when new AI systems are introduced. Assessments shall be completed in Vanta at no less than a 180-day cadence.
2. Assessments shall address data poisoning, model evasion, prompt injection, model extraction, hallucination risks, and AI supply chain compromise.
3. Third-party AI services shall be assessed for security risk prior to adoption and on a regular basis per Third-Party Risk Management protocols with the procurement team.
4. AI systems processing PII, PHI, or client confidential data must undergo a data protection impact assessment prior to deployment.

*HITRUST Mapping*: 09.ab.02 | *NIST 800-53*: RA-1, RA-2, RA-3, SA-11 | *NIST AI RMF*: MP-1.1, MP-2.1, MS-1.1

### 5.3 AI Data Privacy and Protection

MERGE shall ensure that data used in AI systems meets applicable privacy regulations, contractual obligations, and the principle of data minimization.

1. Employees shall not input PII, PHI, or client confidential data into any AI system unless: (a) explicitly authorized in an approved SOW or project charter; (b) reviewed and approved by the Change Management Board and Data Privacy Officer; (c) appropriate technical safeguards are documented and in place; and (d) the AI provider's data processing terms permit such use.
2. Data used in AI development, testing, or training shall be anonymized or pseudonymized unless the use of identifiable data is explicitly authorized under contractual agreement or change management exclusions.
3. AI system data flows shall be mapped, documented, and reviewed at least annually.
4. Data subject rights (access, correction, deletion, objection to automated decision-making) shall be supported for AI processing subject to GDPR, CCPA/CPRA, and HIPAA.

*HITRUST Mapping*: 09.ab.03 | *NIST 800-53*: PT-1, PT-2, SI-12 | *NIST AI RMF*: GV-1.6, MP-2.3

### 5.4 AI Threat Management

MERGE shall implement AI-specific threat detection, prevention, and response capabilities.

1. AI threat modeling shall be conducted for all production AI systems addressing MITRE ATLAS and OWASP Top 10 for LLM threats.
2. AI systems shall undergo security testing prior to production deployment and at least annually thereafter, with additional testing triggered by significant model updates or security incidents.
3. AI-specific incident response procedures shall be maintained as part of the Incident Response Plan, covering detection, containment, model rollback, evidence preservation, and post-incident analysis.
4. AI systems exposed to external inputs shall implement input validation and sanitization controls proportionate to risk classification.

*HITRUST Mapping*: 09.ab.04 | *NIST 800-53*: IR-1, IR-8, SI-3, SA-11 | *NIST AI RMF*: MS-2.5, MG-2.2

### 5.5 AI Model Security

MERGE shall implement controls ensuring the integrity, confidentiality, and availability of AI models throughout their lifecycle.

1. All changes to production AI models shall be documented, reviewed, and approved through change management prior to deployment.
2. AI models shall undergo pre-deployment testing validating functional correctness, security posture, and safety guardrail effectiveness.
3. Training data provenance, quality validation, and integrity checks shall be maintained for all AI models.
4. Output filtering and guardrails shall be implemented to prevent generation of harmful, biased, or policy-violating content.
5. Metaprompt security shall be implemented for LLM-based systems to prevent jailbreaking and unauthorized behavior manipulation.

*HITRUST Mapping*: 09.ab.05 | *NIST 800-53*: CM-3, SA-3, SI-7 | *NIST AI RMF*: MS-1.3, MG-1.3, MG-3.2

### 5.6 AI Data Quality Management

MERGE shall ensure data used in AI systems meets quality, provenance, and integrity standards.

1. Training data shall have documented provenance including source, collection methodology, and quality assurance measures.
2. A data catalog for AI systems shall be maintained documenting available datasets, classification, and access controls.
3. Input and output quality monitoring shall be implemented for production AI systems to detect data drift, anomalous inputs, and model degradation.

*HITRUST Mapping*: 09.ab.03 | *NIST 800-53*: SI-7, SA-8 | *NIST AI RMF*: MS-1.1, MS-2.1

### 5.7 AI Explainability and Accountability

MERGE shall implement transparency, accountability, and fairness controls for AI systems.

1. AI systems supporting decisions affecting individuals shall provide transparency proportionate to impact and regulatory requirements.
2. Bias identification and mitigation programs shall be established for AI systems with potential for discriminatory outcomes.
3. Each production AI system shall have a designated owner accountable for its security, performance, and compliance.
4. Human oversight requirements shall be defined based on AI system risk classification.

*HITRUST Mapping*: 09.ab.06 | *NIST 800-53*: PM-10, PM-28 | *NIST AI RMF*: GV-1.4, GV-4.1, MP-4.1

### 5.8 AI Access Controls

MERGE shall implement access controls protecting AI systems, models, data, and infrastructure from unauthorized access.

1. Access to AI systems shall follow the principle of least privilege, with documented business justification and quarterly review.
2. AI system APIs shall enforce strong authentication, authorization, and rate limiting to prevent abuse and model extraction.
3. Privileged access to AI model management functions must require multi-factor authentication.
4. AI system access events shall be logged, forwarded to Google SecOps SIEM, and retained per MERGE log retention requirements.

*HITRUST Mapping*: 09.ab.07 | *NIST 800-53*: AC-1, AC-2, AC-6, AC-17 | *NIST AI RMF*: GV-1.2, MS-1.3

### 5.9 Cloud Provider and Third-Party AI Inheritance

MERGE shall leverage control inheritance from certified AI platform providers where appropriate.

1. AI platform providers shall be verified for HITRUST certification status and External Inheritance Program participation.
2. Shared responsibility matrices shall be obtained, reviewed, and documented for each AI platform provider.
3. Inheritance requests shall be submitted through HITRUST MyCSF for applicable controls, with complementary controls implemented for all gaps.

*HITRUST Mapping*: 09.ab, External Inheritance | *NIST 800-53*: SR-1, SR-3, SR-5 | *NIST AI RMF*: GV-1.5

### 5.10 Acceptable Use of AI Systems

All MERGE personnel and contractors shall use AI systems in accordance with MERGE's ethical and operational standards.

1. All employees and contractors must complete annual AI security awareness training and acknowledge this policy in the employee handbook.
2. AI credentials (API keys, tokens, access credentials) shall not be shared and must be safeguarded per MERGE access control standards.
3. Employees shall not use AI systems to generate content that is deceptive, discriminatory, harmful, or in violation of intellectual property rights.
4. Without explicit disclosure and client consent, generative AI assets shall not be used as final client deliverables.
5. Suspected AI security incidents shall be reported within 24 hours to Information Security.

*HITRUST Mapping*: 09.ab.01, 09.ab.07 | *NIST 800-53*: PL-4, PS-6 | *NIST AI RMF*: GV-1.1, GV-6.1

### 5.11 AI Code of Ethics

MERGE leadership has established the following principles to govern AI use across the organization:

**Principle 1 -- Progressive Innovation**: Foster a culture of experimentation with AI across agency practice areas, pushing the boundaries of creativity and innovation while maintaining security and privacy safeguards.

**Principle 2 -- Responsible Ideation**: Use AI to facilitate creative brainstorming, concept development, copywriting, and programming where applicable. Provide proper attribution of generative AI assets in client-facing materials.

**Principle 3 -- Transparency and Client Approval**: Without explicit disclosure and client consent, generative AI assets shall not be used as final output. Client deliverables using AI shall be subject to client approval, supported within SOWs and additional agreements.

**Principle 4 -- Procedural Integrity**: AI platform integrations shall have well-defined purposes and processes, subject to annual HITRUST review. AI platform selection shall include vetting for copyright and intellectual property compliance.

**Principle 5 -- Ethical Integrity**: No MERGE member shall knowingly use generative AI to produce derivative works infringing upon existing copyright-protected creations or to generate content that is deceptive, discriminatory, or harmful.

**Principle 6 -- Security and Privacy by Design**: AI systems developed, deployed, or procured by MERGE shall incorporate security and privacy considerations from the earliest stages of design, with threat mitigations, data protection controls, and compliance mechanisms integrated into architecture.

---

## 6. Compliance

### 6.1 Exception Handling

Exception requests to this policy shall be submitted to the Chief of Information Security with the following documentation:

1. Business justification for the exception
2. Description of the specific policy requirement(s) being waived
3. Risk analysis and compensating controls
4. Time-bound duration of the exception (not to exceed 1 year without re-approval)

**Exception scenarios**:

- **Emergency Situations**: If this policy conflicts with an active security incident, follow the Incident Response Plan. Document the exception post-incident within 5 business days.
- **Regulatory Conflict**: If this policy conflicts with a client-specific regulatory requirement, the Privacy Officer and Legal shall determine appropriate resolution with documented justification.
- **Executive Overrides**: Require documented approval from the CTO before deviating from this policy. Override, justification, and compensating controls shall be documented and retained for audit purposes.

All approved exceptions are logged and reviewed quarterly by the CISO.

---

## 7. Enforcement

Compliance with this policy is mandatory for all employees, contractors, and stakeholders. The Information Security team enforces this policy through:

- Regular audits and continuous monitoring via Vanta GRC and Google SecOps SIEM
- Quarterly access reviews for all AI systems
- Annual policy acknowledgment via employee handbook

Noncompliance may result in:

- Written warning and mandatory retraining
- Suspension of AI system access pending investigation
- Suspension or termination depending on severity and intent
- Legal consequences for violations involving applicable laws and regulations

---

## 8. Review & Change Management

### 8.1 Review Frequency

| Review Type | Frequency | Trigger |
| ----------- | --------- | ------- |
| Quarterly Review | Every 90 days | Minor updates, HITRUST threat-adaptive alignment |
| Annual Full Review | Annually | Full compliance review with TechOps leadership approval |
| Ad Hoc Update | As needed | Significant AI security incident, regulatory change, or material AI system change |

### 8.2 Approval Workflow

1. **Review by Policy Owner** -- CISO reviews policy for accuracy, completeness, and alignment with current AI threat landscape and organizational posture.
2. **Compliance & Security Validation** -- Legal review and compliance validation against HITRUST CSF v11.5 ai2, NIST AI RMF, and applicable regulatory requirements.
3. **Approval by TechOps Leadership** -- Final approval by TechOps leadership with documented sign-off.

**Current Review Status**: APPROVED -- Legal and Leadership approval completed 2026-02-22

**HITRUST ai2 Gap Closure**: Policy approved and submitted to A-LIGN for validation on 2026-02-22.

**HITRUST Phase 1 Evidence Checklist**:

- [x] Legal review completed -- date: 2026-02-22
- [x] Leadership approval obtained -- date: 2026-02-22
- [x] Submitted to A-LIGN for validation -- date: 2026-02-22
- [ ] Uploaded to Vanta as HITRUST evidence for control 09.ab
- [ ] Policy communicated to all affected personnel (in progress)
- [ ] Acknowledgment recorded in employee handbook / HR system
- [ ] Next review date set in Vanta: 2027-02-22

---

## 9. Related Procedures

**Supporting Procedures**:

| Procedure | Owner | Scope |
| --------- | ----- | ----- |
| PROC - AI Garage Operations | AI Garage | Model lifecycle, testing, deployment, bias assessment |
| PROC - DevSecOps AI Integration | DevSecOps | Secure SDLC, CI/CD security, environment controls |
| PROC - Google SecOps | SecOps | SIEM monitoring, AI system event detection |
| AI Systems Inventory | Information Security | Asset registration, risk classification, data flow mapping |
| AI Risk Assessment Procedure | Information Security | Quarterly cadence in Vanta, MITRE ATLAS / OWASP LLM scope |
| Change Management Procedure | Change Management Board | AI model change approval, pre-deployment testing |
| Incident Response Plan | SecOps | AI-specific detection, containment, rollback, post-incident analysis |

**Related Policies**:

- Information Security Policy
- Acceptable Use of Technology Policy
- Incident Response Policy
- Data Classification and Handling Policy
- Privacy Policy
- Third-Party and Vendor Risk Management Policy

---

## Revision History

| Version | Date | Author | Change Summary |
| ------- | ---- | ------ | -------------- |
| 1.0 | 2023-09-29 | TOIT Leadership, IP Leadership, InfoSec | Initial draft |
| 1.0 | 2023-12-12 | InfoSec | 2024 IT acknowledgment review; GRC platform language, formatting update |
| 1.5 | 2025-10-27 | Jason Dittmer, Kyle Smith, Kurt Miller | Adjustments for new AI services and systems |
| 2.0 | 2026-02-18 | Roze San Nicolas | HITRUST ai2 alignment, Vertex AI / Gemini scope, Vanta GRC integration, OWASP LLM / MITRE ATLAS coverage |
| 2.0 DRAFT | 2026-02-21 | Roze San Nicolas | HITRUST evidence formatting, explicit control mappings, approval block for Phase 1 submission |
| 2.0 | 2026-02-22 | Roze San Nicolas | Policy approved by Legal and Leadership, submitted to A-LIGN for validation |

---

## Approval

Approved by: _________________________________ Date: ___________

Title: ________________________________________

Approved by: _________________________________ Date: ___________

Title: ________________________________________

---

*This document is controlled and maintained by MERGE TechOps. Unauthorized alterations are prohibited.*
