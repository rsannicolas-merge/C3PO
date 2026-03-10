# STD-0001 CI/CD Pipeline Security Standard

MERGE TechOps Standard

**Document Control**

| Field | Value |
|-------|-------|
| Document Number | STD-0001 |
| Version | 1.0 DRAFT |
| Status | DRAFT -- Pending Legal Review and Leadership Approval |
| Author | Roze San Nicolas |
| Owner | Roze San Nicolas, Chief of Information Security |
| Last Updated | 2026-02-23 |
| Next Review | 2027-02-23 (annual) |
| Document Type | Standard |
| Related Policy | POL-0012 Secure Software Development Lifecycle Policy |
| Related Procedure | [None yet] |
| HITRUST CSF v11.5 Mapping | 09.aa (Change Control Procedures), 10.b (Technical Vulnerability Management), 09.i (System Audit Controls), 09.ab.05 (AI Model Security), 10.h (Control of Technical Vulnerabilities), 01.v (Information Access Restriction), 06.f (Prevention of Misuse of Information Assets) |
| NIST 800-53 Rev 5 Mapping | SA-15 (Development Process, Standards, and Tools), CM-3 (Configuration Change Control), CM-14 (Signed Components), SI-7 (Software, Firmware, and Information Integrity), SA-11 (Developer Testing and Evaluation), SA-10 (Developer Configuration Management), CM-4 (Impact Analyses), SC-28 (Protection of Information at Rest), IA-5 (Authenticator Management), AU-6 (Audit Record Review, Analysis, and Reporting) |

---

## 1. Purpose

This standard establishes mandatory security requirements for all Continuous Integration and Continuous Deployment (CI/CD) pipelines operated by MERGE. It defines the minimum security controls for source control, pipeline configuration, security gate enforcement, deployment approvals, artifact integrity, secrets management, pipeline audit logging, runner environment security, and software supply chain integrity across the software delivery lifecycle.

CI/CD pipelines are high-value targets for supply chain attacks, credential theft, and unauthorized code deployment. A compromised pipeline can bypass every other security control in the stack -- turning a single misconfiguration into a full production breach. This standard exists to prevent that.

This standard directly supports MERGE's HITRUST r2 v11.5 and AI2 certification programs by establishing auditable, enforceable controls over the software supply chain. It implements the pipeline security requirements of POL-0012 Secure Software Development Lifecycle Policy and provides the specific technical controls that assessors and auditors expect to see documented, implemented, and evidenced.

This standard addresses the following risks:

- Supply chain compromise through malicious or vulnerable third-party GitHub Actions, dependencies, or base images
- Credential theft and lateral movement via exposed secrets in pipeline logs, workflow files, or environment variables
- Unauthorized production deployments bypassing review, approval, and security testing gates
- Artifact tampering between build and deployment through unsigned or unverified artifacts
- Pipeline definition manipulation by unauthorized personnel modifying workflow files
- Loss of audit trail for production changes due to inadequate logging and monitoring
- Build environment compromise through uncontrolled or unpatched runner infrastructure

**HITRUST Evidence Note**: This standard satisfies HITRUST CSF v11.5 requirement 09.aa for documented change control procedures governing CI/CD pipelines, 10.b for technical vulnerability management within the build and deployment process, and 09.i for system audit controls over pipeline activity. Retain this document in Vanta as evidence for all three control specifications.

---

## 2. Scope

**Applies To:**

- All CI/CD pipelines operated by MERGE, including GitHub Actions workflows, Google Cloud Build pipelines, Terraform automation pipelines, and any future pipeline tooling adopted by the organization
- All source code repositories hosted in MERGE's GitHub organization
- All build, test, and deployment automation targeting MERGE-managed environments (development, staging, production) on Google Cloud Platform (GCP)
- All AI/ML model deployment pipelines, including those deploying to Google Vertex AI / Gemini endpoints
- All infrastructure-as-code (IaC) pipelines managing GCP resources via Terraform
- All pipeline runner infrastructure, including GitHub-hosted runners and any self-hosted or GCP-hosted build environments
- All personnel who create, modify, approve, or execute CI/CD pipelines, including full-time employees, contractors, and third-party integrators

**Systems Involved:**

| Environment | Approval Required | Security Gate Enforcement |
| ----------- | ----------------- | ------------------------- |
| Development | No manual approval | SAST, SCA, secrets scanning |
| Staging | No manual approval | Full security gate suite |
| Production | Manual approval required | Full security gate suite + deployment approval |

**Exclusions:**

- Local developer workstation builds not connected to MERGE CI/CD infrastructure
- Third-party SaaS CI/CD pipelines operated entirely by vendors with no MERGE code or secrets (governed by Third-Party Risk Management Policy)
- One-time migration scripts executed under emergency change management procedures, provided they are documented and approved per Section 6

**HITRUST Evidence Note**: Scope definition satisfies the assessment boundary requirement for HITRUST CSF v11.5 controls 09.aa, 10.b, and 09.i. This scope should be cross-referenced with the HITRUST r2 system inventory to confirm all pipeline-connected systems are captured.

---

## 3. Roles and Responsibilities

### 3.1 DevSecOps Team

Implements and maintains CI/CD pipeline security controls; configures security gates and scanning tooling; manages shared workflow libraries and approved actions list; monitors pipeline security posture; maintains runner hardening standards; configures SBOM generation; maintains IaC scanning policies; enforces lock file requirements in pipelines.

### 3.2 TechOps

Reviews and approves significant pipeline architecture changes via the Change Management Board; validates that production deployment procedures comply with this standard; reviews deployment audit trail samples quarterly.

### 3.3 Engineering

- **Development Team Leads**: Ensures team compliance with this standard; maintains CODEOWNERS files for their repositories; reviews and approves pull requests per Section 5.1; ensures Jira change tickets are linked to production deployments; verifies lock file hygiene in code reviews.
- **Individual Developers**: Configures commit signing; follows PR and review processes; does not hardcode secrets; maintains lock files; reports suspected secret exposure immediately; follows approved deployment procedures.

### 3.4 Security Officer (CISO)

Standard ownership and approval; designates authorized production deployment approvers; reviews exception requests; escalation point for non-compliance; coordinates HITRUST evidence collection for pipeline controls.

**Additional roles:**

- **Security Operations (SecOps)**: Monitors secrets scanning alerts and pipeline security events; responds to credential exposure incidents; conducts quarterly pipeline audit reviews; manages SIEM alerting for pipeline events; supports incident response for pipeline security incidents.
- **GRC / Compliance (Vanta)**: Tracks secret rotation compliance; collects and organizes HITRUST evidence for pipeline controls; monitors control effectiveness metrics; flags overdue evidence items.

**HITRUST Evidence Note**: This roles and responsibilities matrix satisfies HITRUST 09.aa requirement for documented accountability in change control. Include this section in the HITRUST evidence package as a supporting artifact.

---

## 4. Definitions

| Term | Definition |
|------|------------|
| **CI/CD** | Continuous Integration / Continuous Deployment -- the automated process of building, testing, and deploying software changes through a defined pipeline. |
| **Pipeline** | An automated workflow that executes a sequence of steps (build, test, scan, deploy) triggered by events such as code commits, pull requests, or manual approvals. |
| **GitHub Actions** | GitHub's native CI/CD platform used by MERGE for pipeline automation. Workflows are defined in YAML files stored in `.github/workflows/` within each repository. |
| **Artifact Integrity** | The assurance that a build artifact (container image, binary, package) has not been tampered with between build and deployment, verified through cryptographic signing and provenance attestation. |
| **SLSA** | Supply chain Levels for Software Artifacts -- a framework of progressive security levels for supply chain integrity. MERGE targets SLSA Level 2 (authenticated provenance from a hosted build service). |
| **Pinned Actions** | GitHub Actions referenced by a specific commit SHA (e.g., `actions/checkout@a5ac7e51b41094c92402da3b24376905380afc29`) rather than a floating tag (e.g., `@v4`), preventing silent supply chain substitution. |
| **Deployment Gate** | A manual or automated checkpoint in the pipeline that must be satisfied before a deployment can proceed to the next environment (e.g., production approval via GitHub environment protection rules). |
| **Security Gate** | An automated pipeline step that evaluates code, dependencies, or configuration against security policies and blocks progression if findings exceed defined severity thresholds (e.g., SAST, SCA, secrets scanning). |
| **Secrets Manager** | An approved secure storage and retrieval system for credentials, API keys, and tokens. MERGE-approved secrets managers are GitHub Actions Secrets and GCP Secret Manager. |
| **Runner** | The compute environment where CI/CD pipeline jobs execute. MERGE-approved runner types include GitHub-hosted runners, GCP Cloud Build, and MERGE-managed self-hosted runners. |

---

## 5. Standard Requirements

### 5.1 Source Control Security

All source code repositories shall implement the following controls to protect code integrity from initial commit through merge to production branches.

**5.1.1 Branch Protection Rules**

All repositories containing production-deployed code shall enforce branch protection on the `main` (or equivalent default) branch with the following settings:

- **Required pull request reviews**: A minimum of one (1) approving review is required before any merge to `main`. Security-critical repositories (as designated by the CISO or repository CODEOWNERS) shall require a minimum of two (2) approving reviews, at least one of which must be from a designated security reviewer.
- **Required status checks**: All mandatory CI checks (build, test, security scans) must pass before merge is permitted. Status checks shall be configured as "strict," requiring the branch to be up to date with `main` before merging.
- **No force push**: Force push to `main` and other protected branches shall be disabled for all users, including repository administrators. This prevents history rewriting that could obscure malicious commits.
- **No branch deletion**: Deletion of protected branches shall be disabled.
- **Require conversation resolution**: All review conversations must be resolved before merge.
- **Dismiss stale reviews**: Stale pull request approvals shall be automatically dismissed when new commits are pushed, requiring re-review of the updated code.

**5.1.2 Commit Signing**

All commits merged to production branches (`main`, `release/*`) shall be cryptographically signed using GPG or SSH signing keys configured in the developer's GitHub account. Unsigned commits shall be rejected by branch protection rules on production branches. Developers shall configure commit signing locally and register their public keys with GitHub. Merge commits created by GitHub's web interface satisfy this requirement when the committer's account has verified signing keys.

**5.1.3 CODEOWNERS Enforcement**

A `CODEOWNERS` file shall be maintained in the root of every repository containing production code. The following paths shall have designated security-aware owners who must approve changes:

- `.github/workflows/` -- CI/CD pipeline definitions
- `terraform/` or equivalent IaC directories -- infrastructure configurations
- Security configuration files (e.g., `security.txt`, CSP headers, authentication configurations)
- Secrets-adjacent files (e.g., `.env.example`, secret references, vault configurations)
- Dependency manifests (`package.json`, `requirements.txt`, `go.mod`, `Gemfile`, `pyproject.toml`, etc.)
- Dockerfiles and container build configurations

CODEOWNERS assignments shall be reviewed quarterly by the repository owner and the Information Security team.

**5.1.4 Pull Request Requirements**

- All changes to protected branches shall be made via pull request. Direct commits to protected branches are prohibited.
- Pull requests shall include a description of the change, the reason for the change, and any security implications.
- Pull requests modifying CI/CD workflows, Terraform configurations, or security-sensitive paths shall be tagged for security review.
- Stale pull request approvals shall be dismissed when new commits are pushed, requiring re-review.

*HITRUST Mapping*: 09.aa (Change Control Procedures) | *NIST 800-53*: CM-3, CM-14, SA-10 | *Vanta Evidence*: Export branch protection settings from GitHub org settings; screenshot CODEOWNERS files for security-sensitive repositories.

**HITRUST Evidence Note**: Branch protection configurations, CODEOWNERS files, and PR review logs constitute direct evidence for HITRUST 09.aa. Export GitHub audit logs showing enforcement of these controls quarterly and retain in Vanta.

---

### 5.2 Pipeline Configuration Security

All CI/CD pipeline definitions shall be treated as security-critical infrastructure code, subject to the same review, versioning, and access controls as application source code.

**5.2.1 YAML Hardening and Workflow Permissions**

Every GitHub Actions workflow file shall explicitly declare the minimum required permissions for `GITHUB_TOKEN` at the workflow level using the `permissions` key. The default token permissions for the MERGE GitHub organization shall be set to **read-only** at the organization level.

- Workflows shall not use `permissions: write-all` or omit the `permissions` key (which inherits overly broad defaults).
- Each workflow shall declare only the specific permissions it requires (e.g., `contents: read`, `pull-requests: write`).
- Workflows requiring elevated permissions shall document the justification in a code comment within the workflow file.
- Workflow `run` steps shall not use `eval`, shell expansion of untrusted inputs, or direct interpolation of user-controlled values (e.g., `${{ github.event.pull_request.title }}`) in shell commands to prevent script injection.
- Workflow triggers shall be scoped to the minimum required events. The `pull_request_target` trigger shall not be used unless explicitly approved by the CISO due to its elevated risk profile (it runs with write access and secrets from the base branch).

**5.2.2 GitHub Actions Pinning and Third-Party Action Review**

All GitHub Actions used in MERGE workflows shall be pinned to a specific commit SHA, not a floating tag (e.g., `v1`, `latest`, `main`). This prevents supply chain attacks where a compromised upstream action is silently replaced under the same tag.

- **Required format**: `uses: actions/checkout@a5ac7e51b41094c92402da3b24376905380afc29` (full SHA)
- **Prohibited format**: `uses: actions/checkout@v4` (floating tag)
- Renovate, Dependabot, or equivalent automated tooling shall be configured to propose SHA updates when upstream actions release new versions, subject to review before merge.
- **First-party actions** (`actions/*` and `github/*` namespaces): Permitted after SHA pinning. No additional review required.
- **Third-party actions** (all other namespaces): Shall undergo a security review before first use, documented in a Jira ticket. The review shall evaluate: the action's source code, permissions requested, maintainer reputation, download/usage metrics, and any known vulnerabilities. Third-party actions shall not be adopted without documented approval from the DevSecOps team.
- **Forked actions**: If a third-party action is forked into MERGE's GitHub organization for security or stability reasons, the fork shall be documented and the team responsible for maintaining the fork shall be designated.
- A list of approved third-party actions shall be maintained by DevSecOps and reviewed quarterly.

**5.2.3 No Hardcoded Secrets in Pipeline Definitions**

Secrets, credentials, tokens, API keys, and any sensitive configuration values shall never appear in plaintext within workflow files, pipeline scripts, repository code, or commit history.

- All secrets shall be stored in GitHub Actions Secrets (repository or organization level), GCP Secret Manager, or an equivalent approved secret management solution.
- Workflow files shall reference secrets exclusively via `${{ secrets.SECRET_NAME }}` syntax or equivalent secure injection mechanisms.
- If a secret is accidentally committed, it shall be treated as compromised, rotated immediately, and the commit history cleaned. An incident ticket shall be filed in Jira.
- Environment variables containing sensitive values shall be injected at runtime from approved secret stores, never defined as plaintext defaults in workflow YAML.

**5.2.4 Pipeline-as-Code Versioning**

- All pipeline definitions (`.github/workflows/*.yml`, Cloud Build configuration files) shall be versioned in the same repository as the application code they build and deploy, or in a dedicated shared-workflows repository with the same branch protection and review controls.
- Changes to pipeline definitions shall follow the same pull request and review process as application code changes (Section 5.1.4).
- A shared workflow library for common patterns (build, scan, deploy) shall be maintained to reduce duplication and enforce consistent security controls across repositories.

*HITRUST Mapping*: 09.aa (Change Control Procedures), 01.v (Information Access Restriction) | *NIST 800-53*: SA-15, CM-3, SC-28 | *Vanta Evidence*: Sample workflow files demonstrating SHA pinning and scoped permissions; GitHub organization token permission settings.

**HITRUST Evidence Note**: Workflow files with SHA-pinned actions, explicit permission scoping, and YAML hardening serve as implementation evidence for HITRUST 09.aa. Include representative workflow files in the Vanta evidence package with annotations highlighting the relevant controls.

---

### 5.3 Security Scanning Gates

Every CI/CD pipeline deploying to MERGE-managed environments shall enforce automated security gates that prevent known-vulnerable or non-compliant code from progressing through the pipeline. Security gate failures shall block the pipeline and require remediation before proceeding.

**5.3.1 Static Application Security Testing (SAST)**

- A SAST scan shall be executed on every pull request targeting `main` and on every push to `main`.
- SAST findings rated Critical or High severity shall block the merge. Medium findings shall generate a warning and require documented risk acceptance if the merge proceeds.
- SAST tooling shall be configured to cover all languages and frameworks in active use across MERGE repositories.
- False positives shall be suppressed only with documented justification in the SAST tool's configuration, reviewed during quarterly security reviews.

**5.3.2 Software Composition Analysis (SCA) and Dependency Scanning**

- An SCA scan shall be executed on every pull request to identify known vulnerabilities in third-party dependencies.
- Dependencies with Critical severity CVEs shall block the merge. High severity CVEs shall block the merge unless a documented risk acceptance is approved by the CISO or designated security lead.
- Dependency manifests shall be monitored continuously via automated tooling (Dependabot, Renovate, or equivalent) to detect newly disclosed vulnerabilities in already-merged dependencies.
- License compliance scanning shall be included in SCA to flag dependencies with licenses incompatible with MERGE's usage requirements.

**5.3.3 Secrets Scanning**

- Automated secrets scanning shall be executed on every push to any branch in all MERGE repositories.
- GitHub Advanced Security secret scanning (or equivalent tooling) shall be enabled organization-wide with push protection enabled, preventing secrets from being pushed in the first place.
- Detected secrets shall trigger an immediate alert to the Information Security team and the committing developer. The secret shall be treated as compromised and rotated per Section 5.6.
- Custom secret patterns specific to MERGE (e.g., internal API key formats, GCP service account key patterns) shall be configured in the scanning tool.

**5.3.4 Infrastructure-as-Code (IaC) Security Scanning**

- All Terraform changes shall be scanned by an IaC security scanner (e.g., tfsec, Checkov, Trivy, or equivalent) as a required pipeline step before merge.
- Findings that introduce publicly exposed resources, overly permissive IAM bindings, unencrypted storage, or disabled audit logging shall block the merge.
- IaC scan policies shall be aligned with MERGE's GCP security baseline, CIS Google Cloud Foundations Benchmark, and STD-0003 Infrastructure as Code Security Standard.

**5.3.5 Container Image Scanning**

- All container images shall be scanned for known vulnerabilities before deployment to any MERGE environment. Scanning shall occur both at build time in the CI pipeline and continuously on images stored in GCP Artifact Registry.
- Images with Critical vulnerabilities shall not be deployed to production. High severity vulnerabilities require documented risk acceptance from the CISO.
- Only images stored in MERGE's authorized container registry (GCP Artifact Registry) and passing vulnerability scanning may be deployed to production.
- Base images shall be sourced from approved, maintained base image catalogs (e.g., Google distroless images, official Docker Hub images verified by MERGE DevSecOps) and updated at least monthly.
- Container images shall be rebuilt from source (not patched in place) when vulnerabilities are remediated.

**5.3.6 Security Gate Enforcement Requirements**

- All security gates defined in this section shall be configured as **required status checks** in GitHub branch protection rules. Advisory-only configurations are not compliant.
- Security gates shall not be bypassable by repository administrators without a documented exception per Section 6.
- If a security gate tool experiences an outage, merges shall be paused until the tool is restored. Emergency merges during tool outages require CISO or designee approval and retrospective scanning within 24 hours.

*HITRUST Mapping*: 10.b (Technical Vulnerability Management), 09.aa (Change Control Procedures) | *NIST 800-53*: SA-11, SI-7, CM-4, SA-15 | *Vanta Evidence*: Security gate configuration screenshots; sample scan reports showing blocking enforcement; pipeline run logs showing gate pass/fail.

**HITRUST Evidence Note**: Security gate enforcement constitutes primary evidence for HITRUST 10.b (Technical Vulnerability Management). Retain scan reports, pipeline logs showing blocked merges due to security findings, and configuration exports showing gate enforcement is mandatory (not advisory). Upload quarterly scan summaries to Vanta.

---

### 5.4 Deployment Controls

Production deployments shall be subject to approval, audit, and rollback controls that ensure only authorized, tested, and traceable changes reach production environments.

**5.4.1 Production Deployment Approval**

- All deployments to the production environment shall require explicit manual approval from at least one authorized approver before execution. Authorized approvers are designated by the CISO and maintained in the GitHub environment protection rules.
- Automated deployments to production without human approval are prohibited. This applies to all pipeline types: application deployments, Terraform applies to production, AI model deployments to Vertex AI production endpoints, and database migrations.
- Approvers shall verify that all security gates (Section 5.3) have passed, that a corresponding change ticket exists in Jira, and that rollback procedures are documented before granting approval.

**5.4.2 GitHub Environment Protection Rules**

- The `production` environment in GitHub shall be configured with the following protection rules:
  - **Required reviewers**: At least one designated approver must approve the deployment.
  - **Wait timer**: A minimum 5-minute wait timer shall be configured to allow for last-minute holds (configurable per repository based on risk).
  - **Branch restrictions**: Only the `main` branch (or designated release branches) may deploy to production.
- Environment secrets for production shall be scoped exclusively to the `production` environment and not accessible from other environments.
- Staging and development environments shall have their own environment configurations with environment-specific secrets.

**5.4.3 Deployment Audit Trail**

- Every production deployment shall be linked to a Jira change management ticket. The change ticket shall include: description of the change, risk assessment, rollback plan, approver name, and deployment timestamp.
- GitHub deployment logs shall be retained for a minimum of one (1) year.
- The combination of Jira ticket, GitHub pull request, pipeline run log, and deployment approval record shall constitute the complete audit trail for each production change.
- Deployments without a linked Jira ticket shall be flagged as non-compliant and escalated to the CISO for review within 24 hours.

**5.4.4 Rollback Procedures**

- Each deployment pipeline shall include a documented rollback procedure that can restore the previous known-good state within the SLA-defined recovery time objective.
- Rollback procedures shall be tested at least annually per pipeline, with test results documented and retained.
- Rollback execution shall not require re-approval if triggered within 4 hours of the original deployment and the rollback target is the immediately preceding version.
- Emergency rollbacks outside the 4-hour window shall follow the emergency change management process and be documented in Jira within 24 hours.

*HITRUST Mapping*: 09.aa (Change Control Procedures), 06.f (Prevention of Misuse of Information Assets) | *NIST 800-53*: CM-3, CM-4, SA-10 | *Vanta Evidence*: GitHub environment protection rule configurations; sample Jira change tickets linked to deployment PRs; deployment approval logs.

**HITRUST Evidence Note**: The deployment audit trail (Jira ticket + GitHub PR + pipeline log + approval record) is the primary evidence package for HITRUST 09.aa change control. Export a sample of 3-5 recent production deployments with complete audit trails for the assessor evidence package. Retain in Vanta.

---

### 5.5 Build Artifact Integrity

Build artifacts shall be protected against tampering, unauthorized access, and loss throughout their lifecycle from build to deployment and long-term retention.

**5.5.1 Authorized Artifact Registries**

- All build artifacts (container images, compiled binaries, packaged applications, Terraform modules) destined for MERGE environments shall be stored exclusively in MERGE-controlled registries. The authorized registry is **GCP Artifact Registry** within MERGE's GCP organization.
- Publishing artifacts to public registries, personal registries, or unauthorized storage locations is prohibited.
- Artifact Registry access shall be restricted via GCP IAM to authorized CI/CD service accounts and designated personnel. Human access to production artifact repositories shall require justification and be reviewed quarterly.

**5.5.2 Artifact Signing and Provenance**

- Production build artifacts shall include provenance attestation establishing the link between the artifact, the source commit, the pipeline that built it, and the security gates that were passed.
- Container images deployed to production shall be signed using Sigstore cosign, Binary Authorization, or equivalent tooling integrated with GCP Artifact Registry.
- GCP Binary Authorization policies shall be configured to allow only signed, attested images to be deployed to production GKE clusters or Cloud Run services.
- The provenance chain (source commit -> PR merge -> pipeline build -> security gate pass -> artifact sign -> deployment approval -> production deploy) shall be reconstructable from audit logs for any production artifact.
- MERGE shall target SLSA (Supply chain Levels for Software Artifacts) Level 2 compliance as a near-term goal: build process defined in code (SLSA Level 1) with authenticated provenance generated by a hosted build service (SLSA Level 2). SLSA Level 3 (hardened build platform) shall be evaluated during annual review.

**5.5.3 SBOM Generation as Pipeline Artifact**

- A Software Bill of Materials (SBOM) shall be generated automatically as a required step in every CI/CD pipeline that produces a production release artifact. No production deployment shall proceed without a successfully generated SBOM attached to the build.
- SBOMs shall be produced in **CycloneDX** (preferred) or **SPDX** format, capturing all direct and transitive dependencies including: package name, version, license, supplier/publisher, and package URL (purl).
- SBOMs shall be stored alongside the release artifact in GCP Artifact Registry or GitHub Releases and retained for a minimum of one (1) year from the date of the associated production release.
- During incident response, SBOMs shall be used to rapidly determine whether a newly disclosed vulnerability affects any production release.
- SBOM generation shall comply with PROC-0001 Software Composition and Dependency Management Procedure.

**5.5.4 Artifact Retention**

- Production artifacts shall be retained for a minimum of one (1) year from the date of deployment to production. This aligns with MERGE's audit evidence retention requirements and supports incident investigation and forensic analysis.
- Non-production artifacts (development, staging builds) shall be retained for a minimum of ninety (90) days.
- Artifact cleanup automation shall not delete any artifact that is currently deployed to any environment or referenced by an active deployment record.
- Retention policies shall be implemented via GCP Artifact Registry lifecycle policies and validated quarterly.

*HITRUST Mapping*: 10.b (Technical Vulnerability Management), 09.aa (Change Control Procedures) | *NIST 800-53*: SI-7, CM-14, SA-10 | *Vanta Evidence*: GCP Artifact Registry IAM configuration; Binary Authorization policy export; artifact retention policy configuration; sample SBOM output files.

**HITRUST Evidence Note**: Artifact signing, provenance attestation, and SBOM generation provide integrity evidence for HITRUST 10.b and NIST SI-7 and CM-14 (Signed Components). Export Binary Authorization policy configurations, a sample artifact attestation record, and a sample SBOM for the evidence package in Vanta.

---

### 5.6 Secrets Management in Pipelines

All secrets used in CI/CD pipelines and deployment processes shall be managed with controls that prevent exposure, enforce rotation, and enable rapid response to compromise.

**5.6.1 Approved Secret Storage**

All secrets, credentials, API keys, tokens, and sensitive configuration values used in CI/CD pipelines shall be stored in one of the following approved locations:

- **GitHub Actions Secrets** (organization-level or repository-level) for pipeline-specific secrets
- **GCP Secret Manager** for application and infrastructure secrets consumed at runtime
- An equivalent secrets management solution explicitly approved by the CISO

The following storage locations are explicitly prohibited for secrets:

- Workflow YAML files, pipeline scripts, or any file committed to source control
- Environment variables defined in plaintext in pipeline configuration
- Hardcoded values in application source code
- Local developer machines (for production secrets)
- Shared documents, wikis, Slack messages, or email

**5.6.2 Secret Visibility in Logs**

- Secrets shall never appear in CI/CD pipeline logs, build output, or deployment logs. GitHub Actions automatically masks registered secrets in logs; teams shall verify this masking is functioning and report any secret exposure immediately.
- Custom scripts within pipelines shall not echo, print, or log secret values. Code reviews shall verify that pipeline scripts do not inadvertently expose secrets.
- If a secret is detected in pipeline logs, it shall be treated as compromised and rotated immediately per Section 5.6.4.

**5.6.3 Secret Rotation Cadence**

Secrets shall be rotated on the following schedule:

| Secret Type | Maximum Rotation Cadence | Notes |
| ----------- | ------------------------ | ----- |
| GCP service account keys | 90 days | Prefer workload identity federation to eliminate long-lived keys where possible |
| GitHub personal access tokens | 90 days | Use fine-grained tokens scoped to minimum required repositories and permissions |
| API keys (internal services) | 365 days | Shorter rotation preferred; 365 days is the maximum |
| API keys (third-party services) | 365 days | Coordinate with vendor rotation capabilities |
| Database credentials | 90 days | Automated rotation via GCP Secret Manager preferred |
| OAuth client secrets | 365 days | Coordinate rotation with application deployment |
| Signing keys (artifact signing) | 365 days | Rotation must include re-signing of active artifacts if required |
| SSH deploy keys | 180 days | Prefer OIDC-based authentication where possible |

- Rotation schedules shall be tracked in Vanta or equivalent GRC tooling. Overdue rotations shall generate alerts to the Information Security team.
- Where supported, automated rotation via GCP Secret Manager's rotation features shall be preferred over manual rotation.

**5.6.4 Compromise Response**

- Upon suspected or confirmed secret compromise, the affected secret shall be rotated immediately -- within one (1) hour of detection during business hours, or within four (4) hours outside business hours.
- The compromised secret shall be revoked (not just rotated) to prevent continued use of the exposed value.
- An incident ticket shall be filed in Jira documenting: the secret type, exposure vector, time of detection, time of rotation, blast radius assessment, and remediation actions taken.
- If the compromised secret provided access to production systems or data, the incident shall be escalated to the CISO and handled under the Incident Response Plan.
- Post-incident review shall identify the root cause of the exposure and implement controls to prevent recurrence.

*HITRUST Mapping*: 01.v (Information Access Restriction), 09.aa (Change Control Procedures) | *NIST 800-53*: IA-5, SC-28, CM-3 | *Vanta Evidence*: Secret rotation tracking dashboard; sample rotation records; incident tickets for any compromise events.

**HITRUST Evidence Note**: Secret rotation records and compromise response documentation satisfy HITRUST 01.v and IA-5 requirements for authenticator management. Export rotation compliance reports from GCP Secret Manager and GitHub audit logs quarterly. Retain compromise incident tickets as evidence of the response process. Upload to Vanta.

---

### 5.7 Pipeline Audit Logging and Monitoring

All CI/CD pipeline activity shall be logged, retained, and monitored to support incident investigation, compliance verification, and HITRUST assessor evidence requirements.

**5.7.1 Pipeline Activity Logging**

The following pipeline events shall be logged and retained:

- All pipeline workflow runs (trigger, start time, end time, status, triggering user, triggering event)
- All deployment approvals and rejections (approver identity, timestamp, target environment)
- All security gate results (scan tool, findings count by severity, pass/fail status)
- All artifact build and push events (artifact name, digest/hash, target registry)
- All changes to workflow files (commit author, reviewer, approval timestamp)
- All changes to GitHub repository settings (branch protection modifications, environment protection changes, secret additions/deletions)
- All changes to GitHub organization settings affecting pipeline security (default token permissions, allowed actions lists, runner group assignments)

**5.7.2 Log Retention**

- Pipeline execution logs shall be retained for a minimum of one (1) year.
- GitHub audit logs shall be streamed to MERGE's centralized SIEM (Google SecOps) for correlation, alerting, and long-term retention.
- Cloud Build audit logs (if Cloud Build is in use) shall be captured via GCP Cloud Audit Logs and forwarded to Google SecOps SIEM.

**5.7.3 Pipeline Monitoring and Alerting**

The following events shall trigger alerts to the Information Security team:

- Modification of branch protection rules on any production repository
- Modification of GitHub environment protection rules for the `production` environment
- Addition of new GitHub Actions secrets at the organization level
- Pipeline execution from an unexpected branch deploying to production (branch restriction bypass attempt)
- Disabled or removed security scanning steps in workflow files
- Failed deployment approvals (rejected deployments)
- Secrets detected in pipeline logs or build output
- Unusual pipeline execution patterns (e.g., deployments outside normal business hours, high-frequency pipeline runs from a single user)

Alerts shall be configured in Google SecOps SIEM and reviewed by SecOps within the response SLAs defined in the Incident Response Plan.

**5.7.4 Quarterly Audit Review**

- The Information Security team shall conduct a quarterly review of pipeline audit logs to verify: (a) all production deployments have complete audit trails, (b) security gates were not bypassed, (c) pipeline configurations were not modified without proper review, and (d) secret management practices are compliant.
- Quarterly audit review findings shall be documented and reported to the CISO. Non-compliance findings shall be tracked in Jira for remediation.

*HITRUST Mapping*: 09.i (System Audit Controls), 09.aa (Change Control Procedures) | *NIST 800-53*: AU-6, CM-3, SI-7 | *Vanta Evidence*: SIEM alert configurations for pipeline events; quarterly audit review reports; sample pipeline execution logs showing audit trail completeness.

**HITRUST Evidence Note**: Pipeline audit logging, SIEM integration, and quarterly audit reviews satisfy HITRUST 09.i (System Audit Controls) requirements for CI/CD systems. Export SIEM alert rule configurations and a sample quarterly audit review report as evidence for the assessor package. Retain in Vanta.

---

### 5.8 Pipeline Access Controls

Access to create, modify, and execute CI/CD pipelines shall be restricted to authorized personnel and service accounts following the principle of least privilege.

**5.8.1 Workflow Modification Access**

- Only personnel with a documented business need shall have write access to CI/CD workflow files (`.github/workflows/`, Cloud Build configuration files).
- Write access to workflow files shall be enforced through CODEOWNERS rules (Section 5.1.3) requiring approval from designated pipeline security owners before changes are merged.
- Repository administrator access shall be limited to the minimum number of personnel required for repository management. Administrator access shall be reviewed quarterly and justified per individual.

**5.8.2 Deployment Privilege Restrictions**

- The list of authorized production deployment approvers shall be maintained by the CISO and configured in GitHub environment protection rules.
- Deployment approval privileges shall be granted based on role, not individual request, and reviewed quarterly.
- Individuals who authored a change shall not approve its deployment to production (separation of duties). GitHub environment protection rules shall enforce this where technically feasible.

**5.8.3 Service Account Access Controls**

- CI/CD pipeline service accounts (GitHub Actions service accounts, Cloud Build service accounts) shall follow the principle of least privilege. Each service account shall be scoped to the minimum permissions required for its specific pipeline function.
- Service accounts with production deployment privileges shall be inventoried, documented, and reviewed quarterly.
- Service account credentials shall be managed per Section 5.6.
- Workload Identity Federation shall be preferred over long-lived service account keys for authenticating GitHub Actions to GCP resources.

**5.8.4 GitHub Organization Security Settings**

The following settings shall be enforced at the MERGE GitHub organization level:

- Default GITHUB_TOKEN permissions set to **read-only**
- GitHub Actions execution restricted to: actions created by GitHub, actions by verified marketplace creators, and explicitly approved actions maintained in an allowlist by DevSecOps
- Fork pull request workflows require approval before running
- Fork pull request workflows from outside collaborators require approval before running
- Workflow permissions for `GITHUB_TOKEN` default to read-only at the organization level

*HITRUST Mapping*: 01.v (Information Access Restriction), 09.aa (Change Control Procedures), 06.f (Prevention of Misuse of Information Assets) | *NIST 800-53*: SA-15, CM-3, IA-5 | *Vanta Evidence*: GitHub organization settings screenshots; environment protection rule configurations; service account inventory and IAM bindings; quarterly access review records.

**HITRUST Evidence Note**: Pipeline access control documentation, quarterly access reviews, and GitHub organization security settings satisfy HITRUST 01.v requirements for information access restriction and 06.f for prevention of misuse. Export organization settings and access review records quarterly for Vanta.

---

### 5.9 Approved Runner and Build Environment Requirements

Build environments (runners) shall be secured, maintained, and monitored to prevent compromise of the build process and the artifacts it produces.

**5.9.1 Approved Runner Types**

MERGE CI/CD pipelines shall execute on one of the following approved runner types:

| Runner Type | Use Case | Security Posture |
| ----------- | -------- | ---------------- |
| GitHub-hosted runners | Standard CI/CD workloads (build, test, scan) | Managed by GitHub; ephemeral; fresh VM per job |
| GCP Cloud Build | GCP-native build and deployment workflows | Managed by Google; runs within MERGE's GCP project |
| MERGE self-hosted runners (if deployed) | Workloads requiring access to private networks or specialized tooling | Managed by MERGE DevSecOps; hardened per this section |

- Unapproved runner types (personal machines, unmanaged VMs, third-party hosted runners) shall not be used for any pipeline workload.

**5.9.2 Ephemeral Build Environments**

- Build environments shall be ephemeral wherever technically feasible. GitHub-hosted runners satisfy this requirement by default (each job runs on a fresh VM that is destroyed after completion).
- If self-hosted runners are deployed, they shall be configured for ephemeral operation (destroyed and recreated after each job) or, at minimum, cleaned of all build artifacts, caches, and credentials between jobs.
- Persistent self-hosted runners that retain state between jobs shall be documented with a risk assessment and approved by the CISO. Additional monitoring and hardening controls shall be applied per Section 5.9.3.

**5.9.3 Self-Hosted Runner Hardening (If Applicable)**

If MERGE deploys self-hosted GitHub Actions runners or persistent Cloud Build workers, the following hardening requirements apply:

- Runners shall be deployed on hardened OS images maintained by DevSecOps, following CIS benchmarks for the applicable operating system.
- Runners shall be patched within the vulnerability remediation SLAs defined in POL-0012 Section 3.4.7 (Critical: 72 hours, High: 14 days).
- Runners shall not have internet egress access beyond what is required for the build process (package registries, artifact registries, GCP APIs). Egress shall be restricted via firewall rules or VPC Service Controls.
- Runners shall not have persistent credentials stored on disk. Credentials shall be injected at runtime via workload identity or short-lived tokens.
- Runner infrastructure shall be monitored by SentinelOne EDR or equivalent endpoint detection and response tooling.
- Runner access logs shall be forwarded to Google SecOps SIEM.

**5.9.4 Build Reproducibility**

- Build pipelines shall use version-pinned tooling (compiler versions, build tool versions, runtime versions) to ensure reproducible builds.
- Build tool versions shall be declared in pipeline configuration files, not inherited from runner defaults that may change without notice.

*HITRUST Mapping*: 10.h (Control of Technical Vulnerabilities), 09.aa (Change Control Procedures) | *NIST 800-53*: SA-15, CM-3, SI-7 | *Vanta Evidence*: Runner configuration documentation; self-hosted runner hardening checklist (if applicable); Cloud Build project IAM and network configurations.

**HITRUST Evidence Note**: Runner and build environment documentation satisfies HITRUST 10.h requirements for controlling technical vulnerabilities in the build infrastructure. Export runner configuration and hardening evidence for the assessor package.

---

### 5.10 Dependency Lock File Enforcement

All repositories shall enforce dependency lock files to ensure deterministic, reproducible builds and prevent silent dependency substitution.

**5.10.1 Lock File Requirement**

- Every repository containing application code with third-party dependencies shall include a committed lock file appropriate to its package ecosystem:

| Language/Ecosystem | Required Lock File |
| ------------------ | ------------------ |
| JavaScript (npm) | `package-lock.json` |
| JavaScript (yarn) | `yarn.lock` |
| JavaScript (pnpm) | `pnpm-lock.yaml` |
| Python (pip) | `requirements.txt` with pinned versions or `Pipfile.lock` |
| Python (poetry) | `poetry.lock` |
| Go | `go.sum` |
| Ruby | `Gemfile.lock` |
| Java (Gradle) | `gradle.lockfile` |
| Terraform | `.terraform.lock.hcl` |

- Repositories without an appropriate lock file shall be flagged as non-compliant and remediated within 30 days.

**5.10.2 Lock File Integrity in Pipelines**

- CI/CD pipelines shall install dependencies using lock file-based installation commands (e.g., `npm ci` instead of `npm install`, `pip install --require-hashes`, `poetry install --no-update`). Commands that bypass or regenerate lock files during CI builds are prohibited.
- Lock file changes shall be reviewed as part of every pull request that modifies dependencies. Reviewers shall verify that lock file changes correspond to intentional dependency modifications and do not include unexpected transitive dependency additions or version changes.
- Pipelines shall fail if a lock file is missing, out of sync with the dependency manifest, or contains unresolvable integrity mismatches.

**5.10.3 Integrity Hash Enforcement**

- Where the package ecosystem supports integrity hashes in lock files (e.g., npm's `integrity` field, pip's `--require-hashes`), hash verification shall be enforced during CI/CD builds.
- Any integrity hash mismatch shall fail the build and be reported to DevSecOps for investigation as a potential supply chain tampering indicator.

*HITRUST Mapping*: 10.b (Technical Vulnerability Management), 09.aa (Change Control Procedures) | *NIST 800-53*: SI-7, CM-3, CM-14 | *Vanta Evidence*: CI/CD pipeline configurations showing lock file enforcement; sample lock file review in PR; pipeline failure logs from missing or mismatched lock files.

**HITRUST Evidence Note**: Lock file enforcement and integrity hash verification satisfy HITRUST 10.b requirements for software integrity controls and NIST CM-14 (Signed Components) requirements for verifiable software composition. Include pipeline configuration demonstrating lock file enforcement in Vanta evidence.

---

### 5.11 AI/ML Pipeline-Specific Controls

Pipelines deploying AI/ML models to Google Vertex AI or other AI infrastructure shall comply with all requirements in this standard, with the following additional controls. These requirements supplement POL-0011 (AI Governance, Security, and Acceptable Use Policy).

**5.11.1 Model Deployment Pipeline Security**

- Model deployment pipelines shall include model validation gates (accuracy thresholds, bias checks, safety guardrail verification) in addition to the security gates defined in Section 5.3.
- Model artifacts (weights, configurations, serving containers) shall be stored in GCP Artifact Registry and subject to the same signing and retention requirements as application artifacts (Section 5.5).
- Changes to production AI models shall be tracked in Jira with the same audit trail requirements as application deployments (Section 5.4.3), per POL-0011.
- Training data pipeline changes shall be treated as security-sensitive changes requiring the additional review specified in Section 5.1.1.

**5.11.2 Model Artifact Integrity**

- AI model artifacts shall be signed and have provenance attestation equivalent to application artifacts (Section 5.5.2).
- Model versioning shall be enforced through artifact registry tagging and Jira change management records.
- Model rollback procedures shall be documented and tested per Section 5.4.4.

*HITRUST Mapping*: 09.ab.05 (AI Model Security) | *NIST 800-53*: SA-15, CM-3, SI-7 | *Vanta Evidence*: AI model deployment pipeline configurations; sample model change tickets from Jira.

**HITRUST Evidence Note**: AI/ML pipeline controls satisfy HITRUST 09.ab.05 requirements for AI model security in the deployment process. Export model deployment pipeline configurations and sample Jira change tickets for AI model changes.

---

## 6. Compliance

Compliance with this standard is assessed through automated enforcement, continuous monitoring, and periodic audits as described in Section 7.

### 6.1 Exception Handling

Exception requests to any requirement in this standard shall be submitted to the Chief of Information Security with the following documentation:

1. **Business justification**: Clear explanation of why the requirement cannot be met and the business impact of non-compliance
2. **Specific requirement(s)**: Identification of the exact section(s) of this standard being waived
3. **Risk analysis**: Assessment of the risk introduced by the exception, including potential attack scenarios and impact on HITRUST certification posture
4. **Compensating controls**: Description of alternative controls that mitigate the risk introduced by the exception
5. **Time-bound duration**: Maximum duration of the exception, not to exceed one (1) year without re-approval
6. **Jira tracking**: Exception request documented in a Jira ticket for tracking and audit purposes

**Exception Scenarios:**

- **Emergency Deployments**: If a critical production incident requires an emergency deployment that cannot follow the full approval process (Section 5.4.1), the deployment may proceed with verbal approval from the CISO or designated on-call approver. The full change ticket and audit trail shall be completed within 24 hours. Emergency deployments shall be reviewed in the next Change Management Board meeting.
- **New Repository Onboarding**: Newly created repositories may operate with partial controls for up to 30 days while full branch protection, CODEOWNERS, lock file, and security gate configurations are implemented. A Jira ticket tracking the onboarding shall be created at repository creation.
- **Third-Party Tool Limitations**: If a third-party CI/CD integration does not support SHA pinning or explicit permission scoping, a documented risk acceptance with compensating controls (e.g., additional review requirements, version monitoring) may be approved by the CISO.
- **Security Gate Tool Outage**: If a security scanning tool is unavailable, merges may proceed with CISO or designee approval and retrospective scanning within 24 hours of tool restoration. The outage and any merges during the outage period shall be documented.

All approved exceptions are logged in Jira, tagged with `security-exception`, and reviewed quarterly by the CISO. Expired exceptions that have not been renewed are automatically escalated.

**HITRUST Evidence Note**: Exception records demonstrate the organization's risk-based approach to control implementation, which HITRUST assessors expect to see. Maintain a current exception register exportable from Jira for assessor review.

---

## 7. Enforcement

Compliance with this standard is mandatory for all personnel and systems within scope. The Information Security team enforces this standard through the following mechanisms:

### 7.1 Automated Enforcement

- Branch protection rules, environment protection rules, and required status checks enforce controls at the platform level, preventing non-compliant actions before they occur.
- Security gate failures block pipeline progression automatically.
- GitHub Advanced Security push protection prevents secrets from being committed.
- GCP Binary Authorization prevents unsigned images from deploying to production.
- Lock file-based install commands in pipelines prevent dependency resolution drift.
- CODEOWNERS rules enforce security review on pipeline and security-sensitive file changes.

### 7.2 Monitoring and Auditing

- GitHub audit logs are streamed to Google SecOps SIEM for continuous monitoring of repository settings changes, branch protection modifications, and deployment events.
- Pipeline security events generate real-time alerts per Section 5.7.3.
- Quarterly audits of pipeline configurations, secret rotation compliance, artifact registry access, lock file compliance, and deployment audit trails are conducted by the Information Security team.
- Vanta continuously monitors control effectiveness for HITRUST-mapped requirements.

### 7.3 Non-Compliance Consequences

Non-compliance with this standard may result in:

- **First occurrence (minor)**: Written notification to the individual and their manager; mandatory review of this standard; remediation within 5 business days.
- **Repeated or significant non-compliance**: Suspension of deployment privileges pending investigation; mandatory retraining; documented performance action.
- **Willful circumvention of security controls**: Immediate suspension of all repository and pipeline access; escalation to HR and management; potential termination depending on severity and intent.
- **Exposure of production secrets or credentials**: Treated as a security incident under the Incident Response Plan regardless of intent.

Non-compliance discovered during HITRUST assessment fieldwork will be escalated to the CISO immediately for remediation before assessment completion.

---

## 8. Review & Change Management

### 8.1 Review Frequency

| Review Type | Frequency | Trigger |
| ----------- | --------- | ------- |
| Annual Full Review | Annually | Full compliance review with CISO approval |
| Quarterly Configuration Audit | Every 90 days | Verify enforcement of controls across repositories and pipelines |
| Ad Hoc Update | As needed | Significant pipeline security incident, new tooling adoption, regulatory change, or HITRUST assessor feedback |

### 8.2 Approval Workflow

**Current Review Status**: DRAFT -- Pending Legal Review and Leadership Approval

**Approval Requirement for HITRUST r2 Evidence**: This standard must be approved before the HITRUST r2 v11.5 incubation period (May 2026) to satisfy 09.aa (Change Control Procedures), 10.b (Technical Vulnerability Management), and 09.i (System Audit Controls) evidence requirements. Upload the approved version to Vanta upon approval.

**Phased Rollout:**

Organizations adopting this standard should implement controls in the following priority order:

| Phase | Controls | Target Completion | Rationale |
| ----- | -------- | ----------------- | --------- |
| **Phase 1 -- Foundations** | Branch protection (5.1.1), no hardcoded secrets (5.2.3), secrets scanning (5.3.3), approved secret storage (5.6.1), lock file enforcement (5.10.1) | Within 30 days of approval | Highest-risk controls; prevents the most common attack vectors |
| **Phase 2 -- Security Gates** | SAST (5.3.1), SCA (5.3.2), IaC scanning (5.3.4), GITHUB_TOKEN scoping (5.2.1), container scanning (5.3.5) | Within 60 days of approval | Automated vulnerability detection before production |
| **Phase 3 -- Deployment Rigor** | Production approval (5.4.1), environment protection (5.4.2), Jira audit trail (5.4.3), rollback procedures (5.4.4), pipeline audit logging (5.7) | Within 90 days of approval | Full change control and audit trail |
| **Phase 4 -- Supply Chain Hardening** | Action SHA pinning (5.2.2), artifact signing (5.5.2), SBOM generation (5.5.3), commit signing (5.1.2), SLSA compliance (5.5.2), runner hardening (5.9), pipeline access controls (5.8) | Within 120 days of approval | Supply chain integrity and mature lifecycle management |

**GitHub Actions Security Configuration Checklist:**

The following settings shall be verified at the GitHub organization level:

- [ ] Default GITHUB_TOKEN permissions set to **read-only**
- [ ] GitHub Actions allowed only for selected actions (actions created by GitHub, verified marketplace creators, and explicitly approved actions)
- [ ] Fork pull request workflows require approval before running
- [ ] Secret scanning enabled organization-wide with push protection
- [ ] Dependabot security updates enabled organization-wide
- [ ] Audit log streaming configured to MERGE's SIEM (Google SecOps)

**GCP Artifact Registry Configuration Checklist:**

- [ ] Artifact Registry repositories created in MERGE's GCP project with appropriate regional configuration
- [ ] IAM bindings scoped to CI/CD service accounts (no `allUsers` or `allAuthenticatedUsers`)
- [ ] Vulnerability scanning enabled on Artifact Registry repositories
- [ ] Lifecycle policies configured per Section 5.5.4 retention requirements
- [ ] Binary Authorization policy configured for production deployments

**Tooling Reference:**

| Control Area | Recommended Tooling | Integration Point |
| ------------ | ------------------- | ----------------- |
| SAST | GitHub CodeQL, Semgrep, or equivalent | GitHub Actions PR check |
| SCA / Dependency Scanning | GitHub Dependabot, Snyk, or equivalent | GitHub Actions PR check + continuous monitoring |
| Secrets Scanning | GitHub Advanced Security Secret Scanning | Push protection + continuous scanning |
| IaC Scanning | tfsec, Checkov, or equivalent | GitHub Actions PR check for Terraform changes |
| Container Scanning | GCP Artifact Registry vulnerability scanning, Trivy, or equivalent | Pre-deployment gate in pipeline |
| SBOM Generation | CycloneDX CLI, Syft, or equivalent | Pipeline build step, output stored in Artifact Registry |
| Artifact Signing | Sigstore cosign, GCP Binary Authorization | Post-build, pre-deployment |
| Lock File Enforcement | Native package manager CI commands (npm ci, poetry install) | Pipeline install step |
| Secret Management | GitHub Actions Secrets, GCP Secret Manager | Pipeline runtime, application runtime |
| Change Management | Jira | Linked to GitHub PRs and deployment records |
| Pipeline Monitoring | Google SecOps SIEM, GitHub audit log streaming | Continuous monitoring and alerting |
| GRC Evidence Collection | Vanta | Quarterly evidence uploads |

**HITRUST Evidence Collection Summary:**

The following artifacts shall be collected and maintained in Vanta for HITRUST assessor review:

| Evidence Artifact | Source | Collection Frequency | HITRUST Control |
| ----------------- | ------ | -------------------- | --------------- |
| Branch protection rule configurations | GitHub | Quarterly snapshot | 09.aa |
| CODEOWNERS files from security-sensitive repos | GitHub | Quarterly snapshot | 09.aa |
| Sample workflow files (SHA pinning, permission scoping) | GitHub | Quarterly snapshot | 09.aa |
| Security gate scan results (SAST, SCA, IaC, container) | CI pipeline | Continuous (automated) | 10.b |
| Pipeline run logs showing blocked merges | GitHub Actions / Cloud Build | Continuous (automated) | 10.b |
| Production deployment approval records | GitHub Environments | Per deployment | 09.aa |
| Jira change tickets linked to production deployments | Jira | Per deployment | 09.aa |
| Artifact signing attestation records | GCP Artifact Registry | Per production build | 10.b, SI-7 |
| SBOM output files per production release | GCP Artifact Registry | Per production release | 10.b |
| Secret rotation compliance reports | GCP Secret Manager / GitHub | Quarterly | 01.v |
| SIEM alert configurations for pipeline events | Google SecOps | Quarterly snapshot | 09.i |
| Quarterly pipeline audit review reports | Information Security | Quarterly | 09.i |
| GitHub organization security settings | GitHub | Quarterly snapshot | 01.v, 06.f |
| Runner configuration and hardening evidence | DevSecOps | Quarterly snapshot | 10.h |
| Lock file enforcement pipeline configuration | GitHub Actions | Quarterly snapshot | 10.b |
| Exception register with CISO approvals | Jira / SecOps | Quarterly | 09.aa |

**HITRUST Phase 1 Evidence Checklist** (complete before Vanta upload):

- [ ] Legal review completed -- date: __________
- [ ] Leadership approval obtained -- date: __________
- [ ] Uploaded to Vanta as HITRUST evidence for controls 09.aa, 10.b, and 09.i
- [ ] Standard communicated to all DevSecOps and development personnel
- [ ] GitHub organization settings verified against GitHub Actions Security Configuration Checklist
- [ ] GCP Artifact Registry settings verified against GCP Artifact Registry Configuration Checklist
- [ ] Pipeline audit logging and SIEM integration verified against Section 5.7
- [ ] Lock file enforcement verified across all repositories
- [ ] SBOM generation verified in production release pipelines
- [ ] Next review date set in Vanta: 2027-02-23

---

## 9. Related Policy

| Document | Relationship |
| -------- | ------------ |
| POL-0012 Secure Software Development Lifecycle Policy | Parent policy; this standard implements its pipeline security requirements |
| POL-0011 AI Governance, Security, and Acceptable Use Policy | Grandparent policy; AI/ML pipeline controls in Section 5.11 implement AI model deployment requirements |
| Information Security Policy | Overarching security policy governing all MERGE security controls |
| Incident Response Plan | Referenced for secret compromise escalation (Section 5.6.4) and pipeline security incidents |
| Third-Party Risk Management Policy | Governs third-party CI/CD integrations and actions |
| Data Classification and Handling Policy | Informs secret classification and handling requirements |
| Access Control Policy | Governs IAM and access management referenced in pipeline access controls |
| STD-0003 Infrastructure as Code Security Standard | Peer standard; IaC scanning requirements in Section 5.3.4 align with STD-0003 |
| PROC-0001 Software Composition and Dependency Management Procedure | SBOM requirements in Section 5.5.3 and SCA requirements in Section 5.3.2 are implemented per PROC-0001 |
| Secure Coding Standards (per language) | SAST gate configurations align with coding standards |
| Change Management Procedure | Deployment approval workflow in Section 5.4 implements the change management procedure |

---

## Revision History

| Version | Date | Author | Change Summary |
| ------- | ---- | ------ | -------------- |
| 1.0 DRAFT | 2026-02-23 | Roze San Nicolas | Initial draft; establishes CI/CD pipeline security controls covering source control security, pipeline configuration hardening, security scanning gates, deployment controls, artifact integrity and SBOM generation, secrets management, pipeline audit logging and monitoring, pipeline access controls, runner/build environment security, and dependency lock file enforcement; aligned to HITRUST CSF v11.5 and NIST 800-53 Rev 5 for r2 and AI2 certification support |

---

## Approval

Approved by: _________________________________ Date: ___________

Title: ________________________________________

Approved by: _________________________________ Date: ___________

Title: ________________________________________

---

*This document is controlled and maintained by MERGE TechOps. Unauthorized alterations are prohibited.*
