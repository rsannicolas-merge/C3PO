# PROC-0001 Software Composition and Dependency Management Procedure

MERGE TechOps Procedure

**Document Control**

| Field | Value |
|-------|-------|
| Document Number | PROC-0001 |
| Version | 1.0 DRAFT |
| Author | Roze San Nicolas |
| Last Updated | 2026-02-23 |
| Document Type | Procedure |
| Related Policy | POL-0012 Secure Software Development Lifecycle Policy |
| Status | DRAFT -- Pending Legal Review and Leadership Approval |
| Owner | Roze San Nicolas, Chief of Information Security |
| Next Review | 2027-02-23 (annual) |

**HITRUST CSF v11.5 Control Mapping**: 10.b (Technical Vulnerability Management), 09.w (Interconnected Business Information Systems), 10.m (Control of Technical Vulnerabilities)

**NIST 800-53 Rev 5 Control Family Mapping**: SI-2 (Flaw Remediation), SR-3 (Supply Chain Controls and Processes), SR-4 (Provenance), RA-5 (Vulnerability Monitoring and Scanning), CM-7 (Least Functionality)

---

## 1. Purpose

This procedure establishes mandatory, auditable requirements for the approval, intake, scanning, versioning, licensing, inventory, maintenance, and retirement of all third-party and open-source software dependencies across MERGE's software repositories, build pipelines, and production systems. It exists to reduce software supply chain risk, enforce timely vulnerability remediation, maintain license compliance, and produce the audit artifacts required by HITRUST CSF v11.5 r2 and NIST 800-53 Rev 5.

Software supply chain compromise is one of the highest-velocity, highest-impact attack vectors affecting federal agencies. A single unvetted dependency can introduce known vulnerabilities, zero-day exploits, malicious code, license liability, or unmaintained components into production. MERGE's technology stack spans multiple ecosystems -- Node.js (npm/yarn), Python (pip), Go, and potentially Java -- each with distinct package management conventions and attack surfaces. This procedure ensures that every dependency entering MERGE's codebase, regardless of ecosystem, is approved, scanned, version-pinned, license-cleared, inventoried, and maintained throughout its lifecycle.

This procedure directly supports MERGE's active HITRUST r2 v11.5 and AI2 certification programs by providing documented evidence of:

- Technical vulnerability management for third-party software components (HITRUST 10.b)
- Supply chain risk controls governing interconnected business information systems (HITRUST 09.w)
- Proactive management of technical vulnerabilities in open-source and vendor-supplied dependencies (HITRUST 10.m)
- Flaw remediation with defined SLAs traceable to CVE severity (NIST SI-2)
- Supply chain provenance and integrity verification (NIST SR-3, SR-4)
- Least functionality enforcement through dependency minimization (NIST CM-7)

This procedure implements the third-party code and open-source governance requirements of Section 3.9 of POL-0012 (Secure Software Development Lifecycle Policy) and shall be read in conjunction with STD-0001 (CI/CD Pipeline Security Standard), which governs the pipeline enforcement mechanisms referenced throughout this document.

**HITRUST Evidence Note**: This procedure satisfies HITRUST CSF v11.5 Control 10.b requirement for a documented technical vulnerability management process covering third-party software components, Control 09.w for managing risks of interconnected information systems and shared dependencies, and Control 10.m for documented controls over technical vulnerabilities in software composition. Retain in Vanta as evidence for all three control specifications.

---

## 2. Scope

### Applies To

- All software repositories hosted in MERGE's GitHub organization
- All production, staging, and development environments on Google Cloud Platform (GCP)
- All AI/ML pipelines and model dependencies deployed via Google Vertex AI / Gemini
- All container images, Infrastructure-as-Code (IaC) modules, and serverless function deployments
- All third-party libraries, frameworks, plugins, SDKs, and runtime dependencies -- both direct and transitive
- All language ecosystems in use at MERGE: Node.js (npm/yarn), Python (pip/poetry), Go (Go Modules), and Java (Maven/Gradle) if adopted
- All MERGE employees, contractors, and vendors who commit code or manage dependencies in MERGE systems

### Systems Involved

| System / Platform | Dependency Types | Risk Context |
| ----------------- | ---------------- | ------------ |
| MERGE production applications (GCP) | Application libraries, runtime frameworks | Direct exposure to clients and data; highest risk tier |
| Google Vertex AI / Gemini pipelines | ML libraries, model dependencies, data processing packages | AI supply chain risk; in scope for HITRUST r2 and AI2 |
| GitHub repositories (all) | Source-level dependencies, build tools, CI/CD plugins | Entry point for all software changes |
| Container images | Base images, OS packages, application layers | Runtime attack surface; transitive dependency risk |
| Terraform / IaC modules | Provider plugins, community modules | Infrastructure-level supply chain risk |
| Google Artifact Registry | Internal packages, vetted mirrors, container images | Private registry; dependency resolution authority |

**Language Ecosystems and Tooling**:

| Ecosystem | Package Manager | Lock File | Registry |
| --------- | --------------- | --------- | -------- |
| Node.js | npm / yarn | `package-lock.json` / `yarn.lock` | registry.npmjs.org / Google Artifact Registry |
| Python | pip / poetry | `Pipfile.lock` / `poetry.lock` / `requirements.txt` (with hashes) | pypi.org / Google Artifact Registry |
| Go | Go Modules | `go.sum` | proxy.golang.org |
| Java (if adopted) | Maven / Gradle | `pom.xml` (with locked versions) / `gradle.lockfile` | Maven Central / Google Artifact Registry |
| Terraform | Terraform CLI | `.terraform.lock.hcl` | registry.terraform.io |

### Exclusions

- SaaS platforms consumed as services with no MERGE-managed dependencies (e.g., Vanta, Jira as end-user tools)
- Personal development tools on local workstations that do not deploy to MERGE environments
- Sandboxed research and evaluation environments with no network access to production systems and no production data

**HITRUST Evidence Note**: Scope boundary documentation, including language ecosystem coverage and system inventory, satisfies HITRUST CSF v11.5 requirement for defined applicability of technical vulnerability management controls under 10.b and 10.m.

---

## 3. Roles and Responsibilities

### 3.1 DevSecOps

| Role | Responsibilities |
| ---- | ---------------- |
| **DevSecOps Team Lead** | SCA tool configuration and maintenance; weekly scan review and triage; SLA compliance tracking and reporting; quarterly Dependency Health Reviews and Reports; automated tooling (Dependabot/Renovate) configuration; private registry administration; SLSA implementation oversight |
| **DevSecOps Engineers** | Daily SCA alert triage; Jira ticket creation for findings; false positive documentation and review; supply chain risk monitoring; SBOM generation pipeline maintenance; dependency inventory updates; zero-day scan execution; transitive dependency override management |

### 3.2 TechOps

| Role | Responsibilities |
| ---- | ---------------- |
| **TechOps / SecOps** | Incident response coordination when supply chain compromise is suspected; forensic use of SBOMs and provenance attestations during investigations; private registry infrastructure maintenance (GCP Artifact Registry) |
| **GRC / Compliance (Vanta)** | HITRUST evidence collection for dependency management controls; SLA compliance dashboard maintenance; quarterly evidence upload verification; assessor coordination during HITRUST fieldwork |
| **Change Management Board** | Approval of major version updates and high-risk dependency changes in production; review of EOL migration plans; emergency change approval for zero-day remediation |

### 3.3 Engineering

| Role | Responsibilities |
| ---- | ---------------- |
| **Software Developers** | Dependency intake checklist completion on all PRs introducing dependencies; license compliance verification; lock file management and review; exact version pinning in production manifests; security patch application within SLA; major version testing in staging; transitive dependency tree review |
| **Code Reviewers** | Verification of intake checklist completeness on dependency PRs; lock file change review; confirmation that SCA and license checks pass before merge approval; review of version pinning compliance |

### 3.4 Security Officer

| Role | Responsibilities |
| ---- | ---------------- |
| **Chief of Information Security (CISO)** | Procedure ownership and approval; final authority on risk acceptance for Critical/High CVEs, EOL exceptions, and prohibited license exceptions; HITRUST evidence coordination; monthly vulnerability posture review; zero-day escalation authority |
| **Legal** | License compliance review for copyleft, non-standard, and "source available" licenses; exception approval for prohibited licenses; guidance on open-source contribution and license obligations |
| **External Auditors (HITRUST / A-LIGN)** | Access to SBOMs, SCA scan reports, remediation records, Dependency Health Reports, provenance attestations, and exception register during assessment fieldwork |

**HITRUST Evidence Note**: Documented roles and responsibilities satisfy HITRUST CSF v11.5 requirement for defined accountability in technical vulnerability management (10.b, 10.m) and supply chain risk controls (09.w).

---

## 4. Definitions

| Term | Definition |
| ---- | ---------- |
| **SCA (Software Composition Analysis)** | Automated tooling that identifies open-source and third-party components in a codebase, detects known vulnerabilities (CVEs), and evaluates license compliance. SCA scanning is the primary technical control for dependency vulnerability management in this procedure. |
| **SBOM (Software Bill of Materials)** | A machine-readable inventory of all software components (direct and transitive dependencies) included in a production release. SBOMs provide supply chain transparency and enable rapid vulnerability impact assessment. Formats: CycloneDX (preferred), SPDX. |
| **CVE (Common Vulnerabilities and Exposures)** | A standardized identifier for publicly disclosed cybersecurity vulnerabilities, maintained by the MITRE Corporation and referenced in the NIST National Vulnerability Database (NVD). CVE severity is scored using the Common Vulnerability Scoring System (CVSS). |
| **Dependency Pinning** | The practice of specifying an exact version number for a software dependency in a project manifest, preventing automatic resolution to newer (and potentially untested or vulnerable) versions. Example: `"lodash": "4.17.21"` rather than `"lodash": "^4.17.0"`. |
| **Lock File** | A file generated by a package manager that records the exact resolved versions and integrity hashes of all direct and transitive dependencies at a point in time. Lock files ensure deterministic, reproducible builds. Examples: `package-lock.json`, `yarn.lock`, `poetry.lock`, `go.sum`, `.terraform.lock.hcl`. |
| **Transitive Dependency** | A dependency that is not directly declared in a project's manifest but is automatically pulled in as a dependency of a direct dependency (i.e., a dependency of a dependency). Transitive dependencies can be deeply nested and represent a significant hidden attack surface. |
| **EOL (End-of-Life)** | The date after which a software component, runtime, or framework no longer receives security patches, bug fixes, or official support from its maintainer or vendor. Running EOL components in production increases vulnerability exposure. |
| **Supply Chain (Software)** | The complete set of components, tools, processes, and actors involved in developing, building, distributing, and deploying software -- including third-party libraries, build systems, package registries, and CI/CD pipelines. Supply chain compromise targets any link in this chain. |
| **SLSA (Supply-chain Levels for Software Artifacts)** | A security framework (pronounced "salsa") that defines increasing levels of supply chain integrity assurance through build provenance, source integrity, and build platform hardening. MERGE targets SLSA Level 2 within 90 days and Level 3 within 12 months. |
| **Private Registry** | An organization-controlled package repository used to host internal packages, vetted dependency mirrors, and approved container images. MERGE uses Google Artifact Registry as its private registry, with scoped namespaces (`@merge/*`) to prevent dependency confusion attacks. |
| **Copyleft License** | A category of open-source licenses (e.g., GPL-3.0, AGPL-3.0) that require derivative works or linked software to be distributed under the same license terms, potentially requiring disclosure of proprietary source code. Copyleft-licensed dependencies are prohibited in MERGE proprietary projects without Legal and CISO approval. |

---

## 5. Procedure Overview

### 5.1 Dependency Approval and Intake

No new third-party or open-source dependency shall be introduced into any MERGE repository or production system without completing the following intake process. This applies to direct dependencies added to manifest files and to transitive dependencies introduced as a side effect of a direct dependency addition.

*HITRUST Mapping*: 10.b, 10.m, 09.w | *NIST 800-53*: SR-3, CM-7, SA-11

#### 5.1.1 Security Review Requirement

Before any new dependency is added to a project, the developer shall:

1. Check the dependency against the NIST National Vulnerability Database (NVD) and the GitHub Advisory Database for known vulnerabilities. Any dependency with an unresolved Critical or High CVE at the time of intake is rejected until the vulnerability is remediated upstream or a documented risk acceptance is approved by the CISO.
2. Verify the dependency's maintenance status: last release date, number of active maintainers, and responsiveness to security issues. Dependencies with no release activity in the past 12 months require CISO approval before adoption with documented justification.
3. Confirm the dependency is published to an organization-approved package registry (see Step 5.8). Direct downloads from personal repositories, unverified mirrors, or unauthenticated sources are prohibited.
4. Evaluate the dependency's transitive dependency tree. Dependencies that pull in an excessive number of transitive dependencies (more than 50 additional packages) or transitive dependencies with known vulnerabilities require additional justification and DevSecOps review.
5. Confirm that the dependency does not duplicate functionality already available in an existing approved dependency or MERGE's internal library. Redundant dependencies increase attack surface and are prohibited without documented justification. This supports NIST CM-7 (Least Functionality) by minimizing unnecessary software components.
6. Document the business justification for the dependency in the pull request description, including: what it does, why an existing internal or already-approved library cannot fulfill the requirement, the expected maintenance burden, and a summary of the security and license review findings.

#### 5.1.2 License Compliance Check

All new dependencies shall be evaluated for license compatibility before adoption:

1. **Prohibited licenses** (shall not be used in proprietary MERGE projects without Legal and CISO approval): GPL-3.0, AGPL-3.0, AGPL-1.0, SSPL, EUPL, or any copyleft license that would require disclosure of MERGE proprietary source code.
2. **Pre-approved licenses** (no additional Legal review required): MIT, Apache-2.0, BSD-2-Clause, BSD-3-Clause, ISC, Unlicense, CC0-1.0, 0BSD, BlueOak-1.0.0.
3. **Requires Legal review before adoption**: Any license not listed above, dual-licensed packages where one license is copyleft, custom or proprietary licenses, and "source available" licenses (e.g., BSL, Elastic License, Commons Clause).
4. License information shall be captured in the Software Bill of Materials (SBOM) for every production release (see Step 5.6).
5. Automated license scanning shall be integrated into the CI/CD pipeline. Pull requests introducing dependencies with prohibited licenses shall be automatically flagged and blocked until Legal review is completed or the dependency is replaced.
6. If a dependency with a prohibited license is determined to be operationally necessary with no viable alternative, the developer shall submit a license exception request to Legal and the CISO documenting: the specific license, scope of use within MERGE's codebase, risk analysis including distribution and disclosure obligations, and proposed isolation or containment strategy. Approved exceptions are logged in the MERGE Exception Register and reviewed quarterly.

#### 5.1.3 Intake Approval Workflow

1. Developer opens a pull request introducing the new dependency.
2. Pull request description must include: dependency name, exact version, license, business justification, confirmation that vulnerability and license checks were completed, and a summary of the transitive dependency impact.
3. The DevSecOps team or a designated code reviewer verifies the intake checklist is complete and all automated checks (SCA, license scan) pass before approving the PR.
4. For dependencies classified as high-risk -- those with elevated privilege requirements, network access, access to sensitive data, or more than 100 transitive dependencies -- the CISO or designee must approve before merge.
5. Intake decisions (approved, rejected, conditionally approved) are recorded in the pull request for audit trail purposes.

**HITRUST Evidence Note**: Intake approval records in GitHub serve as auditable evidence of change control (HITRUST 09.w) and supply chain risk management (HITRUST 10.b, 10.m) for HITRUST r2 assessment. Pull request records with completed intake checklists, license review logs, and approval decisions shall be retained and made available to assessors.

---

### 5.2 Vulnerability Scanning

MERGE shall implement continuous, automated Software Composition Analysis (SCA) scanning to identify known vulnerabilities in all dependencies across all language ecosystems.

*HITRUST Mapping*: 10.b, 10.m | *NIST 800-53*: SI-2, RA-5, CM-7

#### 5.2.1 Scanning Cadence and Triggers

1. **On every pull request**: Automated SCA scanning shall run as a required CI/CD check on every pull request to any MERGE repository. Pull requests with newly introduced Critical or High CVEs shall not be merged without documented remediation or CISO-approved risk acceptance. SCA checks shall be configured as required status checks in GitHub branch protection -- advisory-only mode is not compliant.
2. **On every merge to main**: A full SCA scan shall execute upon merge to the default branch to detect any vulnerabilities introduced through the merge process or newly published advisories affecting existing dependencies.
3. **Scheduled weekly full scan**: A comprehensive SCA scan shall execute weekly (at minimum) across all active repositories. This scan detects newly disclosed CVEs against the current dependency set, even when no code changes have occurred. Results are delivered to the DevSecOps team for triage within 24 hours.
4. **On-demand scanning**: DevSecOps may trigger ad-hoc scans in response to newly published zero-day vulnerabilities, major upstream security advisories, CISA Known Exploited Vulnerabilities (KEV) catalog additions, or incident response activities.

#### 5.2.2 CVE Response SLAs

All identified vulnerabilities shall be remediated according to the following Service Level Agreements, measured from the date and time the vulnerability is first detected in MERGE's scanning tool:

| Severity | CVSS Range | Remediation SLA | Escalation |
| -------- | ---------- | --------------- | ---------- |
| Critical | 9.0 - 10.0 | **24 hours** | CISO notified immediately upon detection; DevSecOps lead mobilized within 1 hour; escalated to leadership if SLA at risk |
| High | 7.0 - 8.9 | **7 calendar days** | DevSecOps lead notified within 24 hours of detection; escalated to CISO if SLA at risk by day 5 |
| Medium | 4.0 - 6.9 | **30 calendar days** | Tracked in DevSecOps sprint backlog; reviewed weekly |
| Low | 0.1 - 3.9 | **90 calendar days** | Tracked in Jira; reviewed quarterly; documented risk acceptance permitted |

**Remediation** means one of:

- Upgrading the dependency to a patched version that resolves the CVE
- Replacing the dependency with a non-vulnerable alternative
- Removing the dependency entirely if no longer required (preferred where feasible -- supports CM-7 Least Functionality)
- Applying a vendor-provided workaround documented in the vulnerability advisory with a time-bound plan to upgrade
- Documented risk acceptance approved by the CISO with compensating controls (for Low and Medium severity only; Critical and High require remediation or compensating control with a firm remediation date)

**SLA clock behavior**:

- The SLA clock starts at the timestamp of the first SCA scan detection, not the CVE publication date.
- If no upstream patch exists, the SLA clock pauses upon documented CISO acknowledgment with compensating controls in place. The clock resumes when a patch becomes available. Maximum pause duration: 30 days for Critical, 60 days for High.
- SLA compliance is tracked in Vanta and reported to the CISO monthly.

#### 5.2.3 Weekly Triage and Review Process

1. DevSecOps shall review all SCA scanning output weekly and triage new findings.
2. Triaged findings are logged as Jira tickets with: severity (CVSS score), affected repository, affected dependency, CVE identifier, fix availability (patch exists / no patch), assigned owner, and SLA deadline.
3. The weekly review shall confirm that all findings within their SLA window are on track for remediation. Findings at risk of SLA breach are escalated to the DevSecOps lead and, for Critical/High, to the CISO.
4. A summary of open findings, remediation progress, SLA compliance rates, and aging analysis is reported to the CISO monthly.

#### 5.2.4 False Positive Management

1. Findings determined to be false positives (vulnerability not exploitable in MERGE's usage context, or the affected code path is not reachable) shall be documented with detailed technical justification and suppressed in the scanning tool.
2. False positive determinations require review and approval by a DevSecOps engineer or the CISO.
3. Suppressed findings are reviewed quarterly to confirm they remain non-applicable, particularly after dependency version changes.
4. Suppression records -- including justification, approver, date, and affected CVE -- are retained as audit evidence and made available to HITRUST assessors.

**HITRUST Evidence Note**: SCA scan reports, Jira remediation tickets with SLA tracking, weekly triage records, and SLA compliance dashboards satisfy HITRUST CSF v11.5 Controls 10.b and 10.m requirements for documented vulnerability identification, tracking, and timely remediation of third-party software components. SLA compliance metrics uploaded to Vanta provide continuous compliance evidence for r2 assessment.

---

### 5.3 Emergency Patching Procedure for Zero-Day CVEs

When a zero-day vulnerability (actively exploited in the wild, or with a published proof-of-concept exploit, or listed on the CISA KEV catalog) is disclosed in a dependency used by MERGE, the following emergency procedure shall be activated immediately, independent of the standard vulnerability scanning cadence.

*HITRUST Mapping*: 10.b, 10.m | *NIST 800-53*: SI-2, RA-5

#### 5.3.1 Detection and Notification

1. Upon detection of a zero-day CVE affecting a MERGE dependency -- whether through SCA scan alert, vendor advisory, CISA KEV update, threat intelligence feed, or manual discovery -- the discovering party shall notify the DevSecOps lead and the CISO within **1 hour** of detection.
2. DevSecOps shall immediately execute an on-demand SCA scan across all repositories to identify every instance of the affected dependency, including transitive dependency paths.
3. A severity assessment shall be completed within **2 hours** of initial notification, documenting: affected systems, exploitability in MERGE's environment, data exposure risk, and whether compensating controls (WAF rules, network segmentation, feature flags) can reduce immediate risk.

#### 5.3.2 Emergency Remediation Timeline

1. If an upstream patch is available: apply the patch across all affected repositories within **24 hours** of detection. Emergency patching follows the expedited change management process -- verbal or written CISO approval is sufficient, with full Jira change ticket documentation completed retroactively within 24 hours of deployment.
2. If no upstream patch is available: implement compensating controls within **4 hours** of detection. Compensating controls may include: WAF rules blocking exploit vectors, network segmentation isolating affected services, feature flags disabling affected code paths, or temporary removal of the affected dependency if feasible. Document the compensating controls in a Jira ticket and set a daily review cadence until a patch is available.
3. For zero-days affecting AI/ML dependencies in Vertex AI pipelines: coordinate with TechOps to assess whether model serving endpoints should be temporarily isolated or scaled down while remediation is in progress.

#### 5.3.3 Post-Incident Review

1. Within **5 business days** of zero-day remediation, conduct a post-incident review documenting: timeline of events, detection method effectiveness, remediation actions taken, SLA compliance, and lessons learned.
2. Update the dependency health assessment for the affected package. If the package has a history of zero-day vulnerabilities or slow security response, escalate to the quarterly Dependency Health Review for potential replacement.
3. Post-incident review findings are shared with the CISO and incorporated into security awareness materials.

**HITRUST Evidence Note**: Zero-day response records -- including notification timestamps, severity assessments, compensating control documentation, and post-incident reviews -- serve as evidence of mature incident-driven vulnerability management for HITRUST 10.b and 10.m. These records demonstrate that MERGE's vulnerability management process is not limited to scheduled scanning but includes reactive capability for emerging threats.

---

### 5.4 Lock File and Version Pinning Requirements

All MERGE projects shall enforce strict dependency version control through lock files and version pinning to prevent supply chain attacks via dependency confusion, version substitution, or silent upstream changes.

*HITRUST Mapping*: 10.b, 10.m | *NIST 800-53*: SR-3, SR-4, CM-7

#### 5.4.1 Lock File Requirements

1. Every repository containing dependencies shall commit the appropriate lock file to version control. Lock files are not optional -- repositories without committed lock files are non-compliant and shall be remediated within **30 calendar days** of identification.
2. Lock file requirements by ecosystem:

| Ecosystem | Required Lock File | Notes |
| --------- | ------------------ | ----- |
| Node.js (npm) | `package-lock.json` | Must be committed; `npm ci` shall be used in CI/CD (not `npm install`) |
| Node.js (yarn) | `yarn.lock` | Must be committed; `yarn install --frozen-lockfile` shall be used in CI/CD |
| Python (pip) | `requirements.txt` with `--require-hashes` or `Pipfile.lock` | Hash verification required for production |
| Python (poetry) | `poetry.lock` | Must be committed; `poetry install --no-update` shall be used in CI/CD |
| Go | `go.sum` | Must be committed; automatically maintained by Go toolchain |
| Java (Maven) | Version-locked `pom.xml` | No version ranges; use `versions-maven-plugin` to verify |
| Java (Gradle) | `gradle.lockfile` | Must be committed; generated via `./gradlew dependencies --write-locks` |
| Terraform | `.terraform.lock.hcl` | Must be committed; contains provider version and hash constraints |

3. Lock files shall be reviewed as part of every pull request that modifies dependencies. Reviewers shall verify that lock file changes correspond to intentional dependency modifications and do not include unexpected transitive dependency additions or removals.
4. CI/CD pipelines shall use lock file-based installation commands (e.g., `npm ci`, `yarn install --frozen-lockfile`, `pip install --require-hashes`, `poetry install --no-update`) to ensure builds are deterministic and match the committed lock file exactly. Installation commands that modify the lock file during CI/CD are prohibited.

#### 5.4.2 Version Pinning Strategy

1. **Production dependencies**: All direct dependencies in production-deployed code shall be pinned to exact versions. Floating version ranges (e.g., `^1.2.3`, `~1.2.3`, `>=1.2.0`, `*`) are prohibited in production dependency manifests.
2. **Development dependencies**: Floating version ranges are permitted in development dependency configurations but shall resolve to pinned versions via lock file before any staging or production build. Development dependencies shall not be installed in production builds.
3. **Container base images**: Production Dockerfiles shall reference base images by digest hash (e.g., `node:20-slim@sha256:abc123...`), not by mutable tags like `latest`, `stable`, or version-only tags. Digest-pinned base images shall be updated through the standard dependency update process (Step 5.5).
4. **Terraform providers and modules**: Terraform provider versions shall be pinned to exact versions in the `.terraform.lock.hcl` file. Community Terraform modules shall be pinned to specific Git tags or commit SHAs, not branch references.
5. **GitHub Actions**: All GitHub Actions used in MERGE CI/CD workflows shall be pinned to specific commit SHAs, not floating tags. This requirement is defined and enforced per STD-0001 (CI/CD Pipeline Security Standard) Section 3.2.1.

#### 5.4.3 Version Pinning Enforcement

1. Automated linting in the CI/CD pipeline shall detect and reject floating version ranges in production dependency manifests. This check shall be a required status check in GitHub branch protection.
2. Repositories found to contain floating version ranges in production configurations shall be remediated within **14 calendar days** of identification.

**HITRUST Evidence Note**: Lock file commit history, version pinning enforcement configurations in CI/CD pipelines, and deterministic build evidence satisfy HITRUST CSF v11.5 Controls 10.b and 10.m for integrity management of third-party components and NIST SR-4 for provenance verification.

---

### 5.5 Dependency Update Cadence

MERGE shall maintain an active, scheduled process for keeping dependencies current to reduce vulnerability exposure and technical debt. Dependency updates are a proactive control, distinct from the reactive vulnerability remediation process in Step 5.2.

*HITRUST Mapping*: 10.b, 10.m | *NIST 800-53*: SI-2, CM-7

#### 5.5.1 Automated Dependency Update Pull Requests

1. Automated dependency update tooling (Dependabot, Renovate, or equivalent) shall be enabled and configured on **all** MERGE GitHub repositories containing production or staging code.
2. Automated update PRs shall be generated on the following schedule:

| Update Type | Cadence | Review Process |
| ----------- | ------- | -------------- |
| Security patches (CVE fix) | Immediately upon advisory publication | Priority review; merged per SLA in Step 5.2.2 |
| Minor and patch version updates | Monthly | Batched PR; standard code review; CI/CD must pass |
| Major version updates | Quarterly review cycle | Individual PR per major update; staging validation required |

3. Automated update PRs shall trigger the full CI/CD test suite, SCA scan, and license compliance check before they are eligible for merge.

#### 5.5.2 Monthly Minor and Patch Updates

1. On a monthly cadence, DevSecOps shall ensure that automated minor and patch update PRs are reviewed, tested, and merged across all active repositories.
2. Monthly updates shall be batched where tooling supports it (e.g., Renovate grouping) to reduce review overhead while maintaining auditability.
3. If a monthly update introduces test failures or regressions, the specific update shall be investigated and either resolved or deferred with a documented Jira ticket tracking the deferral reason and re-evaluation date.

#### 5.5.3 Quarterly Major Version Review

1. On a quarterly cadence, DevSecOps shall conduct a review of all available major version updates across MERGE's dependency portfolio.
2. For each available major version update, the review shall assess: breaking changes documented in the changelog, migration effort estimate, security improvements in the new version, and end-of-life timeline for the current version.
3. Major version updates approved for adoption shall be tested in a staging environment with documented test results before promotion to production. Major version updates shall follow the standard change management process, including Jira ticket creation and Change Management Board review for production deployments.
4. Major version updates deferred during the quarterly review shall include documented justification and a re-evaluation date no later than the next quarterly review.

**HITRUST Evidence Note**: Automated dependency update configuration (Dependabot/Renovate config files), monthly update PR merge history, and quarterly major version review records demonstrate continuous vulnerability management and proactive maintenance required by HITRUST CSF v11.5 Controls 10.b and 10.m.

---

### 5.6 Software Bill of Materials (SBOM) Generation and Maintenance

MERGE shall generate, maintain, and retain a Software Bill of Materials for every production release to provide full transparency into software composition, enable rapid vulnerability response, and satisfy federal supply chain transparency requirements.

*HITRUST Mapping*: 10.b, 09.w | *NIST 800-53*: SR-3, SR-4, CM-7

#### 5.6.1 Generation Requirements

1. An SBOM shall be generated automatically as part of the CI/CD pipeline for every production release. No production deployment shall proceed without a successfully generated SBOM -- SBOM generation failure shall block the deployment pipeline.
2. The SBOM shall capture all direct and transitive dependencies, including: package name, version, license identifier (SPDX format), supplier/publisher, package URL (purl), and cryptographic hash where available.
3. SBOM generation shall cover all dependency types in the build: application libraries, development build tools (recorded separately), OS packages in container images, and IaC module dependencies.

#### 5.6.2 Format Standards

1. SBOMs shall be produced in one of the following machine-readable formats: **CycloneDX** (preferred) or **SPDX**.
2. JSON output format is preferred for tooling integration. XML is acceptable as a secondary format.
3. SBOM schema version shall be kept current with the latest stable release of the chosen format specification. As of this procedure's effective date, CycloneDX v1.5+ or SPDX v2.3+ is required.

#### 5.6.3 Retention and Storage

1. SBOMs shall be stored alongside release artifacts in MERGE's artifact repository (Google Artifact Registry or GitHub Releases).
2. SBOMs shall be retained for a minimum of **3 years** from the date of the associated production release, or longer if required by contractual, regulatory, or federal record-keeping obligations.
3. Historical SBOMs shall remain accessible and searchable for audit, incident response, forensic investigation, and retrospective vulnerability analysis (e.g., "did we have log4j in production in December 2021?").

#### 5.6.4 SBOM Usage

1. SBOMs shall be available to the Information Security team, DevSecOps, TechOps, and authorized auditors (including HITRUST external assessors from A-LIGN) upon request.
2. During incident response involving a newly disclosed vulnerability, SBOMs shall be used to rapidly identify whether the vulnerability affects any current or recent production release. DevSecOps shall be able to query the SBOM inventory and produce a blast radius assessment within **4 hours** of a zero-day disclosure.
3. SBOMs shall be referenced during quarterly Dependency Health Reviews (Step 5.10) to identify end-of-life components, abandoned dependencies, and license compliance drift.
4. SBOMs shall be provided to federal partners, auditors, or regulators upon request as evidence of software supply chain transparency.

**HITRUST Evidence Note**: SBOM generation and retention records satisfy HITRUST CSF v11.5 requirements for software asset identification, supply chain transparency (10.b, 09.w), and configuration documentation. SBOM files serve as direct evidence for HITRUST r2 assessors during fieldwork. CI/CD pipeline configuration showing the mandatory SBOM generation step demonstrates enforcement.

---

### 5.7 Transitive Dependency Management

Transitive dependencies -- packages pulled in automatically as dependencies of direct dependencies -- represent a significant and often invisible attack surface. MERGE shall actively manage transitive dependency risk rather than treating transitive dependencies as an uncontrolled byproduct of direct dependency selection.

*HITRUST Mapping*: 10.b, 10.m, 09.w | *NIST 800-53*: SR-3, SR-4, RA-5

#### 5.7.1 Visibility Requirements

1. All SCA scanning shall cover the full dependency tree, including all transitive dependencies, not just direct dependencies. SCA tooling that scans only direct dependencies is non-compliant.
2. SBOM generation (Step 5.6) shall enumerate all transitive dependencies with the same detail as direct dependencies: name, version, license, supplier, and package URL.
3. Developers adding new direct dependencies shall review the transitive dependency tree introduced by that dependency. The `npm ls`, `pip show`, `go mod graph`, or equivalent commands shall be used to inspect transitive trees before finalizing the pull request.

#### 5.7.2 Transitive Vulnerability Response

1. CVEs in transitive dependencies are subject to the same remediation SLAs as CVEs in direct dependencies (Step 5.2.2). A vulnerability is not less urgent because it is two or three layers deep in the dependency tree.
2. Remediation options for transitive vulnerabilities, in order of preference:
   - Update the direct dependency to a version that pulls in a patched transitive (preferred)
   - Use package manager override or resolution features to force a patched transitive version (e.g., npm `overrides`, yarn `resolutions`, pip constraints files)
   - Replace the direct dependency with an alternative that does not depend on the vulnerable transitive
   - If no remediation path exists, document compensating controls and escalate to the CISO
3. Package manager override/resolution entries shall be documented with: the CVE being addressed, the date applied, the expected resolution (when the direct dependency will incorporate the fix natively), and the owner responsible for removing the override once it is no longer needed.

#### 5.7.3 Transitive Dependency Minimization

1. When selecting between functionally equivalent direct dependencies, developers shall prefer the option with fewer transitive dependencies (supports NIST CM-7 Least Functionality).
2. During quarterly Dependency Health Reviews (Step 5.10), DevSecOps shall identify direct dependencies that introduce disproportionately large transitive dependency trees and evaluate whether lighter alternatives exist.

**HITRUST Evidence Note**: Transitive dependency coverage in SCA scans and SBOMs demonstrates comprehensive vulnerability management scope for HITRUST 10.b and 10.m. Override/resolution documentation with CVE references provides evidence of proactive risk remediation.

---

### 5.8 Private Registry Usage and Configuration

MERGE shall maintain a private package registry to host internal packages, vetted dependency mirrors, and approved container images. The private registry serves as a controlled distribution point that reduces dependency confusion risk and provides a single enforcement point for supply chain security policies.

*HITRUST Mapping*: 10.b, 09.w | *NIST 800-53*: SR-3, SR-4, CM-7

#### 5.8.1 Approved Package Registries

All dependencies shall be sourced exclusively from organization-approved package registries. The following registries are approved:

| Registry | Ecosystem | Usage |
| -------- | --------- | ----- |
| **Google Artifact Registry** (MERGE-managed) | All ecosystems | Internal packages, vetted mirrors, approved container images -- primary private registry |
| **registry.npmjs.org** | Node.js | Public npm packages |
| **pypi.org** | Python | Public Python packages |
| **proxy.golang.org** | Go | Go module proxy |
| **repo1.maven.org** (Maven Central) | Java | Public Java packages (if ecosystem adopted) |
| **registry.terraform.io** | Terraform | Terraform providers and modules |
| **Docker Hub** (official images only) / **Google Container Registry** | Containers | Approved base images only |

Direct download of packages from personal GitHub repositories, SourceForge, personal websites, unauthenticated HTTP sources, or any registry not listed above is prohibited. Requests to add a new approved registry shall be submitted to DevSecOps and the CISO for evaluation and documented approval.

#### 5.8.2 Private Registry Configuration

1. MERGE's Google Artifact Registry shall be configured to host:
   - Internal packages scoped with the `@merge` namespace (e.g., `@merge/auth-sdk`, `@merge/logging-lib`) to prevent dependency confusion attacks
   - Vetted mirrors of critical external packages where enhanced availability or integrity guarantees are required
   - Approved container base images with MERGE-specific hardening applied
2. All MERGE CI/CD pipelines shall be configured to resolve the `@merge` scope from Google Artifact Registry before falling back to public registries. This prevents external registries from serving a malicious package with a MERGE-scoped name (dependency confusion attack).
3. Authentication to Google Artifact Registry shall use GCP Workload Identity Federation for CI/CD pipelines and individual developer credentials (via `gcloud auth`) for local development. Long-lived API keys for registry access are prohibited.
4. Access to publish packages to Google Artifact Registry shall be restricted to authorized CI/CD service accounts and designated DevSecOps personnel. Human publish access requires justification and is reviewed quarterly.

#### 5.8.3 Dependency Confusion Prevention

1. Internal packages shall always use scoped names (`@merge/*`) in npm and equivalent namespace conventions in other ecosystems.
2. CI/CD pipeline package manager configurations shall explicitly specify registry mappings for scoped packages, ensuring internal scopes never resolve against public registries.
3. DevSecOps shall periodically verify that no packages with MERGE-scoped names have been published to public registries by unauthorized parties.
4. If dependency confusion is detected (an internal package name is claimed on a public registry by an unknown party), DevSecOps shall: immediately block resolution of the external package, notify the CISO, file a takedown request with the public registry, and investigate whether any MERGE builds resolved the malicious package.

**HITRUST Evidence Note**: Private registry configuration, scoped namespace enforcement, and dependency confusion prevention controls satisfy HITRUST 09.w (Interconnected Business Information Systems) and 10.b (Technical Vulnerability Management) by demonstrating controlled and authenticated software distribution channels.

---

### 5.9 Dependency Inventory and Tracking

MERGE shall maintain a comprehensive, current inventory of all software dependencies in use across its systems. The dependency inventory is distinct from and complementary to per-release SBOMs (Step 5.6) -- it provides an organization-wide view of dependency usage, ownership, and health across all repositories.

*HITRUST Mapping*: 10.b, 10.m, 09.w | *NIST 800-53*: SR-3, CM-7, RA-5

#### 5.9.1 Inventory Scope and Content

1. The dependency inventory shall include every direct dependency in use across all MERGE repositories, with the following attributes: package name, current version, language ecosystem, license, owning team/repository, risk classification (Critical, High, Medium, Low based on privilege level and data access), and health status (Active, Needs Review, EOL, Abandoned).
2. The inventory shall be maintained in a centralized, queryable format -- either as a Vanta asset, a dedicated inventory spreadsheet, or a database integrated with SCA tooling output.
3. The inventory shall be updated automatically via SCA tooling integration where possible. Manual updates are required within **5 business days** of any new dependency introduction or removal.

#### 5.9.2 Inventory Review and Reporting

1. DevSecOps shall produce a quarterly Dependency Inventory Report summarizing: total dependency count (direct and transitive), new dependencies added, dependencies removed, dependencies with open CVEs, dependencies approaching or past EOL, and license distribution.
2. The quarterly report shall be shared with the CISO and TechOps leadership and retained in Vanta as compliance evidence.
3. Discrepancies between the inventory and actual repository contents discovered during review shall be investigated and corrected within 14 calendar days.

**HITRUST Evidence Note**: The dependency inventory and quarterly reporting satisfy HITRUST CSF v11.5 requirement for asset identification and tracking of software components under Controls 10.b, 10.m, and 09.w. The inventory supports NIST CM-7 by enabling identification of unnecessary components for removal.

---

### 5.10 End-of-Life Component Replacement

MERGE shall proactively identify and mitigate risk from dependencies that are no longer maintained, have reached end-of-life (EOL), or show indicators of abandonment.

*HITRUST Mapping*: 10.b, 10.m | *NIST 800-53*: SI-2, CM-7

#### 5.10.1 Quarterly Dependency Health Review

1. DevSecOps shall conduct a quarterly review of dependency health across all MERGE repositories. The review shall assess:
   - **Last release date**: Dependencies with no release in the past 12 months are flagged for evaluation.
   - **Maintainer activity**: Dependencies where the primary maintainer has ceased activity (no commits, issue responses, or releases in 12 months) are flagged as potentially abandoned.
   - **Security responsiveness**: Dependencies with a history of slow or no response to reported CVEs (median response time exceeding 60 days) are flagged as high-risk.
   - **Community health**: Dependencies with declining contributor counts, unresolved critical issues, or archived/deprecated repositories are flagged.
   - **Runtime/framework EOL status**: Language runtimes (Node.js LTS schedule, Python release cycle, Go release policy) and major frameworks are checked against vendor EOL timelines.
2. The quarterly review shall reference the dependency inventory (Step 5.9) and current SBOMs (Step 5.6) to ensure comprehensive coverage.
3. Findings from the quarterly review are documented in a Dependency Health Report and shared with the CISO, DevSecOps team leads, and relevant development teams.

#### 5.10.2 End-of-Life Dependency Remediation

1. When a dependency is officially declared end-of-life by its maintainer, governing body, or vendor, a migration plan shall be created within **30 calendar days** of the EOL declaration.
2. The migration plan shall include: replacement dependency identification, migration effort estimate (in engineering days), testing plan, target completion date, and rollback strategy.
3. Migration shall be completed within **90 calendar days** of the EOL declaration for dependencies in production systems. Migration plans are tracked as Jira epics and reported in the monthly DevSecOps status report to the CISO.
4. If migration cannot be completed within 90 days due to complexity or resource constraints, a risk acceptance shall be documented and approved by the CISO, including: compensating controls, revised timeline not to exceed 180 days, and a checkpoint review at 90 days.

#### 5.10.3 End-of-Life Runtime Restrictions

1. No new development shall be initiated on runtime versions that have reached end-of-life (e.g., Node.js versions past LTS end date, Python versions past security support end date, EOL Go versions).
2. Existing applications running on EOL runtimes shall be prioritized for migration based on: risk classification, data sensitivity, public exposure, and compliance impact.
3. DevSecOps shall maintain a published list of approved runtime versions (current LTS or supported versions) and update it within **30 days** of new version releases or EOL announcements. The approved runtime list shall be accessible to all development personnel.

#### 5.10.4 Abandoned Dependency Response

1. Dependencies identified as potentially abandoned during the quarterly review shall be evaluated for:
   - Active community forks with ongoing security maintenance
   - Viable replacement libraries with equivalent or superior functionality
   - Feasibility of internalizing the dependency as a MERGE-maintained component (last resort)
2. For abandoned dependencies in production systems, a remediation ticket shall be created within **30 days** of identification with a remediation target aligned to the dependency's risk classification.

**HITRUST Evidence Note**: Quarterly Dependency Health Reports, EOL migration tickets in Jira, risk acceptance records, and the approved runtime version list satisfy HITRUST CSF v11.5 Controls 10.b and 10.m requirements for ongoing technical vulnerability management and lifecycle maintenance of software components. Reports uploaded to Vanta provide continuous assessment evidence.

---

### 5.11 Supply Chain Attestation and Integrity

MERGE shall implement supply chain attestation and integrity controls aligned with the SLSA (Supply-chain Levels for Software Artifacts) framework to establish verifiable provenance for software builds and deployments.

*HITRUST Mapping*: 10.b, 09.w | *NIST 800-53*: SR-3, SR-4

#### 5.11.1 SLSA Framework Goals

MERGE shall progress toward SLSA compliance according to the following roadmap. SLSA levels establish increasing degrees of supply chain integrity assurance.

| SLSA Level | Description | Target Date | Status |
| ---------- | ----------- | ----------- | ------ |
| SLSA Level 1 -- Provenance | Build process produces provenance attestation documenting: source repository, commit hash, build platform, and build timestamp. Provenance is available for audit. | Within 90 days of procedure approval | Target |
| SLSA Level 2 -- Hosted Build | Builds are executed on a hosted, managed build platform (GitHub Actions / Cloud Build) rather than developer workstations. Build provenance is generated by the build platform, not self-attested by the developer. | Within 90 days of procedure approval | Target |
| SLSA Level 3 -- Hardened Build | Build platform provides additional tamper-resistance guarantees. Builds are hermetic (no network access during build except to pre-declared dependencies). Build provenance is signed by the build platform. | Within 12 months of procedure approval | Aspirational |

#### 5.11.2 Build Provenance Requirements

1. All production builds shall generate a provenance attestation that records: source repository URL, commit SHA, branch name, build pipeline identifier, build timestamp, builder identity (CI/CD service account), and a list of input dependencies (from SBOM).
2. Provenance attestations shall be stored alongside build artifacts in Google Artifact Registry and retained for the same duration as the associated SBOM (Step 5.6.3).
3. Provenance attestations shall be generated by the build platform (GitHub Actions, Cloud Build), not by scripts that can be modified by developers. This ensures the attestation is trustworthy even if the source repository is compromised.

#### 5.11.3 Package Integrity Verification

1. Where supported by the package ecosystem, dependency integrity shall be verified using cryptographic checksums or package signatures during installation.
2. Lock files that include integrity hashes (e.g., npm `integrity` field, pip `--require-hashes`, Go module checksums in `go.sum`) shall enforce hash verification during CI/CD installation. Any integrity verification failure shall block the build and be reported to DevSecOps for investigation.
3. Container images deployed to production shall be verified using cosign signatures or GCP Binary Authorization attestations before deployment is permitted. This requirement is enforced per STD-0001 Section 3.5.2.

#### 5.11.4 Artifact Signing

1. Production release artifacts (container images, compiled binaries, packaged applications) shall be cryptographically signed before deployment using Sigstore cosign, GCP Binary Authorization, or an equivalent signing mechanism approved by the CISO.
2. Deployment pipelines shall verify artifact signatures before deploying to production. Unsigned or invalidly signed artifacts shall be rejected.
3. Signing key management shall follow MERGE's encryption and key management standards. Signing keys shall be stored in GCP KMS or equivalent HSM-backed key storage.

**HITRUST Evidence Note**: SLSA-aligned provenance attestations, integrity verification records, and artifact signing evidence satisfy HITRUST 10.b and 09.w supply chain integrity requirements and NIST SR-3 (Supply Chain Controls) and SR-4 (Provenance). Provenance records linking source commit to production deployment provide the end-to-end traceability that HITRUST r2 assessors expect for change control evidence.

---

### 5.12 Exceptions

Exception requests to any requirement in this procedure shall be submitted to the Chief of Information Security with the following documentation:

1. **Business justification**: Clear explanation of why the procedure requirement cannot be met and the business impact of non-compliance.
2. **Specific requirement(s) being waived**: Reference to the exact section and subsection of this procedure.
3. **Risk analysis**: Assessment of the risk introduced by the exception, including potential impact, likelihood, and attack scenarios enabled by the exception.
4. **Compensating controls**: Description of alternative controls that partially mitigate the risk.
5. **Time-bound duration**: Maximum duration of the exception, not to exceed 1 year without re-approval. Shorter durations are preferred and expected.
6. **Jira tracking**: Exception request documented in a Jira ticket with the `security-exception` label for tracking and audit purposes.

#### 5.12.1 Exception Scenarios

- **Remediation SLA Extension**: If a vulnerability cannot be remediated within the SLA due to upstream dependency constraints (no patch available from the maintainer), a documented risk acceptance with compensating controls (e.g., WAF rule, network segmentation, feature flag disabling affected code path, increased monitoring) may extend the SLA by up to 14 additional days for Critical, 30 additional days for High, and 60 additional days for Medium. The CISO must approve. The SLA extension is tracked daily for Critical and weekly for High until resolved.
- **Prohibited License Use**: If a GPL-3.0 or AGPL-licensed dependency is determined to be operationally critical with no viable alternative, Legal and the CISO may approve use with documented: scope limitations (specific repositories and use cases), isolation requirements (no linking with proprietary code where copyleft obligations would trigger), and license compliance obligations. Exception logged and reviewed quarterly.
- **Emergency Dependency Introduction**: During an active security incident or production outage, a dependency may be introduced without the full intake process in Step 5.1, provided: (a) the dependency is sourced from an approved registry (Step 5.8), (b) a vulnerability check is performed, (c) the CISO or DevSecOps lead authorizes the emergency introduction verbally or in writing, and (d) the full intake process is completed retroactively within **5 business days**.
- **EOL Migration Delay**: If an EOL dependency migration requires more than 90 days due to scope or complexity, a risk acceptance with compensating controls and a revised timeline (not to exceed 180 days) shall be approved by the CISO.
- **Lock File Non-Compliance**: For legacy repositories where lock file generation requires significant refactoring, a time-bound exception (not to exceed 90 days) may be granted with a documented remediation plan and Jira epic tracking the migration.

All approved exceptions are logged in the MERGE Exception Register, tracked in Jira with the `security-exception` label, reviewed quarterly by the CISO, and made available to HITRUST assessors as evidence of risk management decision-making.

**HITRUST Evidence Note**: Exception records with documented risk analysis, compensating controls, and CISO approval satisfy HITRUST CSF v11.5 requirements for risk-based decision-making and demonstrate mature risk management practices during r2 assessment. The quarterly review cadence provides evidence of ongoing risk oversight.

---

## 6. Troubleshooting and Error Handling

### 6.1 Common Issues and Resolutions

| Issue | Symptoms | Resolution |
| ----- | -------- | ---------- |
| **SCA scan failure in CI/CD** | Pull request status check shows SCA scan as failed or errored (not a vulnerability finding, but a tool failure) | 1. Check CI/CD logs for SCA tool connectivity issues (registry timeouts, authentication failures). 2. Verify SCA tool API keys/tokens are valid and not expired. 3. Re-run the pipeline. 4. If persistent, escalate to DevSecOps lead to investigate SCA tool health. Do not merge PRs while SCA checks are non-functional. |
| **False positive vulnerability finding** | SCA reports a CVE against a dependency, but the vulnerable code path is not reachable in MERGE's usage or the CVE does not apply to the installed platform/version | 1. Developer documents technical justification explaining why the CVE is not exploitable in MERGE's context. 2. DevSecOps engineer or CISO reviews and approves the false positive determination. 3. Suppress the finding in the SCA tool with the documented justification. 4. Log the suppression record (CVE, justification, approver, date) for audit evidence. 5. Review suppressed findings quarterly per Step 5.2.4. |
| **Dependency upgrade breaks tests or functionality** | Automated update PR (Dependabot/Renovate) introduces test failures or runtime regressions | 1. Do not merge the failing PR. 2. Investigate the root cause: review the dependency changelog for breaking changes. 3. If the upgrade is a security patch (CVE fix), prioritize resolution within SLA timelines. 4. If resolution requires code changes, create a Jira ticket with the CVE reference and assign to the responsible development team. 5. If the upgrade is a non-security update that breaks functionality, defer with a documented Jira ticket and re-evaluate at next monthly review. |
| **Lock file out of sync with manifest** | CI/CD build fails with "lock file is out of sync" or "integrity check failed" errors | 1. Developer runs the appropriate lock file regeneration command locally (e.g., `npm install`, `poetry lock`). 2. Review the regenerated lock file diff to confirm changes are intentional. 3. Commit the updated lock file. 4. If the desync occurred without manifest changes, investigate whether a transitive dependency was silently updated -- this may indicate a supply chain integrity issue requiring DevSecOps review. |
| **License scan flags unknown or non-standard license** | CI/CD license check blocks a PR due to an unrecognized or non-pre-approved license | 1. Identify the specific license from the dependency's repository or package metadata. 2. If the license is on the pre-approved list (Step 5.1.2) but was not recognized by the scanner, update the scanner's license mapping and re-run. 3. If the license requires Legal review, submit to Legal with the dependency details. 4. Do not merge until the license is cleared or the dependency is replaced. |
| **Dependency confusion detection** | A package with a MERGE-scoped name (`@merge/*`) is found on a public registry, or builds resolve an internal package name from a public source | 1. Immediately block resolution of the external package in CI/CD configurations. 2. Notify the CISO and DevSecOps lead. 3. File a takedown request with the public registry. 4. Audit recent builds to determine if any resolved the malicious package. 5. If malicious resolution occurred, treat as a security incident per the Incident Response Plan. |
| **SBOM generation failure blocks deployment** | Production deployment pipeline halts because SBOM generation step failed | 1. Check CI/CD logs for SBOM tool errors (missing dependencies in build context, tool version incompatibility). 2. Verify the SBOM tool is configured for the correct language ecosystem and build output. 3. Re-run the pipeline. 4. If persistent, escalate to DevSecOps. Do not bypass the SBOM generation requirement -- it is a mandatory deployment gate. |

### 6.2 Escalation Path

The following escalation levels apply to critical dependency security issues, including zero-day CVEs, supply chain compromise indicators, and SLA breach risks.

| Level | Trigger | Responder | Response Time | Actions |
| ----- | ------- | --------- | ------------- | ------- |
| **Level 1 -- DevSecOps Triage** | New Critical/High CVE detected in SCA scan; SCA tool failure; lock file integrity failure | DevSecOps Engineer (on-call or assigned) | Within **1 hour** of detection | Triage the finding; confirm exploitability; create Jira ticket; begin remediation or escalate |
| **Level 2 -- DevSecOps Lead** | Critical CVE confirmed exploitable; SLA at risk for any High or Critical finding; dependency confusion detected; SCA tool outage persisting beyond 4 hours | DevSecOps Team Lead | Within **1 hour** of Level 1 escalation | Mobilize remediation resources; coordinate cross-team response; authorize emergency compensating controls; notify CISO if zero-day or supply chain compromise |
| **Level 3 -- CISO** | Zero-day CVE in active exploitation (per Step 5.3); supply chain compromise confirmed or suspected; Critical CVE SLA breach imminent; risk acceptance required for Critical/High CVE | Chief of Information Security (CISO) | **Immediate** notification; response within **1 hour** | Authorize emergency patching and expedited change management; approve compensating controls; authorize verbal change approval for zero-day response; coordinate with TechOps on service isolation; notify leadership if production impact |
| **Level 4 -- Leadership / Incident Response** | Confirmed supply chain compromise with production impact; data exposure from compromised dependency; CISA emergency directive affecting MERGE dependencies | CISO + TechOps Leadership + Incident Response Team | **Immediate** | Activate Incident Response Plan; isolate affected systems; forensic analysis using SBOMs and provenance attestations; external notification if required; post-incident review per Step 5.3.3 |

**Escalation for SLA breaches**:

- **Critical CVE approaching 24-hour SLA**: DevSecOps lead escalates to CISO at the 12-hour mark if remediation is not on track.
- **High CVE approaching 7-day SLA**: DevSecOps lead escalates to CISO at day 5 if remediation is not on track.
- **Medium/Low CVE SLA breaches**: Reported in monthly CISO vulnerability posture report; persistent breaches (same CVE exceeding SLA by more than 50%) escalated to CISO for remediation directive.

---

## 7. Compliance and Security Considerations

Compliance with this procedure is mandatory for all MERGE employees, contractors, and vendors who develop, deploy, or manage software in MERGE environments.

### 7.1 Automated Enforcement

Automated enforcement is the primary compliance mechanism. The following controls are enforced at the platform level and cannot be bypassed without an approved exception:

- **SCA scanning**: Configured as a required CI/CD status check on all repositories. Pull requests cannot be merged if the SCA check fails or is skipped.
- **License compliance scanning**: Configured as a required CI/CD status check. Pull requests introducing dependencies with prohibited licenses are automatically blocked.
- **SBOM generation**: Integrated into the release pipeline as a required step that blocks deployment on failure.
- **Lock file validation**: CI/CD pipelines configured to use deterministic installation commands that fail if the lock file is out of sync with the manifest.
- **Version pinning linting**: Automated checks reject floating version ranges in production dependency manifests.

### 7.2 Monitoring and Reporting

- **Weekly review**: DevSecOps reviews SCA findings and SLA compliance weekly.
- **Monthly reporting**: Vulnerability posture, SLA compliance rates, open findings count, and aging analysis are reported to the CISO monthly.
- **Quarterly audit**: Dependency Health Reviews (Step 5.10) and Dependency Inventory Reviews (Step 5.9) serve as quarterly compliance checks.
- **Continuous monitoring**: Vanta collects and tracks compliance evidence continuously for HITRUST r2 assessment readiness.

### 7.3 Non-Compliance Consequences

1. **Automated block**: Pull requests failing SCA checks, license scans, or missing intake documentation are automatically blocked from merge. This is the primary and preferred enforcement mechanism.
2. **Remediation directive**: Developers with overdue vulnerability remediation tickets receive a remediation directive from the DevSecOps lead with a mandatory response within 2 business days.
3. **Escalation**: Persistent non-compliance (repeated SLA breaches, circumvention of automated checks, or failure to complete intake requirements) is escalated to the CISO and the employee's manager for corrective action.
4. **Access suspension**: Willful circumvention of supply chain security controls, introduction of known-vulnerable dependencies without approval, deliberate tampering with SCA tooling or scan results, or publishing unauthorized packages to the private registry may result in immediate suspension of code commit access pending investigation.
5. **Disciplinary action**: Continued or egregious non-compliance may result in further disciplinary action in accordance with MERGE personnel policies, up to and including termination.

**HITRUST Evidence Note**: Enforcement records -- automated check configurations, escalation logs, SLA compliance reports in Vanta, and corrective action documentation -- demonstrate that technical vulnerability management controls are not merely documented but actively enforced. This distinction is critical for HITRUST r2 validated assessment scoring, where assessors evaluate both policy existence and control operating effectiveness.

---

## 8. Review and Change Management

### 8.1 Review Frequency

| Review Type | Frequency | Trigger |
| ----------- | --------- | ------- |
| Annual Full Review | Annually (next: 2027-02-23) | Full procedure review with CISO approval; alignment check against HITRUST CSF updates and NIST revisions |
| Quarterly Check | Every 90 days | Verify SLA appropriateness, tool effectiveness, dependency health trends, and alignment with HITRUST requirements |
| Ad Hoc Update | As needed | Major supply chain security incident (internal or industry-wide), new regulatory requirement, significant tooling change, CISA directive, or HITRUST assessor feedback |

### 8.2 Approval Workflow

**Current Review Status**: DRAFT -- Pending Legal Review and Leadership Approval

**Approval Requirement for HITRUST r2 Gap Closure**: This procedure must be approved by Legal and TechOps Leadership before the May 2026 incubation period to satisfy HITRUST CSF v11.5 Controls 10.b, 09.w, and 10.m evidence requirements and close the DevSecOps procedure gaps identified in the policy library index.

**HITRUST Phase 1 Evidence Checklist** (complete before Vanta upload):

- [ ] Legal review completed -- date: __________
- [ ] Leadership approval obtained -- date: __________
- [ ] Uploaded to Vanta as HITRUST evidence for Controls 10.b, 09.w, and 10.m
- [ ] CI/CD pipeline configurations updated to enforce SCA scanning, license scanning, SBOM generation, and lock file validation
- [ ] Dependabot / Renovate enabled and configured on all repositories
- [ ] Google Artifact Registry configured with `@merge` scoped packages and access controls
- [ ] CVE response SLA monitoring configured in Vanta (Critical: 24hr, High: 7 days, Medium: 30 days, Low: 90 days)
- [ ] Procedure communicated to DevSecOps, development teams, and all personnel in scope
- [ ] Approved runtime version list published and accessible to development personnel
- [ ] Next review date set in Vanta: 2027-02-23

---

## 9. Related Policies and Standards

| Document | Relationship |
| -------- | ------------ |
| **POL-0012 Secure Software Development Lifecycle Policy** | Parent policy; this procedure implements Section 3.9 (Third-Party Code and Open Source Governance) and Section 3.4 (Security Testing Gates -- SCA requirements) |
| **POL-0011 AI Governance, Security, and Acceptable Use Policy** | AI-specific dependency controls; AI/ML library governance for Vertex AI pipelines |
| **STD-0001 CI/CD Pipeline Security Standard** | Defines pipeline enforcement mechanisms (security gates, artifact signing, SHA pinning) referenced throughout this procedure |
| **STD-0002 Container Security Standard** | Container image dependency scanning, base image governance, and image signing requirements |
| **Incident Response Plan** | Referenced for zero-day CVE escalation (Step 5.3) and supply chain compromise response |
| **Third-Party Risk Management Policy** | Governs vendor-supplied software evaluation and vendor security assessment |
| **Data Classification and Handling Policy** | Informs risk classification of dependencies based on data access level |
| **Configuration Management Policy** | Governs baseline configurations including approved software components |

---

## Revision History

| Version | Date | Author | Change Summary |
| ------- | ---- | ------ | -------------- |
| 1.0 DRAFT | 2026-02-23 | Roze San Nicolas | Initial draft; HITRUST r2 v11.5 alignment (10.b, 09.w, 10.m); NIST 800-53 Rev 5 mapping (SI-2, SR-3, SR-4, RA-5, CM-7); comprehensive dependency lifecycle coverage including approval, scanning, CVE response SLAs, lock file and version pinning, SBOM, transitive dependency management, private registry, EOL replacement, and SLSA supply chain attestation |

---

## Approval

Approved by: _________________________________ Date: ___________

Title: ________________________________________

Approved by: _________________________________ Date: ___________

Title: ________________________________________

---

*This document is controlled and maintained by MERGE TechOps / Information Security. Unauthorized alterations are prohibited.*
