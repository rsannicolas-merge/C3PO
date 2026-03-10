# POL-0012 Secure Software Development Lifecycle Policy

MERGE TechOps Policy

**Document Control**

| Field | Value |
|-------|-------|
| Document Number | POL-0012 |
| Version | 1.0 DRAFT |
| Status | DRAFT -- Pending Legal Review and Leadership Approval |
| Author | Roze San Nicolas, Chief of Information Security |
| Last Updated | 2026-02-23 |
| Next Review | 2027-02-23 (annual) |
| Document Type | Policy |
| Related Procedure | PROC-0001 Dependency Management Procedure |
| Based On | MERGE TechOps secure development requirements -- formatted for HITRUST evidence submission |

**HITRUST CSF v11.5 Control Mapping**:
10.a (Security Requirements Analysis and Specification), 10.b (Technical Vulnerability Management),
09.aa (Change Control Procedures), 09.ab.05 (AI Model Security), 01.a (Information Security Policy),
10.c (Control of Internal Processing), 10.d (Message Integrity), 10.e (Output Data Validation),
10.f (Technical Review of Applications After Operating Platform Changes),
10.h (Control of Operational Software), 10.i (Protection of System Test Data),
10.j (Access Control to Program Source Code), 10.k (Change Control Procedures),
06.g (Compliance with Security Policies and Standards), 02.e (Information Security Awareness, Education, and Training)

**NIST 800-53 Rev 5 Control Family Mapping**:
SA-3 (System Development Life Cycle), SA-8 (Security and Privacy Engineering Principles),
SA-10 (Developer Configuration Management), SA-11 (Developer Testing and Evaluation),
SA-15 (Development Process, Standards, and Tools), SA-17 (Developer Security and Privacy Architecture and Design),
CM-2 (Baseline Configuration), CM-3 (Configuration Change Control), CM-4 (Impact Analyses),
CM-6 (Configuration Settings), SI-2 (Flaw Remediation), SI-7 (Software, Firmware, and Information Integrity),
SI-10 (Information Input Validation), RA-3 (Risk Assessment), RA-5 (Vulnerability Monitoring and Scanning),
SR-3 (Supply Chain Controls and Processes), SR-4 (Provenance), AT-2 (Literacy Training and Awareness),
AT-3 (Role-Based Training)

---

## 1. Purpose

This policy establishes mandatory requirements for the secure development, testing, deployment, maintenance, and decommissioning of software systems at MERGE. It ensures that security controls are integrated into every phase of the software development lifecycle -- from requirements gathering through decommission -- rather than applied after the fact.

The Secure SDLC Policy directly supports MERGE's HITRUST r2 v11.5 and AI2 certification programs by providing auditable evidence that development practices meet prescriptive control specifications for security requirements analysis, configuration management, change control, system integrity, and vulnerability management. It applies to all software development activity regardless of methodology (Agile, Waterfall, hybrid) and regardless of deployment target (GCP production, staging, internal tools).

This policy addresses the following risks:

- Introduction of vulnerabilities through insecure coding practices, unreviewed changes, or inadequate testing
- Unauthorized or uncontrolled changes to production systems
- Compromise of source code integrity through inadequate access controls or supply chain attacks
- Deployment of software with known vulnerabilities due to missing security gates
- Regulatory noncompliance arising from undocumented or unverifiable development practices
- Supply chain compromise through unvetted third-party components or dependencies
- Loss of institutional knowledge and residual risk from improper system decommissioning

This policy shall be read in conjunction with POL-0011 (AI Governance, Security, and Acceptable Use Policy), which governs AI-specific development controls. Where AI systems are developed or modified, both policies apply concurrently. POL-0011 Section 4 assigns DevSecOps accountability for "Secure AI SDLC, CI/CD pipeline security, environment separation, API security controls" -- this policy provides the detailed requirements implementing that accountability.

**HITRUST Evidence Note**: Satisfies HITRUST CSF v11.5 requirement for a documented secure development lifecycle policy under control categories 10.a through 10.k and configuration management controls under 09.aa.

---

## 2. Scope

**Applies To**:

- All MERGE full-time employees, part-time employees, interns, and contract workers who develop, test, deploy, review, or maintain software systems
- All MERGE verticals and business units: AI Garage, DevSecOps, TechOps (SysOps / InfoSec / SecOps), and any vertical producing custom software or integrations
- Third-party vendors and contractors who develop software on behalf of MERGE or contribute code to MERGE-controlled repositories
- All software development activities including but not limited to: application development, infrastructure-as-code (Terraform), CI/CD pipeline configuration, API development, scripting, and AI model development

**Systems Involved**:

| System / Platform | Role in SDLC | Risk Tier |
| ----------------- | ------------ | --------- |
| GitHub (source control) | Code repositories, branch protection, code review, CI/CD triggers | High |
| Google Cloud Platform (GCP) | Production, staging, and development environments; deployment target | High |
| Google Vertex AI / Gemini | AI model development, training, and deployment | High |
| Terraform | Infrastructure-as-code provisioning and configuration management | High |
| Jira | Change management tracking, security requirement tracking, approval workflows | Medium |
| Vanta GRC | Compliance evidence collection, control verification, vulnerability tracking | Medium |
| CI/CD Pipelines (GitHub Actions or equivalent) | Automated build, test, scan, and deployment | High |
| Container registries and artifact repositories (GCP Artifact Registry) | Build artifact storage and integrity verification | High |
| Development workstations | Local development environments | Medium |

**Exclusions**:

- Personal learning projects on personal devices with no connection to MERGE systems, data, or repositories
- Third-party SaaS applications where MERGE has no access to or influence over source code (governed by Third-Party and Vendor Risk Management Policy)
- Sandboxed research and evaluation environments with no production data and no path to production deployment (governed by AI Garage evaluation procedures per POL-0011)

**HITRUST Evidence Note**: Defines scope boundary for HITRUST CSF v11.5 secure development controls, establishing which systems, personnel, and activities are subject to secure SDLC requirements. Cross-reference this scope with the HITRUST r2 system inventory to confirm all development-connected systems are captured.

---

## 3. Roles and Responsibilities

### 3.1 DevSecOps

CI/CD pipeline security configuration and maintenance; automated security scanning (SAST, SCA, DAST, IaC) implementation and tuning; security gate enforcement; developer security tooling support; security-focused code reviews for sensitive changes; SBOM generation and dependency monitoring; container and image security standards; secure coding standards maintenance.

### 3.2 AI Garage

AI model lifecycle management; AI-specific testing (adversarial robustness, output safety, data leakage); model versioning and provenance documentation; AI model card maintenance; AI data pipeline security; coordination with DevSecOps on AI deployment pipelines.

### 3.3 TechOps / SysOps

Environment separation enforcement (dev/staging/prod on GCP); infrastructure security configuration; Terraform state management and access controls; deployment pipeline infrastructure; production access controls; network segmentation between environments; monitoring and alerting configuration.

### 3.4 Engineering / Development Teams

Compliance with secure coding standards; participation in code reviews (both as author and reviewer); threat model contribution; security requirement implementation; timely remediation of security findings in owned code; completion of annual secure development training; secrets hygiene; documentation of security requirements in Jira.

QA / Testing: Validation that security requirements from the requirements phase are tested; execution of DAST scans on staging environments; documentation of security test results; regression testing after security patches.

### 3.5 Managers / Change Management Board

Review and approval of production change requests; risk assessment of proposed changes; emergency change procedure oversight; post-implementation review coordination; approval of significant decommission plans.

### 3.6 Security Officer (CISO / Information Security)

Policy ownership and maintenance; security review oversight and final sign-off on high-risk deployments; HITRUST evidence coordination; exception approval; training program oversight; escalation point for unresolved security findings; decommission approval for production systems.

**HITRUST Evidence Note**: Documented role definitions with explicit security accountabilities satisfy HITRUST CSF v11.5 requirements for secure development roles and responsibilities under controls 10.a and 09.aa.

---

## 4. Definitions

| Term | Definition |
|------|-----------|
| SAST | **Static Application Security Testing** -- Automated analysis of source code or compiled code to identify security vulnerabilities without executing the program. |
| SCA | **Software Composition Analysis** -- Automated scanning of third-party and open source dependencies to identify known vulnerabilities (CVEs) and license risks. |
| DAST | **Dynamic Application Security Testing** -- Automated security testing of running applications by simulating attacks against deployed endpoints to identify runtime vulnerabilities. |
| SDLC | **Software Development Lifecycle** -- The end-to-end process encompassing requirements, design, implementation, testing, deployment, maintenance, and decommissioning of software systems. |
| IaC | **Infrastructure as Code** -- The practice of managing and provisioning computing infrastructure through machine-readable configuration files (e.g., Terraform) rather than manual processes. |
| SBOM | **Software Bill of Materials** -- A comprehensive inventory of all direct and transitive software components, libraries, and dependencies used in an application, including version and vulnerability status. |
| Branch Protection | Configuration rules applied to source control branches (e.g., main, release) that enforce review, testing, and approval requirements before code can be merged. |
| Threat Modeling | A structured methodology for identifying, classifying, and prioritizing potential security threats to a system during the design phase, before implementation begins. |
| STRIDE | **Spoofing, Tampering, Repudiation, Information Disclosure, Denial of Service, Elevation of Privilege** -- A threat classification methodology used during threat modeling to categorize potential attack vectors. |
| CI/CD | **Continuous Integration / Continuous Delivery (or Deployment)** -- Automated pipelines that build, test, scan, and deploy code changes through defined stages with quality and security gates. |
| Secure by Default | A design principle requiring that software ships in its most restrictive configuration, with debug modes, verbose logging of sensitive data, administrative interfaces, and test accounts disabled or removed before deployment. |
| Defense in Depth | A security strategy that layers multiple independent controls so that no single point of failure can compromise the system. Applications do not rely solely on perimeter controls or a single validation mechanism. |
| Fail Secure | A design principle requiring that when errors or exceptions occur, software defaults to a secure state -- authentication and authorization failures result in denial of access, not degraded access. |
| Separation of Duties | A control principle ensuring no single individual can develop code, approve that code for production, and deploy it to production without independent review and approval at each stage. |

---

## 5. Policy Overview

The following statements establish mandatory, auditable requirements for secure software development at MERGE. All development activity shall comply with these requirements regardless of project size, methodology, or timeline pressure.

### 5.1 SDLC Phase Requirements and Security Integration

Security shall be integrated into every phase of the software development lifecycle. No phase shall be considered complete without satisfying its security requirements.

1. **Requirements Phase**: Security requirements shall be identified and documented alongside functional requirements for every project, feature, or significant change. Security requirements shall address, at minimum: authentication, authorization, input validation, output encoding, encryption (in transit and at rest), logging, error handling, session management, and data classification. Security requirements shall be captured as explicit acceptance criteria in Jira tickets or equivalent tracking systems.
2. **Design Phase**: Security architecture shall be defined during the design phase, including threat modeling, data flow documentation, trust boundary identification, and control selection. Design decisions with security implications shall be reviewed by Information Security or DevSecOps before implementation begins (see Section 5.2).
3. **Implementation Phase**: Code shall be written in accordance with MERGE secure coding standards, with security controls implemented as designed. Developers shall follow the secure coding requirements in Section 5.3 throughout implementation.
4. **Testing Phase**: Security testing shall be conducted alongside functional testing, with defined gates that must pass before code progresses (see Section 5.4). Testing shall validate that security requirements from the requirements phase are satisfied.
5. **Deployment Phase**: Deployments shall follow controlled, auditable change management processes with environment separation, mandatory approval, and rollback capability (see Section 5.5).
6. **Maintenance Phase**: Deployed software shall be continuously monitored for vulnerabilities, dependency health, and compliance drift. Security patches shall be applied within defined SLAs. Documentation shall be kept current with each change.
7. **Decommissioning Phase**: Software and systems being retired shall follow the decommissioning requirements in Section 5.12 to ensure data is properly handled, access is revoked, and residual risk is addressed.

*HITRUST Mapping*: 10.a, 10.h | *NIST 800-53*: SA-3, SA-8, SA-17

### 5.2 Security Requirements in Design

Security requirements shall be defined, documented, and reviewed during the design phase of every project, feature, or significant change.

1. **Threat Modeling**: Threat modeling shall be conducted for all new systems, significant architectural changes, and new external-facing features before development begins. Threat models shall identify assets, threat actors, attack surfaces, and potential attack vectors. The STRIDE methodology (Spoofing, Tampering, Repudiation, Information Disclosure, Denial of Service, Elevation of Privilege) or an equivalent structured methodology shall be used. Completed threat models shall be stored in the project repository or Jira and linked to the relevant change request.
2. **Architecture Security Review**: New systems and significant architectural changes shall undergo an architecture security review conducted by Information Security or DevSecOps prior to development. The review shall evaluate alignment with MERGE security standards, identify inherited risks, and confirm that security controls are designed into the architecture rather than bolted on. Architecture reviews shall be documented in Jira and retained as audit evidence.
3. **Data Flow Documentation**: Systems that process, store, or transmit sensitive data (PII, PHI, client confidential data, credentials, or encryption keys) shall have documented data flow diagrams identifying all ingress, egress, processing, and storage points. Data flows shall be reviewed and updated with each significant change.
4. **Security Design Principles**: All software shall be designed in accordance with the following principles:
   - **Least Privilege**: Software shall operate with the minimum permissions necessary. Service accounts, API tokens, and application roles shall request only the access required. Default configurations shall deny access unless explicitly granted.
   - **Defense in Depth**: Security controls shall be layered so that no single point of failure can compromise the system. Applications shall not rely solely on perimeter controls or a single validation mechanism.
   - **Secure by Default**: Software shall ship in its most restrictive configuration. Debug modes, verbose logging of sensitive data, administrative interfaces, and test accounts shall be disabled or removed before deployment to any non-development environment.
   - **Fail Secure**: When errors or exceptions occur, software shall default to a secure state. Authentication and authorization failures shall result in denial of access, not degraded access.
   - **Separation of Duties**: No single individual shall have the ability to develop code, approve that code for production, and deploy it to production without independent review and approval at each stage.
   - **Assume Breach**: Software shall be designed with the assumption that the network, endpoints, and adjacent systems may be compromised. All inputs from external systems shall be treated as untrusted.

**HITRUST Evidence Note**: Threat models and architecture security reviews serve as evidence for HITRUST CSF v11.5 control 10.a (Security Requirements Analysis and Specification). Retain completed threat models and review records in Vanta.

*HITRUST Mapping*: 10.a | *NIST 800-53*: SA-3, SA-8, SA-17, RA-3

### 5.3 Secure Coding Standards

All developers shall follow secure coding standards during implementation to prevent the introduction of common vulnerability classes.

1. **Coding Standards Adoption**: MERGE shall maintain or adopt documented secure coding standards appropriate to each language and framework in use. At minimum, standards shall address the OWASP Top 10 Web Application Security Risks, the OWASP Top 10 for LLMs (for AI development), and the CWE/SANS Top 25 Most Dangerous Software Weaknesses.
2. **Input Validation**: All input from external sources (user input, API requests, file uploads, inter-service messages, webhook payloads) shall be validated on the server side against expected type, length, range, and format. Client-side validation is not a substitute for server-side validation.
3. **Output Encoding**: All output rendered in user-facing contexts shall be properly encoded to prevent injection attacks (XSS, SQL injection, command injection, LDAP injection). Parameterized queries or prepared statements shall be used for all database interactions. Template engines with automatic escaping shall be preferred.
4. **Secrets Management**: Secrets (API keys, database credentials, encryption keys, service account tokens) shall never be committed to source code repositories, stored in plaintext configuration files, or logged. Secrets shall be managed through GCP Secret Manager or an equivalent approved secrets management solution. Secrets detected in code repositories shall trigger an immediate rotation and remediation.
5. **Cryptography**: Applications shall use approved cryptographic libraries and algorithms. Custom cryptographic implementations are prohibited. TLS 1.2 or higher shall be required for all data in transit. AES-256 or equivalent shall be used for data at rest. Cryptographic key management shall follow MERGE encryption standards.
6. **Error Handling and Logging**: Error handling shall capture sufficient detail for debugging and incident response without exposing sensitive information to end users. Error messages shall not expose stack traces, database queries, internal paths, or other information useful to an attacker. Application logs shall include authentication events, authorization failures, input validation failures, and application errors. Logs shall be forwarded to Google SecOps SIEM per MERGE log retention requirements.
7. **Session Management**: Applications handling user sessions shall enforce secure session management including: cryptographically random session identifiers, session timeout and idle timeout, session invalidation on logout and password change, and protection against session fixation and session hijacking.

*HITRUST Mapping*: 10.b, 10.c, 10.d, 10.e | *NIST 800-53*: SA-11, SI-7, SI-10

### 5.4 Security Testing Requirements

Security testing shall be integrated into the development and deployment pipeline with defined gates that must pass before code progresses to the next stage.

1. **Static Application Security Testing (SAST)**: Automated SAST scans shall be executed on every pull request and prior to merge into protected branches. SAST findings rated Critical or High shall block the merge until remediated or documented with an approved exception. SAST tooling shall be configured to detect, at minimum: injection flaws, authentication weaknesses, cryptographic failures, sensitive data exposure, and insecure deserialization.
2. **Software Composition Analysis (SCA)**: Automated SCA scans shall be executed on every build to identify known vulnerabilities in third-party dependencies and open source components. Dependencies with known Critical or High CVEs shall not be deployed to production without documented remediation, compensating controls, or an approved exception with a time-bound remediation plan. SCA scanning is further detailed in PROC-0001 (Dependency Management Procedure).
3. **Dynamic Application Security Testing (DAST)**: DAST scans shall be conducted on staging environments prior to production deployment for all externally accessible applications and APIs. DAST shall be performed at least quarterly for production applications and upon significant changes.
4. **Infrastructure-as-Code Scanning**: All Terraform configurations and other IaC templates shall be scanned for security misconfigurations, compliance violations, and secrets prior to deployment. Scans shall check for overly permissive IAM policies, public exposure of resources, encryption gaps, and logging omissions. IaC scanning requirements are further detailed in STD-0003 (IaC Security Standard).
5. **Container and Image Scanning**: Container images shall be scanned for known vulnerabilities and compliance with MERGE base image standards prior to deployment. Images with Critical vulnerabilities shall not be deployed to production. Container security requirements are further detailed in STD-0002 (Container Security Standard).
6. **Penetration Testing**: External penetration testing shall be conducted at least annually and upon significant architectural changes. Internal penetration testing or red team exercises shall be conducted as resources permit. All findings shall be documented in Vanta and tracked to remediation.
7. **Remediation SLAs**: Security findings shall be remediated within the following timelines from discovery:

| Severity | Remediation SLA | Escalation |
| -------- | --------------- | ---------- |
| Critical | 72 hours | Immediate escalation to CISO |
| High | 14 calendar days | Escalation to Engineering Lead and CISO if overdue |
| Medium | 30 calendar days | Tracked in Jira, reviewed at sprint boundary |
| Low | 90 calendar days | Tracked in Jira, reviewed quarterly |

**HITRUST Evidence Note**: SAST, SCA, DAST, and IaC scan results and remediation records serve as evidence for HITRUST CSF v11.5 controls 10.a, 10.b, 06.g, and NIST RA-5 (Vulnerability Monitoring and Scanning). Remediation SLA adherence is tracked in Vanta.

*HITRUST Mapping*: 10.a, 10.b, 06.g | *NIST 800-53*: SA-11, RA-5, SI-2, SI-7

### 5.5 Deployment and Change Management

All deployments to production environments shall follow a controlled, auditable process ensuring that only reviewed, tested, and approved changes are released.

1. **Change Management Approval**: All changes to production systems shall be documented in Jira with a change request that includes: description of the change, business justification, risk assessment, rollback plan, and testing evidence. Changes shall be approved by the Change Management Board or designated approver prior to deployment. Emergency changes shall follow the emergency change procedure and be documented retrospectively within 24 hours.
2. **Mandatory Security Review Before Production**: No code shall be deployed to production without passing all applicable security testing gates defined in Section 5.4. The DevSecOps team or Information Security shall sign off on the security posture of the release before production deployment for changes classified as High or Critical risk. Security sign-off shall be recorded in the Jira change request.
3. **Environment Separation**: MERGE shall maintain logically separated environments for development, staging (pre-production), and production on GCP. The following separation requirements shall be enforced:
   - Development environments shall not have access to production data unless explicitly authorized, documented, and protected with equivalent controls.
   - Staging environments shall mirror production configuration to ensure accurate testing.
   - Deployments shall progress sequentially: development, staging, production. Direct deployment from development to production is prohibited except under documented emergency change procedures.
   - Each environment shall reside in a separate GCP project with independent IAM bindings, network controls, and audit logging.
   - Production credentials, secrets, and API keys shall not be accessible from development or staging environments.
4. **Deployment Automation**: Deployments to staging and production shall be executed through automated CI/CD pipelines, not through manual processes. Pipeline configurations shall be version-controlled, reviewed, and subject to the same change management requirements as application code. Manual deployments are permitted only under documented emergency change procedures with retrospective documentation. CI/CD pipeline security is further detailed in STD-0001 (CI/CD Pipeline Security Standard).
5. **Rollback Capability**: Every production deployment shall have a documented and tested rollback plan. Deployment pipelines shall support automated rollback to the previous known-good state. Rollback shall be executable within 30 minutes of identifying a deployment issue.
6. **Post-Deployment Verification**: After every production deployment, automated or manual verification shall confirm that the application is functioning correctly, security controls are operational, and no regressions have been introduced. Post-deployment verification results shall be recorded in the Jira change request.

**HITRUST Evidence Note**: Jira change requests with approval records, security sign-off, and deployment evidence satisfy HITRUST CSF v11.5 control 09.aa (Change Control) and 10.k (Change Control Procedures). Environment separation documentation satisfies 10.h (Control of Operational Software).

*HITRUST Mapping*: 09.aa, 10.h, 10.k | *NIST 800-53*: CM-3, CM-4, SA-10, SA-15

### 5.6 Code Review Requirements

All code changes shall be reviewed by qualified personnel before being merged into protected branches or deployed to non-development environments.

1. **Minimum Reviewers**: Every pull request shall require approval from at least one reviewer who did not author the change. For changes affecting authentication, authorization, cryptography, data handling, or infrastructure security configurations, a second reviewer with security expertise (from DevSecOps or Information Security) shall be required.
2. **Security-Focused Review Criteria**: Code reviewers shall evaluate changes against the following security criteria, at minimum: input validation, output encoding, authentication and session handling, authorization checks, error handling and logging, secrets exposure, SQL and command injection, cross-site scripting, insecure deserialization, and compliance with MERGE secure coding standards.
3. **Review Timeliness**: Code reviews shall be completed within 2 business days of submission. Security-focused reviews for sensitive changes shall be completed within 3 business days. Reviews exceeding these timelines shall be escalated to the Engineering Lead.
4. **Review Documentation**: All code review comments, approvals, and requested changes shall be documented within GitHub pull request records. These records serve as audit evidence and shall be retained per MERGE record retention requirements.

**HITRUST Evidence Note**: GitHub pull request approval records with reviewer attestation serve as evidence for HITRUST CSF v11.5 controls 10.j (Access Control to Program Source Code) and 10.k (Change Control Procedures).

*HITRUST Mapping*: 10.j, 10.k | *NIST 800-53*: SA-10, SA-11, CM-3

### 5.7 Branch Protection and Source Control Hygiene

Source code repositories shall be configured with protections that enforce the integrity of the development and release process.

1. **Branch Protection Rules**: The following protections shall be enforced on all main (production) and release branches in GitHub:
   - Pull request required before merging (no direct commits)
   - Minimum one approving review required (two for security-sensitive repositories)
   - Status checks (CI/CD pipeline, SAST, SCA) must pass before merge
   - Branch protection rules cannot be bypassed by administrators without documented justification
   - Force pushes and branch deletion are prohibited on protected branches
   - Stale approvals shall be dismissed when new commits are pushed
2. **Repository Access Controls**: Repository access shall follow the principle of least privilege. Write access shall be granted only to active contributors with documented business justification. Organization-level repository visibility defaults shall be set to private. External collaborator access shall require approval from the repository owner and Information Security.
3. **Commit Signing**: Commits to protected branches shall be signed using GPG or SSH keys to verify author identity and prevent commit spoofing. Unsigned commits shall be rejected on protected branches.
4. **Repository Hygiene**: Inactive repositories (no commits in 180 days) shall be archived or decommissioned. Repository access shall be reviewed quarterly as part of the access review cycle. Secrets scanning shall be enabled on all repositories to detect accidental credential commits.

*HITRUST Mapping*: 10.j, 10.k | *NIST 800-53*: SA-10, CM-2, CM-6

### 5.8 Security Training for Developers

All personnel who develop, test, or review code shall receive security training to maintain awareness of current threats and secure development practices.

1. **Annual Secure Development Training**: All developers, QA engineers, and DevSecOps personnel shall complete annual secure development training covering, at minimum: OWASP Top 10, secure coding practices for their primary language(s), secrets management, and MERGE-specific security policies and procedures. Training completion shall be tracked in the HR learning management system and reported to Information Security.
2. **Onboarding Training**: New developers and contractors shall complete secure development training within 30 days of onboarding and before being granted write access to production-path repositories.
3. **Role-Specific Training**: Personnel in roles with elevated security responsibilities (DevSecOps, infrastructure engineers, AI model developers) shall receive additional role-specific security training annually, including topics such as threat modeling, security architecture review, IaC security, and AI-specific threats (OWASP Top 10 for LLMs, MITRE ATLAS).
4. **Lessons-Learned Integration**: After security incidents or significant vulnerability discoveries, relevant lessons-learned shall be incorporated into team briefings or training materials within 30 days.

**HITRUST Evidence Note**: Training completion records and curricula satisfy HITRUST CSF v11.5 control 02.e (Information Security Awareness, Education, and Training) as it relates to secure development personnel.

*HITRUST Mapping*: 02.e, 10.a | *NIST 800-53*: AT-2, AT-3, SA-11, SA-16

### 5.9 Third-Party Code and Open Source Governance

Third-party libraries, open source components, and externally sourced code shall be governed to prevent the introduction of vulnerabilities, license risks, and supply chain compromise.

1. **Approved Package Sources**: Dependencies shall be sourced only from approved, trusted registries (e.g., official npm, PyPI, Maven Central, or MERGE-managed mirrors in GCP Artifact Registry). Packages from unverified sources, direct URL imports, or forked repositories without a documented security review shall not be used in production-path code.
2. **Dependency Inventory**: A software bill of materials (SBOM) shall be maintained for all production applications, listing all direct and transitive dependencies, their versions, and known vulnerability status. SBOMs shall be generated automatically as part of the CI/CD pipeline and stored as build artifacts. SBOM generation requirements are further detailed in PROC-0001 (Dependency Management Procedure).
3. **License Compliance**: All open source components shall be reviewed for license compatibility before adoption. Copyleft licenses (GPL, AGPL) shall require Legal review before inclusion in any MERGE product or service. A list of pre-approved license types shall be maintained by DevSecOps.
4. **Vulnerability Monitoring**: Dependencies shall be continuously monitored for newly disclosed vulnerabilities through automated SCA tooling integrated into the CI/CD pipeline. When a Critical or High vulnerability is disclosed in a dependency used in production, remediation (upgrade, patch, or removal) shall begin within the timelines defined in Section 5.4.7.
5. **Dependency Pinning and Integrity**: Dependencies shall be pinned to specific versions in lock files. Integrity verification (hash checking) shall be enforced where supported by the package manager. Automatic major version upgrades in production pipelines are prohibited; all dependency updates shall go through the standard pull request and review process.
6. **Vendor-Supplied Software**: Commercial or vendor-supplied software integrated into MERGE systems shall be evaluated for security posture prior to adoption, including review of the vendor's security certifications, vulnerability disclosure practices, and patch cadence. Vendor software shall be tracked in the TechOps Systems Inventory.

**HITRUST Evidence Note**: SBOM records, SCA scan results, and dependency review documentation satisfy HITRUST CSF v11.5 supply chain controls and NIST SR-3 (Supply Chain Controls and Processes). License compliance records support organizational due diligence requirements.

*HITRUST Mapping*: 10.a, 10.h | *NIST 800-53*: SR-3, SR-4, SA-10, SI-2, SI-7

### 5.10 AI-Specific Development Controls

Software development involving AI models, machine learning pipelines, and AI-integrated applications shall comply with all requirements in this policy and the following additional controls. These requirements supplement POL-0011 (AI Governance, Security, and Acceptable Use Policy).

1. **AI Model Change Management**: All changes to production AI models -- including retraining, fine-tuning, prompt template changes, guardrail updates, and inference configuration changes -- shall be documented in Jira and approved through change management prior to production deployment. Model changes shall include documented testing results demonstrating that the change does not degrade security posture, safety guardrails, or output quality.
2. **AI-Specific Testing**: AI systems shall undergo testing for adversarial robustness (prompt injection, jailbreaking, evasion attacks), output safety (harmful content generation, bias), and data leakage (training data extraction, PII exposure) prior to production deployment and after significant changes.
3. **AI Model Versioning and Provenance**: AI models shall be version-controlled with documented provenance including training data sources, hyperparameters, training methodology, and evaluation results. Model artifacts shall be stored in access-controlled, integrity-verified registries in GCP Artifact Registry.
4. **AI Data Pipeline Security**: Data pipelines supporting AI model training and inference shall implement input validation, data integrity checks, and access controls equivalent to those required for application code. Data poisoning risks shall be addressed through provenance tracking and anomaly detection on training data.
5. **AI Model Cards**: Each production AI model shall have a documented model card describing: model purpose, owner, risk classification, training data sources, known limitations, bias evaluation results, and security controls applied. Model cards shall be maintained in the TechOps Systems Inventory per POL-0011 Section 3.1.

*HITRUST Mapping*: 09.ab.05, 09.aa | *NIST 800-53*: SA-3, SA-11, CM-3

### 5.11 Documentation Requirements Per Phase

Each SDLC phase shall produce documentation artifacts that are retained for audit, compliance, and operational continuity purposes.

1. **Requirements Phase Documentation**: Security requirements shall be documented in Jira as acceptance criteria. Data classification for the system or feature shall be recorded. Regulatory and compliance requirements (HITRUST, NIST, FedRAMP) applicable to the work shall be identified and documented.
2. **Design Phase Documentation**: Threat models, architecture security review reports, and data flow diagrams shall be produced, stored in the project repository or Jira, and linked to the relevant work items.
3. **Implementation Phase Documentation**: Inline code documentation for security-relevant logic. Secure coding standard deviations documented as exceptions per Section 6.
4. **Testing Phase Documentation**: Security testing results (SAST, SCA, DAST, penetration test reports) shall be retained in Vanta. Test evidence shall be linked to the corresponding Jira change request.
5. **Deployment Phase Documentation**: Change management records in Jira including: change request, approval, deployment evidence, rollback plan, and post-deployment verification results. CI/CD pipeline run logs shall be retained per STD-0001.
6. **Maintenance Phase Documentation**: Vulnerability scan results, dependency health reviews, SLA compliance reports, and patch records shall be maintained in Vanta.
7. **Decommissioning Phase Documentation**: Decommission plans, data disposition records, access revocation confirmations, and DNS/endpoint shutdown verification shall be retained per Section 5.12.

**HITRUST Evidence Note**: Phase-specific documentation artifacts constitute the primary evidence trail for HITRUST r2 assessment fieldwork. Assessors will request evidence per phase for sampled systems. Retain all artifacts in Vanta with consistent tagging by system, phase, and HITRUST control mapping.

*HITRUST Mapping*: 10.a, 10.h, 10.i, 06.g | *NIST 800-53*: SA-3, SA-8, SA-15

### 5.12 System and Software Decommissioning

Software systems, applications, and services being retired from production shall follow a controlled decommissioning process to mitigate residual security risk.

1. **Decommission Plan**: A documented decommission plan shall be created for every system being retired, including: data disposition (archive, deletion, or migration), access revocation schedule, dependency impact analysis (other systems or services that rely on the decommissioned system), DNS and endpoint shutdown, and timeline.
2. **Data Handling**: All data associated with the decommissioned system shall be handled per MERGE's Data Classification and Handling Policy. PII, PHI, and client confidential data shall be securely deleted or migrated with documented verification. Encryption keys associated solely with the decommissioned system shall be revoked and destroyed after confirming data disposition is complete.
3. **Access Revocation**: All access to the decommissioned system -- user accounts, service accounts, API keys, IAM bindings, network rules -- shall be revoked prior to or concurrent with system shutdown. Access revocation shall be verified and documented.
4. **Source Code and Artifact Retention**: Source code repositories for decommissioned systems shall be archived (not deleted) in GitHub. Build artifacts and deployment records shall be retained per MERGE record retention requirements. SBOMs for the last production release shall be retained.
5. **Infrastructure Cleanup**: GCP resources (compute instances, storage buckets, databases, Cloud Run services, Terraform state) associated with the decommissioned system shall be destroyed after data disposition is confirmed. Terraform configurations shall be updated to remove the resources and the changes applied through the standard pipeline.
6. **Inventory Update**: The TechOps Systems Inventory and Vanta shall be updated to reflect the system's decommissioned status, including decommission date and responsible party.

*HITRUST Mapping*: 10.h | *NIST 800-53*: SA-3, CM-3

---

## 6. Compliance

### 6.1 Exception Handling

Exception requests to this policy shall be submitted to the Chief of Information Security with the following documentation:

1. **Business justification** explaining why the policy requirement cannot be met
2. **Specific policy requirement(s)** being waived, referenced by section number
3. **Risk analysis** identifying the security risk introduced by the exception and any compensating controls that will be implemented
4. **Time-bound duration** of the exception, not to exceed 1 year without re-approval
5. **Approval chain**: Exceptions shall be approved by the CISO. Exceptions affecting HITRUST-scoped systems shall also be reviewed by the GRC team for impact on certification posture.

**Exception Scenarios**:

- **Emergency Deployments**: If a production incident requires bypassing security testing gates, the emergency change procedure shall be followed. The deployment shall be documented retrospectively within 24 hours, and the bypassed security testing shall be completed within 5 business days post-deployment. If testing reveals vulnerabilities, they shall be remediated per Section 5.4.7 timelines or the change shall be rolled back.
- **Legacy System Constraints**: Systems that cannot technically support required controls (e.g., legacy applications without CI/CD integration) shall document compensating controls and a remediation roadmap. Legacy exceptions shall be reviewed quarterly.
- **Proof of Concept / Prototype**: Development activity explicitly designated as proof-of-concept with no path to production may operate under relaxed controls with documented CISO approval. Any POC that transitions toward production shall comply fully with this policy before entering the staging environment.
- **Regulatory Conflict**: If this policy conflicts with a client-specific regulatory requirement, the Privacy Officer and Legal shall determine appropriate resolution with documented justification.

All approved exceptions are logged in Vanta, linked to the relevant system and control, and reviewed quarterly by the CISO.

---

## 7. Enforcement

Compliance with this policy is mandatory for all employees, contractors, and third parties who develop, test, deploy, or maintain software for MERGE. The Information Security team and DevSecOps enforce this policy through:

- Automated enforcement via CI/CD pipeline security gates (SAST, SCA, IaC scanning, branch protection rules)
- Regular audits of repository configurations, pipeline settings, and deployment records
- Quarterly access reviews of source control repositories and deployment systems
- Continuous monitoring via Vanta GRC for control compliance and evidence currency
- Annual policy acknowledgment via employee handbook

Noncompliance may result in:

- Written warning and mandatory retraining on secure development practices
- Revocation of repository write access or deployment privileges pending investigation
- Suspension or termination of employment or contract depending on severity and intent
- Legal consequences for violations involving applicable laws, regulations, or contractual obligations

Automated enforcement (pipeline gates, branch protection) shall be the primary mechanism. Policy compliance shall not depend solely on individual behavior where technical controls can enforce requirements.

---

## 8. Review & Change Management

### 8.1 Review Frequency

| Review Type | Frequency | Trigger |
| ----------- | --------- | ------- |
| Quarterly Review | Every 90 days | Minor updates, new tooling adoption, lessons learned from incidents |
| Annual Full Review | Annually | Full compliance review with TechOps leadership approval |
| Ad Hoc Update | As needed | Significant security incident involving development practices, regulatory change, new platform adoption, HITRUST assessment findings |

### 8.2 Approval Workflow

**Current Review Status**: DRAFT -- Pending Legal Review and Leadership Approval

**Approval Requirement for HITRUST r2 Evidence**: This policy must be approved by Legal and TechOps Leadership before the HITRUST r2 v11.5 incubation period (May 2026) to satisfy evidence requirements for controls 10.a-10.k and 09.aa. Upload the approved version to Vanta upon approval.

**HITRUST Phase 1 Evidence Checklist** (complete before Vanta upload):

- [ ] Legal review completed -- date: __________
- [ ] Leadership approval obtained -- date: __________
- [ ] Uploaded to Vanta as HITRUST evidence for controls 10.a-10.k, 09.aa
- [ ] Policy communicated to all development personnel
- [ ] Acknowledgment recorded in employee handbook / HR system
- [ ] Supporting procedures development prioritized and scheduled
- [ ] Cross-reference verified with POL-0011 (AI Governance) for consistency
- [ ] Next review date set in Vanta: 2027-02-23

---

## 9. Related Procedures

Supporting standards and procedures implement the requirements of this policy. Each shall be maintained by its designated owner and reviewed at least annually.

| Standard / Procedure | Document Number | Owner | Scope | Status |
| -------------------- | --------------- | ----- | ----- | ------ |
| CI/CD Pipeline Security Standard | STD-0001 | DevSecOps | Pipeline configuration, security gate definitions, scanning tool configuration, deployment controls, artifact integrity, secrets management | DRAFT |
| Dependency Management Procedure | PROC-0001 | DevSecOps | Package source approval, SBOM generation, vulnerability response, license review, supply chain risk controls, EOL management | DRAFT |
| Container Security Standard | STD-0002 | DevSecOps | Base image standards, image scanning, runtime security, registry access controls | To be developed |
| IaC Security Standard | STD-0003 | DevSecOps / TechOps | Terraform security patterns, IaC scanning configuration, state file protection, module governance | To be developed |
| Secure Coding Standards (per language) | TBD | DevSecOps | Language-specific secure coding guidelines addressing OWASP Top 10, CWE Top 25 | To be developed |
| Threat Modeling Procedure | TBD | Information Security | Methodology, templates, review cadence, documentation requirements | To be developed |
| Change Management Procedure | TBD | Change Management Board | Change request workflow, approval criteria, emergency change process, post-implementation review | To be developed |
| Environment Separation Standard | TBD | TechOps / SysOps | GCP project structure, network controls, data isolation, access boundaries | To be developed |
| Security Testing Procedure | TBD | DevSecOps | SAST/SCA/DAST tool configuration, finding triage, false positive management, remediation tracking | To be developed |

**Related Policies**:

- POL-0011: AI Governance, Security, and Acceptable Use Policy
- Information Security Policy
- Incident Response Policy
- Configuration Management Policy
- Access Control Policy
- Third-Party and Vendor Risk Management Policy
- Data Classification and Handling Policy

**HITRUST Evidence Note**: The existence of this standards and procedures table, with designated owners and defined scope, satisfies HITRUST CSF v11.5 requirement for documented supporting procedures under secure development controls. Procedures marked "To be developed" represent known gaps tracked in the HITRUST remediation plan and the policy library index.

---

## Revision History

| Version | Date | Author | Change Summary |
| ------- | ---- | ------ | -------------- |
| 1.0 DRAFT | 2026-02-23 | Roze San Nicolas | Initial draft; HITRUST r2 v11.5 alignment; NIST 800-53 Rev 5 mapping; comprehensive secure SDLC requirements for GCP/GitHub/Terraform/Vertex AI environment; full lifecycle coverage including decommissioning |

---

## Approval

Approved by: _________________________________ Date: ___________

Title: ________________________________________

Approved by: _________________________________ Date: ___________

Title: ________________________________________

---

*This document is controlled and maintained by MERGE TechOps / Information Security. Unauthorized alterations are prohibited.*
