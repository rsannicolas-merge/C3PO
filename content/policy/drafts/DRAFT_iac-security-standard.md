# STD-0003 Infrastructure as Code Security Standard

MERGE TechOps Standard

**Document Control**

| Field | Value |
|-------|-------|
| Document Number | STD-0003 |
| Version | 1.0 DRAFT |
| Status | DRAFT -- Pending Legal Review and Leadership Approval |
| Author | Roze San Nicolas |
| Owner | Roze San Nicolas, Chief of Information Security |
| Last Updated | 2026-02-23 |
| Next Review | 2027-02-23 (annual) |
| Document Type | Standard |
| Related Policy | POL-0012 Secure Software Development Lifecycle Policy |
| Related Procedure | [None yet] |
| HITRUST CSF v11.5 Control Mapping | 09.aa (Change Control Procedures), 01.i (Policy on Use of Network Services), 09.d (Protection Against External and Environmental Threats), 09.m (Network Controls), 09.ab (Configuration Management), 01.c (Allocation of Information Security Responsibilities), 09.ac (Protection of System Test Data) |
| NIST 800-53 Rev 5 Control Family Mapping | CM-2 (Baseline Configuration), CM-3 (Configuration Change Control), CM-6 (Configuration Settings), AC-6 (Least Privilege), SA-10 (Developer Configuration Management), SA-11 (Developer Testing and Evaluation), SC-7 (Boundary Protection), SC-28 (Protection of Information at Rest), AU-6 (Audit Record Review) |

---

## 1. Purpose

This standard establishes mandatory security requirements for the development, review, deployment, and management of Infrastructure as Code (IaC) at MERGE. It exists to ensure that all cloud infrastructure provisioned through Terraform or other approved IaC tools meets MERGE's security baselines, regulatory obligations, and compliance posture -- including HITRUST CSF v11.5 r2 and NIST 800-53 Rev 5 requirements.

MERGE operates its production infrastructure on Google Cloud Platform (GCP) and has standardized Terraform as the primary IaC tool across all environments. This standard addresses the risk that uncontrolled, unreviewed, or insecure infrastructure changes may introduce misconfigurations, unauthorized access, data exposure, or compliance failures into MERGE's cloud environment.

Manual infrastructure changes bypass the review, audit, and scanning controls that IaC pipelines enforce. This standard eliminates that gap by requiring all production infrastructure to be defined, reviewed, and deployed through code. It provides the prescriptive technical controls that HITRUST assessors and federal auditors expect to see documented, implemented, and evidenced for configuration management, change control, and infrastructure security.

**HITRUST Evidence Note**: This standard satisfies HITRUST CSF v11.5 requirements for documented configuration management procedures (09.aa), network service usage controls (01.i), and protection against external threats through infrastructure hardening (09.d). It provides auditable evidence of MERGE's infrastructure change control program. Retain the approved version of this document in Vanta as evidence for all mapped HITRUST control specifications.

---

## 2. Scope

### Applies To

- All infrastructure provisioned, modified, or decommissioned on Google Cloud Platform (GCP)
- All Terraform code, modules, state files, variable definitions, and associated pipeline configurations
- All GCP projects across development, staging, and production environments
- All personnel who create, review, approve, or deploy infrastructure changes -- including employees, contractors, and managed service providers
- Any future IaC tools adopted by MERGE (e.g., Pulumi) subject to CISO approval, which shall comply with the equivalent security requirements defined herein

### Systems Involved

| System / Platform | Role | Environment |
| ----------------- | ---- | ----------- |
| Google Cloud Platform (GCP) | Primary cloud infrastructure | All (dev, staging, prod) |
| Terraform | Primary IaC provisioning tool | All |
| GitHub | Source control for IaC repositories | All |
| Jira | Change management and ticketing | All |
| Vanta | GRC evidence collection and compliance monitoring | Production |
| Google Vertex AI / Gemini | AI infrastructure (IaC-managed) | All |
| GCP Secret Manager | Secrets management for IaC workflows | All |
| Google Cloud Storage (GCS) | Terraform state backend | All |
| Cloud KMS | Customer-managed encryption keys for sensitive infrastructure | All |

### Exclusions

- Local development environments used solely for IaC code authoring (not applying changes to shared infrastructure)
- Third-party SaaS platforms not managed through Terraform (governed by Third-Party Risk Management Policy)
- Sandboxed proof-of-concept GCP projects explicitly designated as disposable by the CISO, provided they contain no production data and have no network connectivity to production environments

**HITRUST Evidence Note**: Scope definition satisfies HITRUST requirement for documented boundaries of configuration management controls (09.aa, 09.ab). This scope aligns with the system inventory maintained in MERGE's asset registry and the HITRUST r2 system boundary documentation.

---

## 3. Roles and Responsibilities

### 3.1 DevSecOps / Infrastructure Engineering

- Terraform module development and maintenance
- CI/CD pipeline configuration for IaC scanning and deployment gates
- State backend administration and standard backend module maintenance
- Custom scan rule development and maintenance
- Module security review for new community or third-party modules
- Drift detection pipeline operation
- Label enforcement implementation

### 3.2 TechOps / SysOps (SecOps / Information Security)

- Drift detection monitoring and escalation
- IaC security scan result review and triage
- Emergency change documentation verification
- State access anomaly investigation
- Quarterly IAM and state bucket access reviews
- HITRUST evidence collection for IaC controls in Vanta

### 3.3 Engineering (Developers / IaC Authors and Code Reviewers)

**IaC Authors:**

- IaC code development following this standard
- Pull request submission with required documentation, Jira ticket linkage, and plan output review
- Application of required resource labels
- Staging validation before production deployment
- Secrets hygiene (no hardcoded credentials)

**Code Reviewers:**

- Pull request review for security baseline compliance, label compliance, and naming conventions
- Plan output verification for unexpected changes
- Scan finding review before merge approval
- Verification that changes do not degrade security posture

### 3.4 Security Officer (Chief of Information Security / CISO)

- Standard ownership and approval
- Exception approvals for security baseline deviations, emergency changes, and service account key usage
- Drift escalation decisions
- Quarterly review of exception register
- Annual standard review
- Coordination with A-LIGN HITRUST assessor for IaC control evidence

### Additional Roles

**Change Management Board:**

- Production change approval per Section 5.4
- Emergency change retroactive review
- Change ticket completeness verification
- Quarterly review of change control compliance metrics

**All Personnel with GCP Access:**

- Compliance with the prohibition on manual production changes
- Reporting of discovered drift, misconfigurations, or security concerns to SecOps

**HITRUST Evidence Note**: Role definitions satisfy HITRUST 01.c (Allocation of Information Security Responsibilities) requirements for documented accountability in configuration management. This matrix shall be reviewed annually and updated when organizational changes affect IaC responsibilities.

---

## 4. Definitions

| Term | Definition |
|------|------------|
| **IaC (Infrastructure as Code)** | The practice of managing and provisioning computing infrastructure through machine-readable configuration files rather than manual console operations or interactive configuration tools. |
| **Terraform** | An open-source infrastructure as code tool by HashiCorp that enables users to define and provision cloud infrastructure using a declarative configuration language (HCL). MERGE's primary IaC tool. |
| **HCL (HashiCorp Configuration Language)** | The declarative configuration language used by Terraform to define infrastructure resources, variables, outputs, and provider configurations. |
| **State File** | A JSON file maintained by Terraform that maps the declared configuration to real-world infrastructure resources. Contains resource identifiers, configuration attributes, and in some cases sensitive values. Treated as a sensitive asset under this standard. |
| **Drift Detection** | The process of comparing the actual state of deployed infrastructure against the desired state defined in Terraform code to identify unauthorized, untracked, or unintended configuration changes. |
| **Module** | A reusable, versioned package of Terraform configuration that encapsulates a set of related resources. Modules promote consistency, reduce duplication, and enable centralized governance of infrastructure patterns. |
| **Provider** | A Terraform plugin that interfaces with a specific cloud platform or service API (e.g., the `google` provider for GCP). Providers must be version-pinned to ensure consistent behavior across environments. |
| **GCP Organization Policy** | A centralized governance mechanism in Google Cloud Platform that enforces constraints across all projects within an organization, such as restricting resource locations or disabling service account key creation. |
| **VPC Service Controls** | A GCP security feature that creates service perimeters around GCP resources to restrict data access and API calls to authorized networks and identities, mitigating data exfiltration risks. |
| **tfsec** | A static analysis security scanner for Terraform code that detects potential misconfigurations and security risks in HCL files before deployment. |
| **Checkov** | A static code analysis tool for infrastructure as code that scans Terraform, CloudFormation, and other IaC frameworks for security and compliance misconfigurations. |
| **Trivy** | An open-source vulnerability and misconfiguration scanner that supports Terraform IaC scanning alongside container image and filesystem scanning. |

---

## 5. Standard Requirements

### 5.1 IaC Development Standards

All MERGE infrastructure shall be defined, versioned, and deployed through Infrastructure as Code. Manual console changes to production infrastructure are prohibited except under documented emergency procedures.

**5.1.1 Code-First Provisioning**

All infrastructure in production GCP projects shall be provisioned through Terraform or another IaC tool approved in writing by the CISO. Direct console, CLI, or API changes to production infrastructure outside of IaC workflows are prohibited. Any infrastructure discovered in production that is not represented in Terraform code shall be documented as configuration drift and remediated within 30 calendar days.

*HITRUST Mapping*: 09.aa | *NIST 800-53*: CM-2, CM-3, SA-10

**5.1.2 Terraform Version and Provider Requirements**

Teams shall use Terraform versions within the current or immediately prior minor release supported by HashiCorp. Version pinning shall be enforced through `required_version` constraints in every Terraform configuration block. CI/CD pipelines shall validate the Terraform version before plan or apply execution and reject runs using unsupported versions.

Provider versions shall be explicitly pinned in `required_providers` blocks using version constraints (e.g., `~> 5.0` for the Google provider). Floating or unconstrained provider versions are prohibited. Provider lock files (`.terraform.lock.hcl`) shall be committed to source control and validated in CI/CD pipelines to ensure consistent provider versions across all environments and execution contexts.

The following providers require explicit version pinning at minimum:

- `google` (Google Cloud Platform)
- `google-beta` (GCP beta features)
- `random` (if used)
- Any third-party provider in use

*HITRUST Mapping*: 09.aa, 09.ab | *NIST 800-53*: CM-2, CM-6, SA-10

**5.1.3 Backend Configuration**

All Terraform configurations managing shared or production infrastructure shall declare a remote GCS backend with the following minimum configuration:

- `bucket`: A dedicated GCS bucket within a MERGE-controlled GCP project designated for state storage
- `prefix`: A unique prefix per Terraform workspace or configuration to prevent state file collisions
- Encryption: Server-side encryption enabled (Google-managed keys at minimum; CMEK via Cloud KMS required for production state files containing sensitive resource configurations)

A reference backend configuration shall be maintained by DevSecOps as a standard Terraform module. All new Terraform configurations shall use this standard backend module to ensure consistent encryption, versioning, locking, and IAM configurations. Configurations that do not use the standard backend module shall document the deviation and obtain DevSecOps approval.

*HITRUST Mapping*: 09.aa, 09.d | *NIST 800-53*: SC-28, CM-6

**5.1.4 Module Management and Version Control**

Terraform modules shall be versioned and stored in MERGE-controlled GitHub repositories within the organization's GitHub account. An internal module registry (GitHub-based or Terraform Cloud private registry) shall serve as the authoritative source for approved modules.

Module versions shall follow semantic versioning (MAJOR.MINOR.PATCH). Pinned module versions are required in all environment configurations -- the use of unversioned or `latest`-tagged module references in staging or production is prohibited. Module changes shall be tagged with release notes documenting the purpose and scope of each change.

**Approved Module Sources**:

- MERGE's internal module registry (GitHub repositories within the MERGE organization)
- HashiCorp verified modules from the Terraform Registry, subject to initial security review by DevSecOps before adoption
- Modules explicitly approved in writing by DevSecOps or Information Security and documented in the Approved Module Registry

**Prohibited Module Sources**:

- Unvetted community modules from the public Terraform Registry that have not undergone DevSecOps security review
- Modules sourced from personal GitHub repositories, forks, or repositories outside the MERGE organization without documented approval
- Modules referenced by Git URL without a pinned tag or commit SHA

New community or third-party modules shall undergo a security review prior to first use. The review shall assess: module source and maintainer reputation, pinned dependency versions, absence of embedded credentials or remote execution, license compatibility, and alignment with MERGE security baselines. The review shall be documented in a Jira ticket and retained as evidence.

*HITRUST Mapping*: 09.aa | *NIST 800-53*: CM-2, CM-6, SA-10

**5.1.5 Code Review Requirements**

All IaC changes shall be submitted through a GitHub pull request and require a minimum of one approving review from a qualified reviewer before merge to the main branch. Reviewers must verify that changes align with MERGE security baselines, follow naming and labeling conventions, do not introduce known misconfigurations, and do not degrade the security posture of existing resources.

Self-approval of pull requests is prohibited for production-impacting changes. Changes affecting IAM bindings, firewall rules, encryption configurations, VPC Service Controls, or organization policy constraints shall require review from a reviewer with documented security expertise (DevSecOps or Information Security).

Infrastructure code reviews shall apply the same rigor and timeliness standards as application code reviews defined in POL-0012 Section 3.6 (within 2 business days of submission; security-focused reviews within 3 business days).

*HITRUST Mapping*: 09.aa | *NIST 800-53*: CM-3, SA-10

**5.1.6 Variable and Secret Management**

No secrets, credentials, API keys, service account keys, private keys, or sensitive configuration values shall be stored in Terraform files (`.tf`), variable definition files (`.tfvars`), environment variable exports, or source control repositories. All sensitive values shall be sourced at runtime from one of the following approved mechanisms:

- **GCP Secret Manager**: Via Terraform `google_secret_manager_secret_version` data source or the Secret Manager provider
- **HashiCorp Vault**: Via the Terraform Vault provider (if adopted), for centralized secrets management across environments
- **CI/CD pipeline secret injection**: Via GitHub Actions Secrets or equivalent approved secret management, injected as environment variables at pipeline execution time and not persisted in state or logs

Terraform variables marked as `sensitive = true` shall be used for any value that should not appear in plan output or logs. Teams shall verify that sensitive values do not appear in `terraform plan` output before sharing plan results in pull requests.

Pre-commit hooks or CI pipeline checks shall scan IaC repositories for secrets (using tools such as gitleaks, truffleHog, or GitHub Advanced Security secret scanning) and block commits containing detected credentials. Any secret accidentally committed to an IaC repository shall be treated as compromised, rotated immediately, and documented in a Jira incident ticket.

*HITRUST Mapping*: 09.aa, 01.i | *NIST 800-53*: SC-28, IA-5, CM-6

**HITRUST Evidence Note**: Requirements 5.1.1 through 5.1.6 provide evidence for HITRUST 09.aa (Change Control Procedures) by documenting mandatory code-based provisioning, version controls, review gates, module governance, and secrets management. Retain pull request approval records, provider lock files, module review tickets, and state bucket configurations as audit artifacts. Module governance satisfies supply chain control requirements by ensuring only vetted, approved infrastructure components are deployed.

---

### 5.2 Security Scanning

Automated security scanning shall be integrated into every IaC change workflow to detect misconfigurations, policy violations, and security risks before infrastructure is deployed.

**5.2.1 Automated Scanning on Pull Requests**

Every pull request modifying Terraform code shall trigger automated IaC security scanning using one or more of the following approved tools: tfsec, Checkov, or Trivy. Scanning shall execute as part of the CI pipeline (GitHub Actions or equivalent) and results shall be visible in the pull request before review. Scanning shall cover both the Terraform HCL configurations and the planned resource changes.

*HITRUST Mapping*: 09.aa | *NIST 800-53*: CM-3, SA-11

**5.2.2 Finding Severity and Merge Blocking**

Findings classified as Critical or High severity by the scanning tool shall block the pull request from merging to the main branch. The author must remediate all Critical and High findings or obtain a documented exception approved by the CISO before the pull request may proceed. Medium and Low findings shall be documented, tracked in Jira, and remediated according to MERGE's vulnerability management SLAs:

| Severity | Action | Remediation SLA |
| -------- | ------ | --------------- |
| Critical | Block merge. Remediate before merge. | Before merge (immediate) |
| High | Block merge. Remediate before merge. | Before merge (immediate) |
| Medium | Document risk. Allow merge with tracking. | 30 calendar days |
| Low | Document. Allow merge. | 90 calendar days |

*HITRUST Mapping*: 09.aa | *NIST 800-53*: CM-4, SA-11, RA-5

**5.2.3 Scan Result Retention**

All scan results -- including passed scans, failed scans, and remediation actions -- shall be retained for a minimum of one (1) year. Scan results shall be stored in the CI/CD platform's artifact storage or exported to a centralized log repository. Retained scan records shall be available for HITRUST assessor review and internal audit.

*HITRUST Mapping*: 09.aa | *NIST 800-53*: AU-6, SA-11

**5.2.4 Custom Policy Rules**

MERGE shall maintain a custom policy rule set enforcing organization-specific security baselines beyond the default rules provided by scanning tools. At minimum, custom rules shall enforce the following:

- No public-facing GCS buckets unless explicitly approved by the CISO with documented exception
- No firewall rules permitting ingress from 0.0.0.0/0 (any source) unless explicitly approved by the CISO with documented exception and compensating controls
- No service accounts with project-level Owner or Editor IAM roles
- Encryption enabled on all storage resources
- Cloud Audit Logs enabled on all GCP projects
- No user-managed service account keys unless an approved exception exists
- Required labels present on all labelable resources (see Section 5.7)
- CMEK encryption on resources storing sensitive data

Custom rules shall be version-controlled in the same repository as IaC scanning configurations and updated as MERGE's security baselines evolve. Changes to custom rules shall follow the same pull request and review process as IaC code changes.

*HITRUST Mapping*: 09.aa, 09.d | *NIST 800-53*: CM-6, SA-11

**HITRUST Evidence Note**: Requirements 5.2.1 through 5.2.4 satisfy HITRUST 09.aa requirements for pre-deployment security validation and NIST CM-3 (Configuration Change Control) for automated verification of infrastructure changes. Retain CI pipeline logs showing scan execution and merge-blocking behavior as audit evidence. Custom policy rule configurations demonstrate that MERGE enforces organization-specific baselines beyond vendor defaults.

---

### 5.3 GCP Security Baselines

All GCP infrastructure provisioned through Terraform shall conform to the following security baselines. These baselines represent MERGE's minimum acceptable configuration for cloud resources and shall be enforced through both Terraform code conventions and automated IaC scanning (Section 5.2).

**5.3.1 Storage Security**

All GCS buckets shall enforce uniform bucket-level access (no legacy ACLs). No GCS bucket shall be configured with public access unless the CISO has granted a written, time-bound exception with documented business justification and compensating controls. Public access prevention shall be enabled at the organization level via organization policy constraints.

Object versioning shall be enabled on buckets storing sensitive data, state files, logs, or compliance artifacts. Encryption at rest shall be enabled on all GCS buckets:

- **Google-managed encryption keys (GMEK)**: Minimum requirement for all buckets
- **Customer-managed encryption keys (CMEK) via Cloud KMS**: Required for buckets storing PII, PHI, client confidential data, encryption keys, Terraform state for production environments, or any data classified as High under MERGE's data classification policy

Lifecycle policies shall be configured on all GCS buckets to manage object retention and transition to lower-cost storage classes in alignment with MERGE's data retention requirements.

*HITRUST Mapping*: 09.d, 01.i | *NIST 800-53*: SC-28, CM-6

**5.3.2 Network Security**

All VPC networks shall use a deny-all default firewall posture. Allow rules shall be explicitly defined with documented business justification, source/destination restrictions, and protocol/port specificity. Overly broad rules (e.g., allow all TCP, allow all UDP) are prohibited.

Firewall rules permitting ingress from 0.0.0.0/0 are prohibited unless explicitly approved by the CISO with a documented exception and compensating controls (e.g., WAF, DDoS protection, load balancer with health checks). Egress filtering shall be implemented for production workloads to restrict outbound traffic to known, required destinations.

Private Google Access shall be enabled on all VPC subnets hosting production workloads to allow GCP API access without exposing resources to the public internet. Internal-only IP addressing shall be the default for production Compute Engine instances, Cloud SQL instances, and GKE nodes.

VPC Service Controls shall be implemented for GCP projects and services that process, store, or transmit sensitive data. Service perimeters shall restrict API access to authorized networks and identities. Perimeter configurations shall be defined in Terraform and subject to the same review and scanning requirements as all other IaC.

*HITRUST Mapping*: 09.d, 01.i, 09.m | *NIST 800-53*: SC-7, CM-6, AC-6

**5.3.3 Identity and Access Management (IAM)**

IAM bindings shall follow the principle of least privilege. The following IAM restrictions are mandatory:

- **No primitive roles**: Project-level Owner or Editor roles shall not be assigned to service accounts, user accounts (except designated break-glass accounts), or groups in production projects. Custom IAM roles or predefined granular roles shall be used instead.
- **Custom roles for least privilege**: Where predefined GCP roles are overly permissive for the intended function, custom IAM roles scoped to the minimum required permissions shall be created and maintained in Terraform.
- **Workload Identity Federation**: Shall be used in preference to exported service account keys wherever technically feasible. This applies to CI/CD pipelines (GitHub Actions OIDC), GKE workloads (Workload Identity), and inter-service authentication.
- **No user-managed service account keys**: Service account key creation shall be restricted through the organization policy constraint `iam.disableServiceAccountKeyCreation`. Any exception for key-based authentication requires CISO approval, a documented business justification, a key rotation schedule not exceeding 90 days, and a documented migration plan to Workload Identity Federation.
- **IAM binding review**: All IAM bindings in production projects shall be reviewed quarterly by Information Security. Unused or overly broad bindings shall be remediated within 30 calendar days of discovery.

*HITRUST Mapping*: 01.i | *NIST 800-53*: AC-6, CM-6

**5.3.4 Encryption**

All data at rest in GCP shall be encrypted. Google-managed encryption is the baseline; customer-managed encryption keys (CMEK) via Cloud KMS shall be required for the following:

- Workloads processing sensitive data (PII, PHI, client confidential data, or data classified as High under MERGE's data classification policy)
- Terraform state files for production environments
- GCS buckets storing compliance artifacts, audit logs, or encryption keys
- Cloud SQL instances containing application data
- BigQuery datasets containing sensitive or regulated data

CMEK key rotation shall be configured with a maximum rotation period of 365 days. Key access policies shall follow least privilege, be defined in Terraform, and be audited quarterly. Key destruction shall require a minimum 30-day scheduled destruction period to allow recovery from accidental deletion.

*HITRUST Mapping*: 09.d | *NIST 800-53*: SC-28, CM-6

**5.3.5 Audit Logging**

Cloud Audit Logs shall be enabled for all GCP projects. Both Admin Activity logs (enabled by default and cannot be disabled) and Data Access logs (must be explicitly enabled) shall be active for all services in scope.

Audit logs shall be exported to a centralized logging sink (e.g., BigQuery, Cloud Logging bucket, or Google SecOps SIEM) and retained for a minimum of one (1) year. Log export sink configurations shall be defined in Terraform. Log access shall be restricted to authorized security and compliance personnel via IAM.

The following audit log categories shall be enabled at minimum:

- Admin Activity (all services) -- enabled by default
- Data Read (for services processing sensitive data)
- Data Write (for services processing sensitive data)
- System Event (all services)

Alerts shall be configured in Google SecOps SIEM for high-risk audit log events including: IAM policy changes, firewall rule modifications, organization policy constraint changes, service account key creation, and public access enablement on any resource.

*HITRUST Mapping*: 09.aa | *NIST 800-53*: AU-6, CM-6

**5.3.6 Organization Policy Constraints**

MERGE shall enforce GCP organization policy constraints through Terraform to establish guardrails across all projects. At minimum, the following constraints shall be enforced:

| Constraint | Policy | Purpose |
| ---------- | ------ | ------- |
| `compute.vmExternalIpAccess` | Restrict public IP addresses on Compute Engine instances | Prevent unintended public exposure |
| `storage.uniformBucketLevelAccess` | Enforce uniform bucket-level access on all GCS buckets | Eliminate legacy ACL complexity |
| `iam.disableServiceAccountKeyCreation` | Restrict service account key creation | Eliminate long-lived credential risk |
| `gcp.resourceLocations` | Restrict resource locations to approved GCP regions | Data residency and compliance |
| `iam.automaticIamGrantsForDefaultServiceAccounts` | Disable default service account IAM grants for new projects | Prevent overly permissive default configurations |
| `compute.disableSerialPortAccess` | Disable serial port access on Compute Engine instances | Reduce remote access attack surface |
| `sql.restrictPublicIp` | Restrict public IP addresses on Cloud SQL instances | Prevent database public exposure |

Organization policy constraint configurations shall be managed in a dedicated Terraform configuration within a centralized infrastructure repository. Changes to organization policy constraints shall require CISO approval and follow the production change control process (Section 5.4).

*HITRUST Mapping*: 09.d, 09.m, 01.i | *NIST 800-53*: CM-6, CM-7, SC-7

**HITRUST Evidence Note**: Requirements 5.3.1 through 5.3.6 satisfy HITRUST 09.d (Protection Against External and Environmental Threats), 09.m (Network Controls), 01.i (Policy on Use of Network Services), and NIST SC-7 (Boundary Protection) and CM-6 (Configuration Settings). Export organization policy constraint configurations, IAM audit reports, VPC Service Control perimeter definitions, CMEK key configurations, and audit log sink configurations as audit artifacts. These configurations demonstrate that MERGE enforces infrastructure security at the platform level, not merely through policy documentation.

---

### 5.4 Change Control

All infrastructure changes shall follow a documented change control process that ensures review, approval, traceability, and auditability.

**5.4.1 Plan Review Before Apply**

All Terraform changes shall include a `terraform plan` output that is reviewed by the change author and at least one approving reviewer before `terraform apply` is executed. The plan output shall be attached to the pull request or change ticket as evidence of pre-deployment review. Plan output for production changes shall be retained for a minimum of one (1) year.

Plan output shall be reviewed for: unexpected resource destruction or replacement, changes to IAM bindings, changes to firewall rules or network configurations, changes to encryption settings, and any resource modification outside the intended scope of the change.

*HITRUST Mapping*: 09.aa | *NIST 800-53*: CM-3, CM-4

**5.4.2 Production Apply Controls**

Production `terraform apply` executions shall require manual approval from an authorized approver. Auto-apply pipelines are prohibited in production environments. The individual approving a production apply shall be different from the individual who authored the change (separation of duties). Apply execution logs shall be captured and retained for a minimum of one (1) year.

Production apply execution shall occur only through authorized CI/CD pipelines or designated workstations. Direct `terraform apply` from local developer workstations against production environments is prohibited except under the emergency change procedure (Section 5.4.5).

*HITRUST Mapping*: 09.aa | *NIST 800-53*: CM-3, CM-5

**5.4.3 Change Ticket Linkage**

Every production infrastructure change shall be linked to a Jira change ticket. The change ticket shall document: the purpose of the change, affected systems, risk assessment, rollback plan, approver, and implementation date. Pull requests shall reference the associated Jira ticket number in the PR title or description. Changes without a linked ticket shall not be approved for production apply.

The combination of Jira ticket, GitHub pull request, plan output, apply log, and IaC scan results shall constitute the complete audit trail for each production infrastructure change.

*HITRUST Mapping*: 09.aa | *NIST 800-53*: CM-3

**5.4.4 Drift Detection**

Scheduled `terraform plan` executions (plan-only, no apply) shall run against production environments at a minimum weekly cadence to detect configuration drift caused by manual changes, external processes, or untracked modifications.

Detected drift shall be reported to SecOps within 24 hours of detection. Each drift occurrence shall be documented in a Jira ticket for investigation and remediation with the following information: affected resources, nature of the drift, suspected cause, and remediation plan.

Drift classification and response:

| Drift Type | Response | SLA |
| ---------- | -------- | --- |
| Security-impacting drift (unauthorized firewall rule, public bucket, IAM escalation, encryption disabled) | Treat as security incident; escalate per Incident Response Plan | Immediate investigation |
| Non-security drift (tag changes, minor configuration deviations) | Document and remediate | 30 calendar days |
| Expected drift (known manual changes pending IaC import) | Document in exception log | Per documented timeline |

Drift detection pipeline results shall be forwarded to Vanta for HITRUST evidence collection and retained for a minimum of one (1) year.

*HITRUST Mapping*: 09.aa | *NIST 800-53*: CM-3, CM-6

**5.4.5 Emergency Changes**

Emergency infrastructure changes made outside the standard IaC workflow (e.g., direct console changes during an active incident) shall be documented within 24 hours of execution. Documentation shall include: the nature of the emergency, changes made, personnel involved, impact assessment, and security implications.

Retroactive approval from the CISO or designated delegate is required within 48 hours. All emergency changes shall be backported into Terraform code within 5 business days to eliminate drift. Emergency changes that are not backported within 5 business days shall be escalated to the CISO.

Emergency changes shall be reviewed in the next Change Management Board meeting. The review shall confirm that retroactive documentation is complete, backporting is on track, and no residual security risk remains.

*HITRUST Mapping*: 09.aa | *NIST 800-53*: CM-3

**HITRUST Evidence Note**: Requirements 5.4.1 through 5.4.5 satisfy HITRUST 09.aa (Change Control Procedures) and NIST CM-3 (Configuration Change Control). Retain Jira change tickets, plan outputs, apply logs, drift detection reports, and emergency change documentation as primary audit artifacts. Emergency change documentation satisfies the HITRUST requirement for documented exception handling in change control. The drift detection program demonstrates continuous compliance monitoring beyond point-in-time assessments.

---

### 5.5 Environment Management

MERGE shall maintain strict separation between development, staging, and production environments. Environments shall be managed from a common IaC module library to ensure parity while maintaining isolation.

**5.5.1 GCP Project Separation**

Development, staging, and production workloads shall be deployed in separate GCP projects. Co-mingling of environments within a single GCP project is prohibited for any system in scope of HITRUST certification. GCP project naming conventions shall clearly identify the environment (e.g., `merge-prod-*`, `merge-staging-*`, `merge-dev-*`).

*HITRUST Mapping*: 09.ac | *NIST 800-53*: SC-7, CM-6

**5.5.2 Environment Parity Through Shared Modules**

Development, staging, and production environments shall be provisioned from the same Terraform modules with environment-specific variables controlling the differences between environments. This ensures that:

- Infrastructure changes are tested in lower environments before production deployment
- Configuration drift between environments is minimized
- Security controls applied in production are also present in staging for accurate pre-production validation

Environment-specific differences shall be limited to:

- Resource sizing (instance types, replica counts, scaling thresholds)
- Domain names and DNS entries
- CMEK key references (separate keys per environment)
- Network CIDR ranges
- Service account identities (per-environment accounts per Section 5.5.4)
- Environment labels and tags

Structural differences in security controls between environments (e.g., firewall rules that exist in production but not staging) shall be documented and justified. Staging environments shall mirror production security configurations as closely as feasible.

*HITRUST Mapping*: 09.ac | *NIST 800-53*: CM-2, CM-6

**5.5.3 Terraform Workspace and Project Isolation**

Each environment (dev, staging, production) shall use separate Terraform state files. The isolation strategy shall use one of the following approved approaches:

- **Separate state files per environment**: Each environment has its own backend prefix (e.g., `env/dev/`, `env/staging/`, `env/prod/`) within the same or separate GCS buckets
- **Terraform workspaces**: Named workspaces mapping to environments with workspace-specific variable files
- **Separate Terraform root configurations per environment**: With shared module references and environment-specific variable files

Regardless of the isolation approach chosen, the following requirements apply:

- Production state files shall be stored in a separate GCS bucket from non-production state files, or in a separate prefix with distinct IAM policies preventing non-production service accounts from accessing production state
- Cross-environment state references (e.g., `terraform_remote_state` data sources referencing production state from development configurations) shall be read-only and limited to non-sensitive outputs (e.g., VPC IDs, subnet IDs). Direct references to production secrets or sensitive resource attributes from non-production configurations are prohibited.
- CI/CD pipeline service accounts shall be environment-scoped. The service account used to apply changes to production shall not be the same service account used for development or staging applies.

*HITRUST Mapping*: 09.ac | *NIST 800-53*: SC-7, AC-6, CM-6

**5.5.4 Service Account Isolation**

Service accounts used in Terraform pipelines and workloads shall be scoped to a single environment. Cross-environment reuse of service accounts or service account keys is prohibited. Service accounts in production shall not have IAM bindings granting access to development or staging resources, and vice versa. Service account inventories shall be maintained per environment and reviewed quarterly.

*HITRUST Mapping*: 09.ac | *NIST 800-53*: AC-6

**5.5.5 Network Isolation**

Network routing between environments is prohibited unless an explicit, documented exception is approved by the CISO with compensating controls. VPC peering, shared VPCs, or VPN tunnels between production and non-production environments shall not be established without written CISO approval and a documented risk assessment. Firewall rules shall not permit traffic originating from development or staging networks to reach production resources.

*HITRUST Mapping*: 09.ac, 09.m | *NIST 800-53*: SC-7

**5.5.6 Staging Validation**

All production infrastructure changes shall be applied to the staging environment first and validated before production deployment. Staging validation shall confirm that the `terraform plan` output in staging matches expectations and that the applied infrastructure functions correctly before the same change is promoted to production.

Exceptions to staging-first deployment (e.g., emergency hotfixes) shall follow the emergency change procedure defined in Section 5.4.5.

*HITRUST Mapping*: 09.ac | *NIST 800-53*: CM-4

**HITRUST Evidence Note**: Requirements 5.5.1 through 5.5.6 satisfy HITRUST 09.ac (Protection of System Test Data) and NIST SC-7 (Boundary Protection) requirements for environment separation. Export GCP project structure, VPC configurations, state file backend configurations, service account IAM bindings, and Terraform module sharing evidence (showing shared modules with environment-specific variables) as audit artifacts. Environment parity through shared modules demonstrates that security controls are consistently applied across the infrastructure lifecycle.

---

### 5.6 State Management

Terraform state files contain a complete representation of managed infrastructure, including resource identifiers, configuration values, and in some cases sensitive attributes. State files shall be treated as sensitive assets and protected accordingly.

**5.6.1 Remote Backend Requirement**

All Terraform configurations managing shared or production infrastructure shall use a remote backend (GCS) for state storage. Local state files (`terraform.tfstate` on local workstations) are prohibited for any infrastructure beyond individual developer experimentation in isolated sandbox projects. CI/CD pipelines shall be configured to reject runs that reference local state backends for staging or production workspaces.

*HITRUST Mapping*: 09.aa, 09.d | *NIST 800-53*: SC-28, CM-6

**5.6.2 State Encryption**

All Terraform state files shall be encrypted at rest using server-side encryption in GCS. Production state files shall be encrypted using CMEK via Cloud KMS. The encryption key used for production state files shall be dedicated to state file encryption (not shared with application data encryption keys) and shall follow the key management requirements defined in Section 5.3.4.

*HITRUST Mapping*: 09.d | *NIST 800-53*: SC-28

**5.6.3 State Locking**

State locking shall be enabled to prevent concurrent modifications that could corrupt state files. GCS-native state locking (via Terraform's GCS backend) shall be used. Any infrastructure pipeline or workflow that bypasses state locking is prohibited. Lock timeouts shall be configured to prevent indefinite locks from blocking legitimate operations.

*HITRUST Mapping*: 09.aa | *NIST 800-53*: CM-6

**5.6.4 State Access Controls**

State file access shall be restricted to authorized service accounts and infrastructure administrators with documented business justification. Human access to raw state files in production shall require approval from the CISO or designated delegate.

State files may contain sensitive values (passwords, private keys, API keys) that Terraform stores in its state representation. To mitigate this risk:

- IAM policies on state buckets shall grant `storage.objects.get` and `storage.objects.create` only to authorized CI/CD service accounts and designated infrastructure administrators
- No broad IAM bindings (e.g., `roles/storage.objectViewer` at the project level) shall include the state bucket
- `allUsers` and `allAuthenticatedUsers` bindings are categorically prohibited on state buckets
- Terraform outputs marked as `sensitive` shall be used to prevent sensitive values from appearing in state output commands

*HITRUST Mapping*: 09.aa | *NIST 800-53*: AC-6, SC-28

**5.6.5 State Versioning**

Object versioning shall be enabled on all GCS buckets used for Terraform state storage. Versioning ensures that previous state versions are recoverable in the event of corruption, accidental deletion, or rollback requirements. State bucket lifecycle policies shall retain all object versions for a minimum of one (1) year before transitioning to archival storage.

*HITRUST Mapping*: 09.aa | *NIST 800-53*: SC-28, CP-9

**5.6.6 State Access Auditing**

Read and write access to Terraform state files shall be logged through GCS Data Access audit logs and Cloud Audit Logs. State access logs shall be forwarded to MERGE's centralized logging platform (Google SecOps SIEM) and monitored for anomalous access patterns. Alerts shall be configured for:

- State access from unexpected service accounts
- State access from IP addresses outside expected CIDR ranges
- State deletion events
- State access outside normal CI/CD pipeline execution windows
- Bulk state file read operations that may indicate exfiltration attempts

*HITRUST Mapping*: 09.aa | *NIST 800-53*: AU-6, AC-6

**5.6.7 State Backup and Recovery**

Terraform state files shall be backed up through GCS object versioning and, where business continuity requirements mandate, cross-region replication to a secondary GCS bucket in a different GCP region. State file versions shall be retained for a minimum of one (1) year.

State backup recoverability shall be tested at least annually as part of MERGE's business continuity testing program. The test shall demonstrate the ability to restore a Terraform state file from a previous version and successfully execute a `terraform plan` against the restored state.

Recovery procedures shall be documented in the IaC Operations Runbook and include:

- Steps to restore state from a previous GCS object version
- Steps to restore state from a cross-region replica (if configured)
- Steps to recover from state corruption using `terraform import` for critical resources
- Escalation contacts and CISO notification requirements for state loss events

*HITRUST Mapping*: 09.aa, 09.d | *NIST 800-53*: CP-9, CP-10

**HITRUST Evidence Note**: Requirements 5.6.1 through 5.6.7 satisfy HITRUST 09.aa requirements for configuration artifact protection and NIST SC-28 (Protection of Information at Rest) for sensitive configuration data. Export GCS bucket configurations showing versioning, CMEK encryption, IAM policies, and audit log configurations as evidence. State access auditing satisfies HITRUST requirements for monitoring of sensitive asset access. Annual state recovery testing satisfies business continuity testing requirements.

---

### 5.7 Resource Labeling Standards

All GCP resources provisioned through Terraform shall be labeled consistently to support cost management, compliance scoping, ownership tracking, and audit readiness.

**5.7.1 Required Labels**

The following labels shall be applied to all GCP resources that support labeling:

| Label Key | Description | Example Values | Required |
| --------- | ----------- | -------------- | -------- |
| `environment` | Deployment environment | `dev`, `staging`, `prod` | Yes |
| `owner` | Team or individual responsible for the resource | `secops`, `devops`, `ai-garage` | Yes |
| `cost-center` | Cost allocation identifier | `cc-1001`, `cc-2005` | Yes |
| `compliance-scope` | Regulatory or certification scope | `hitrust-r2`, `fedramp`, `internal-only` | Yes |
| `managed-by` | IaC tool managing the resource | `terraform`, `manual` | Yes |
| `project` | Project or application name | `patient-portal`, `data-pipeline` | Yes |
| `data-classification` | Data sensitivity level per MERGE's data classification policy | `public`, `internal`, `confidential`, `restricted` | Where applicable |

**5.7.2 Label Enforcement**

Labels shall be enforced through a combination of:

- **Terraform module defaults**: Standard modules shall include default label values and require overrides for mandatory labels
- **IaC scanning rules**: Custom scan rules (Section 5.2.4) shall flag resources missing required labels as Medium severity findings
- **Terraform validation**: `variable` validation blocks shall enforce label format and allowed values where feasible

Resources deployed without required labels shall be remediated within 30 calendar days of discovery. Label compliance shall be reviewed quarterly.

**5.7.3 Label Conventions**

- Label keys shall use lowercase letters and hyphens only (no underscores, no uppercase)
- Label values shall use lowercase letters, numbers, and hyphens only
- Label values shall not exceed 63 characters (GCP limit)
- Labels shall not contain sensitive information (e.g., no account numbers, no personnel identifiers)

*HITRUST Mapping*: 09.ab | *NIST 800-53*: CM-2, CM-6

**HITRUST Evidence Note**: Resource labeling standards satisfy HITRUST 09.ab (Configuration Management) requirements for asset identification and classification. The `compliance-scope` label enables automated identification of resources in scope for HITRUST r2 assessment. Export label compliance reports from GCP as audit evidence demonstrating that resources are consistently tagged for ownership, classification, and compliance scoping.

---

### Implementation Guidance

**Adoption Roadmap**: MERGE is in partial Terraform adoption. The following phased approach governs transition to full compliance:

| Phase | Controls | Target | Rationale |
| ----- | -------- | ------ | --------- |
| **Phase 1 -- Foundation** | Remote state backend with encryption (5.6), secrets scanning in CI (5.1.6), IaC scanning on PRs (5.2.1), required labels on new resources (5.7) | Within 30 days of approval | Highest-risk controls; prevents state exposure and misconfiguration |
| **Phase 2 -- Enforcement** | Merge-blocking for Critical/High findings (5.2.2), drift detection on production (5.4.4), change ticket linkage (5.4.3), module registry with version pinning (5.1.4) | Within 60 days of approval | Automated enforcement and change control auditability |
| **Phase 3 -- Baselines** | Organization policy constraints (5.3.6), CMEK for production state (5.6.2), GCP security baseline enforcement via custom scan rules (5.2.4, 5.3), environment parity verification (5.5.2) | Within 90 days of approval | Full GCP security baseline enforcement and environment consistency |
| **Phase 4 -- Full Compliance** | All production infrastructure managed through Terraform (5.1.1), state access monitoring and SIEM integration (5.6.6), annual state recovery testing (5.6.7), quarterly label compliance audits (5.7.2) | Within 120 days of approval | Complete compliance posture; HITRUST-ready evidence trail |

Systems not yet managed by Terraform shall be documented in the MERGE asset registry with a target date for IaC onboarding. New infrastructure provisioned after the effective date of this standard shall comply with all requirements from initial deployment.

### HITRUST Evidence Collection

The following artifacts shall be collected and maintained in Vanta for HITRUST assessor review:

| Evidence Artifact | Source | Collection Frequency | HITRUST Control |
| ----------------- | ------ | -------------------- | --------------- |
| Approved standard document (this document) | Vanta document library | Upon approval + each revision | 09.aa, 01.i, 09.d |
| Pull request approval records | GitHub | Continuous (automated) | 09.aa |
| IaC scan results (pass/fail with findings) | CI pipeline artifacts | Continuous (automated) | 09.aa |
| Terraform plan outputs (production) | CI pipeline artifacts | Per change | 09.aa |
| Drift detection reports | Scheduled pipeline runs | Weekly | 09.aa |
| Jira change tickets for production changes | Jira | Per change | 09.aa |
| GCS state bucket IAM and encryption configuration | GCP console / Terraform | Quarterly snapshot | 09.d, SC-28 |
| Organization policy constraint configuration | GCP console / Terraform | Quarterly snapshot | 09.d, CM-6 |
| VPC Service Control perimeter definitions | GCP console / Terraform | Quarterly snapshot | 01.i, SC-7 |
| CMEK key configuration and rotation status | Cloud KMS / Terraform | Quarterly snapshot | 09.d, SC-28 |
| Emergency change documentation | Jira / SecOps records | Per occurrence | 09.aa |
| Exception register with CISO approvals | Vanta / Jira | Quarterly review | 09.aa |
| Resource label compliance report | GCP / custom script | Quarterly | 09.ab |
| State recovery test results | DR testing records | Annually | CP-9 |
| Module security review records | Jira | Per new module adoption | 09.aa, SA-10 |

---

## 6. Compliance

### 6.1 Exception Handling

Exception requests to any requirement in this standard shall be submitted to the Chief of Information Security with the following documentation:

1. **Business justification**: A clear explanation of why the requirement cannot be met and the operational impact of non-compliance
2. **Specific requirement(s)**: Identification of the exact section(s) and sub-section(s) of this standard being waived
3. **Risk analysis**: Assessment of the risk introduced by the exception, including potential impact on MERGE's HITRUST r2 certification posture and NIST compliance obligations
4. **Compensating controls**: Description of alternative controls that mitigate the risk introduced by the exception
5. **Duration**: A time-bound expiration date not exceeding one (1) year without re-approval
6. **Remediation plan**: Steps and timeline to eliminate the exception and return to full compliance
7. **Jira tracking**: Exception request documented in a Jira ticket tagged `security-exception` for tracking and audit purposes

**Exception Scenarios**:

- **Emergency Infrastructure Changes**: If this standard's requirements conflict with active incident response (e.g., a production outage requiring immediate console changes), follow the emergency change procedure in Section 5.4.5. Document the exception and obtain retroactive approval within 48 hours.
- **Legacy Systems**: Infrastructure predating this standard that cannot yet be managed by Terraform shall be documented in the MERGE asset registry with a remediation timeline and target date for IaC onboarding. Legacy exceptions shall be reviewed quarterly and may not exceed 12 months without re-approval and demonstrated progress toward IaC adoption.
- **Third-Party Constraints**: If a vendor-managed integration requires infrastructure configurations that conflict with GCP security baselines (Section 5.3), the exception request must include the vendor's documented technical justification and a compensating control plan approved by the CISO.
- **Service Account Key Usage**: Exceptions to the prohibition on user-managed service account keys (Section 5.3.3) shall include a documented key rotation schedule (maximum 90 days), monitoring for anomalous key usage, and a migration plan to Workload Identity Federation with a target completion date.
- **Community Module Adoption**: Exceptions permitting use of unvetted community modules (Section 5.1.4) in non-production environments shall include a documented security review timeline and a commitment that the module will not be used in production until the review is complete.

All approved exceptions shall be logged in the exception register, tracked in Vanta, and reviewed quarterly by the CISO. Expired exceptions that have not been renewed are automatically revoked and the associated deviation shall be remediated within 30 calendar days of expiration.

**HITRUST Evidence Note**: Exception handling process satisfies HITRUST requirements for documented deviation management in configuration control (09.aa). Maintain the exception register as a standing audit artifact in Vanta. Time-bound exceptions with remediation plans demonstrate risk-based decision-making, which assessors expect.

---

## 7. Enforcement

Compliance with this standard is mandatory for all personnel who provision, modify, or manage MERGE infrastructure. The Information Security team enforces this standard through the following mechanisms:

### 7.1 Technical Enforcement

- CI pipeline checks that block merges when Critical/High scan findings are present (Section 5.2.2)
- GCP organization policy constraints that prevent non-compliant resource creation at the platform level (Section 5.3.6)
- State backend configurations that enforce encryption, versioning, locking, and access controls (Section 5.6)
- GitHub branch protection rules requiring pull request approval before merge (Section 5.1.5)
- Custom IaC scan rules enforcing MERGE-specific security baselines and label requirements (Section 5.2.4)
- Production environment pipeline configurations requiring manual approval before apply (Section 5.4.2)

### 7.2 Procedural Enforcement

- Quarterly review of production change tickets for change control compliance (Section 5.4.3)
- Weekly drift detection with SecOps escalation for unauthorized changes (Section 5.4.4)
- Quarterly access reviews for state file buckets and GCP project IAM bindings (Sections 5.3.3, 5.6.4)
- Annual review of custom scan policy rules against current security baselines (Section 5.2.4)
- Quarterly label compliance audit across all GCP projects (Section 5.7.2)
- Annual state backup recovery test (Section 5.6.7)

### 7.3 Noncompliance Consequences

Violations of this standard shall be addressed based on severity and intent:

- **Inadvertent noncompliance**: Written notification to the individual and their manager, mandatory review of this standard, and supervised remediation of the non-compliant configuration within 5 business days
- **Repeated noncompliance**: Escalation to management, temporary revocation of production deployment privileges pending remediation and retraining, and documented performance action
- **Willful circumvention**: Disciplinary action up to and including termination, consistent with MERGE's personnel policies. Immediate suspension of production infrastructure access pending investigation.
- **Noncompliance resulting in a security incident**: Handled per the Incident Response Plan with additional review by the CISO

Noncompliance that impacts MERGE's HITRUST r2 certification posture shall be escalated to the CISO within 24 hours of discovery for risk assessment and remediation prioritization. Noncompliance discovered during HITRUST assessment fieldwork shall be remediated before assessment completion.

---

## 8. Review & Change Management

### 8.1 Review Frequency

| Review Type | Frequency | Trigger |
| ----------- | --------- | ------- |
| Annual Full Review | Annually | Comprehensive review of all requirements against current infrastructure, threat landscape, and GCP service updates |
| Quarterly Configuration Audit | Every 90 days | Verify enforcement of scan rules, label compliance, state bucket configurations, and organization policy constraints |
| Ad Hoc Update | As needed | Significant infrastructure change, new GCP service adoption, security incident lessons learned, HITRUST assessor finding, Terraform major version release, or regulatory change |
| Scan Rule Review | Quarterly | Review and update custom scan policy rules to align with current baselines and newly identified misconfiguration patterns |

### 8.2 Approval Workflow

**Current Review Status**: DRAFT -- Pending Legal Review and Leadership Approval

**Approval Requirement for HITRUST r2 Evidence**: This standard must be approved before the HITRUST r2 v11.5 incubation period (May 2026) to satisfy 09.aa (Change Control Procedures), 01.i (Policy on Use of Network Services), and 09.d (Protection Against External and Environmental Threats) evidence requirements. Upload the approved version to Vanta upon approval.

**HITRUST Phase 1 Evidence Checklist** (complete before Vanta upload):

- [ ] Legal review completed -- date: __________
- [ ] Leadership approval obtained -- date: __________
- [ ] Uploaded to Vanta as HITRUST evidence for controls 09.aa, 01.i, 09.d
- [ ] Standard communicated to all affected personnel (DevSecOps, Infrastructure Engineering, SecOps)
- [ ] Acknowledgment recorded
- [ ] Standard backend module published and available for team use
- [ ] Custom scan rules published to IaC scanning pipeline
- [ ] Organization policy constraints deployed via Terraform
- [ ] Required label enforcement enabled in scan rules
- [ ] Next review date set in Vanta: 2027-02-23

---

## 9. Related Policies and Standards

| Document | Relationship |
| -------- | ------------ |
| POL-0012 Secure Software Development Lifecycle Policy | Parent policy. This standard implements the IaC-specific requirements of POL-0012 Sections 3.4.4 (IaC Scanning), 3.5 (Deployment and Change Management), and 3.7 (Branch Protection). |
| POL-0011 AI Governance, Security, and Acceptable Use Policy | AI infrastructure managed through IaC shall comply with POL-0011 governance requirements. Vertex AI and Gemini infrastructure provisioned via Terraform is in scope. |
| STD-0001 CI/CD Pipeline Security Standard | Pipeline security controls governing the CI/CD infrastructure through which Terraform changes are scanned, approved, and applied. |
| STD-0002 Container Security Standard | Container infrastructure (GKE, Cloud Run, Artifact Registry) provisioned via Terraform shall comply with STD-0002 requirements. Section 3.8 of STD-0002 cross-references this standard. |
| Information Security Policy | Master security policy governing MERGE's security program. This standard operates under its authority. |
| Incident Response Plan | Referenced for security-impacting drift escalation (Section 5.4.4) and emergency change procedures (Section 5.4.5). |
| Data Classification and Handling Policy | Informs CMEK encryption requirements (Section 5.3.4) and data classification labeling (Section 5.7). |
| Third-Party and Vendor Risk Management Policy | Governs third-party IaC modules and vendor-managed infrastructure excluded from this standard's scope. |
| Change Management Procedure | Governs the Jira-based change management workflow referenced in Section 5.4.3. |
| Business Continuity and Disaster Recovery Plan | Informs state backup and recovery requirements (Section 5.6.7). |

---

## Revision History

| Version | Date | Author | Change Summary |
| ------- | ---- | ------ | -------------- |
| 1.0 DRAFT | 2026-02-23 | Roze San Nicolas | Initial draft -- IaC security standard covering Terraform version management, GCP security baselines, change control, environment isolation, state management, resource labeling, and module governance; aligned to HITRUST CSF v11.5 and NIST 800-53 Rev 5 |

---

## Approval

Approved by: _________________________________ Date: ___________

Title: ________________________________________

Approved by: _________________________________ Date: ___________

Title: ________________________________________

---

*This document is controlled and maintained by MERGE TechOps / Information Security. Unauthorized alterations are prohibited.*
