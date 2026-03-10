# STD-0002 Container Security Standard

MERGE TechOps Standard

**Document Control**

| Field | Value |
|-------|-------|
| Document Number | STD-0002 |
| Version | 1.0 DRAFT |
| Status | DRAFT -- Pending Legal Review and Leadership Approval |
| Author | Roze San Nicolas |
| Owner | Roze San Nicolas, Chief of Information Security |
| Last Updated | 2026-02-23 |
| Next Review | 2027-02-23 (annual) |
| Document Type | Standard |
| Related Policy | POL-0012 Secure Software Development Lifecycle Policy |
| Related Procedure | [None yet] |
| HITRUST CSF v11.5 Mapping | 09.aa (Change Control Procedures), 10.b (Technical Vulnerability Management), 09.m (Network Controls) |
| NIST 800-53 Rev 5 Mapping | CM-6 (Configuration Settings), CM-2 (Baseline Configuration), SI-7 (Software, Firmware, and Information Integrity), SI-3 (Malicious Code Protection), SC-7 (Boundary Protection) |

---

## 1. Purpose

This standard establishes mandatory security requirements for the build, deployment, operation, and decommissioning of container-based workloads across MERGE's infrastructure. It defines prescriptive, auditable controls for container image construction, vulnerability management, runtime hardening, network segmentation, secrets management, orchestration platform security, and container-specific incident response.

Containers are foundational to MERGE's cloud-native architecture on Google Cloud Platform (GCP), powering workloads across Google Kubernetes Engine (GKE), Cloud Run, and Vertex AI -- including AI/ML inference endpoints, internal microservices, and client-facing applications. Without enforceable container security controls, MERGE faces risk from vulnerable base images, credential leakage in image layers, privilege escalation via misconfigured runtimes, lateral movement through unrestricted container networking, and supply chain compromise through unsigned or tampered images. A single compromised container image in the CI/CD pipeline can propagate to every environment it touches.

This standard directly supports MERGE's HITRUST r2 v11.5 and AI2 certification programs by establishing auditable, enforceable controls over the container supply chain, runtime security posture, and container network architecture. It implements the container security requirements of POL-0012 Secure Software Development Lifecycle Policy and provides the specific technical controls that assessors and auditors expect to see documented, implemented, and evidenced.

**HITRUST Evidence Note**: This standard satisfies HITRUST CSF v11.5 requirement 09.aa for documented change control procedures governing container image builds and deployments, 10.b for technical vulnerability management within the container lifecycle, and 09.m for network controls governing container-to-container communication. Retain this document in Vanta as evidence for all three control specifications.

---

## 2. Scope

### 2.1 Applies To

- All container images built, stored, or deployed by MERGE -- including application containers, AI/ML model-serving containers, infrastructure tooling containers, and CI/CD pipeline containers
- All container orchestration platforms operated by MERGE: Google Kubernetes Engine (GKE), Cloud Run, and Vertex AI custom container deployments
- All container registries: GCP Artifact Registry (primary, organization-controlled) and approved upstream registries used as base image sources (Docker Hub Official Images, Google Container Registry, Google distroless project)
- All Dockerfiles, container build definitions, Kubernetes manifests, Cloud Run service configurations, and Terraform modules that define container infrastructure
- All personnel who build, deploy, configure, or operate containerized workloads -- including full-time employees, contractors, and third-party integrators

### 2.2 Systems Involved

| Workload Type | Platform | Examples |
| ------------- | -------- | -------- |
| Production containers | GKE, Cloud Run | Client-facing services, internal APIs, AI inference endpoints |
| AI/ML containers | Vertex AI, GKE | Model serving containers, training pipelines, data processing jobs |
| CI/CD pipeline containers | GitHub Actions, Cloud Build | Build agents, test runners, deployment tooling |
| Staging / QA containers | GKE (non-prod), Cloud Run (non-prod) | Feature branches, staging environments, QA workloads |
| Infrastructure tooling containers | GKE, Compute Engine | Monitoring agents, log shippers, security scanning tools |

**Environments Covered**

| Environment | Image Scanning | Runtime Enforcement | Deployment Approval |
| ----------- | -------------- | ------------------- | ------------------- |
| Development | Required (advisory) | Pod Security Standards: Baseline (warn) | No manual approval |
| Staging | Required (blocking on Critical/High) | Pod Security Standards: Restricted (warn/audit) | No manual approval |
| Production | Required (blocking on Critical/High) | Pod Security Standards: Restricted (enforce) | Manual approval required |

### 2.3 Exclusions

- Local developer workstation containers used solely for individual development with no production data (governed by Acceptable Use Policy)
- Third-party SaaS platforms that use containers internally but are not managed by MERGE (governed by Third-Party Risk Management Policy)
- Containers operated entirely within vendor-managed infrastructure where MERGE has no configuration authority (governed by Third-Party Risk Management Policy)

**HITRUST Evidence Note**: Scope definition satisfies the assessment boundary requirement for HITRUST CSF v11.5 controls 09.aa, 10.b, and 09.m. This scope should be cross-referenced with the HITRUST r2 system inventory to confirm all container-connected systems are captured.

---

## 3. Roles and Responsibilities

### 3.1 DevSecOps

**DevSecOps Lead**

- Maintain CI/CD pipeline scanning gates and Dockerfile linting
- Manage Approved Base Image Registry and base image currency dashboard
- Implement and maintain Binary Authorization policies and image signing infrastructure
- Review and approve Terraform changes for container infrastructure
- Triage continuous scan alerts

**DevSecOps Engineers**

- Build and maintain secure Dockerfiles and container build pipelines
- Implement multi-stage builds, non-root users, version pinning, health checks, and security contexts per this standard
- Remediate scan findings within SLA
- Maintain Artifact Registry cleanup policies

### 3.2 TechOps / SysOps

- Manage GKE cluster configuration: Shielded Nodes, Private Clusters, node auto-upgrade, Pod Security Standards enforcement, network policies, and namespace isolation
- Maintain Artifact Registry access controls
- Monitor runtime security alerts and Container Threat Detection findings

### 3.3 Engineering

**AI Garage Engineers**

- Build and maintain AI model-serving container images per this standard and POL-0011
- Coordinate with DevSecOps on scanning and deployment requirements
- Track AI container changes via Jira

**Development Team Leads**

- Ensure team compliance with Dockerfile security requirements (Section 5.2) and runtime security configurations (Section 5.6)
- Verify Jira change tickets are linked to container image deployments
- Remediate deprecated base image findings

**All Container Image Authors**

- Follow this standard for all container image builds
- Report vulnerabilities and security concerns to DevSecOps or Information Security
- Do not commit secrets to images or manifests
- Complete container security awareness training

### 3.4 Security Officer

**Chief of Information Security (CISO)**

- Standard ownership and final approval
- Approve exceptions for privileged containers, unresolved Critical/High vulnerabilities, service account key usage, and Binary Authorization break-glass events
- Verify compliance during HITRUST audit preparation
- Coordinate with A-LIGN assessor for container security evidence
- Escalation point for Critical container security incidents

**Security Operations (SecOps)**

- Monitor container runtime logs and threat detection alerts in Google SecOps SIEM
- Investigate container security incidents per Section 5.12
- Conduct quarterly access reviews for Artifact Registry and GKE RBAC
- Collect and upload evidence to Vanta for HITRUST

**HITRUST Evidence Note**: This roles and responsibilities section satisfies HITRUST CSF requirement for documented accountability in configuration management (09.aa) and vulnerability management (10.b). Include this section in the HITRUST evidence package as a supporting artifact.

---

## 4. Definitions

| Term | Definition |
|------|------------|
| **Container** | A lightweight, standalone, executable package of software that includes everything needed to run an application: code, runtime, system tools, libraries, and settings. Containers share the host OS kernel and run in isolated user-space processes. |
| **Docker** | An open-source platform for building, shipping, and running containers. Docker provides the tooling for container image creation and local container runtime. |
| **Dockerfile** | A text file containing instructions for building a Docker container image. Each instruction creates a layer in the resulting image. Also refers to equivalent container build definitions (e.g., Cloud Build YAML). |
| **Base Image** | The foundational container image specified in the `FROM` directive of a Dockerfile. All application layers are built on top of the base image. Base image security directly affects all dependent images. |
| **Image Signing** | The process of cryptographically signing a container image to attest to its integrity and provenance. Signing ensures that an image has not been tampered with between build and deployment. |
| **cosign** | A tool from the Sigstore project for signing and verifying container images using keyless or key-based cryptographic signatures. MERGE's primary image signing tool. |
| **Binary Authorization** | A GCP service that enforces deploy-time security policies for GKE and Cloud Run. It verifies that container images have been signed by trusted authorities (attestors) before allowing deployment. |
| **GKE (Google Kubernetes Engine)** | Google Cloud's managed Kubernetes service for deploying, managing, and scaling containerized applications. MERGE's primary container orchestration platform. |
| **Cloud Run** | Google Cloud's fully managed serverless platform for running containers. Used by MERGE for stateless HTTP services and event-driven workloads. |
| **Artifact Registry** | Google Cloud's universal package and container image repository. MERGE's authoritative registry for storing, scanning, and distributing container images. |
| **Workload Identity** | A GKE feature that allows Kubernetes workloads to authenticate to Google Cloud APIs using IAM service accounts without static credential files, eliminating the need for exported service account keys. |
| **Pod Security Standards** | A Kubernetes-native framework defining three security profiles (Privileged, Baseline, Restricted) enforced via admission controllers to restrict pod configurations based on security requirements. |
| **Network Policy** | A Kubernetes resource that controls network traffic flow between pods and/or external endpoints. Used to implement microsegmentation and default-deny networking within clusters. |
| **Distroless** | A set of minimal container images published by Google that contain only the application and its runtime dependencies -- no shell, no package manager, no unnecessary OS utilities. Preferred for production to minimize attack surface. |

---

## 5. Standard Requirements

### 5.1 Base Image Requirements

All container images deployed to MERGE environments shall be built from approved, verified base images to reduce attack surface, ensure known provenance, and maintain currency against disclosed vulnerabilities.

**5.1.1 Approved Base Image Sources**

Only approved base images shall be used as the `FROM` source in Dockerfiles. Approved sources are:

- **MERGE's GCP Artifact Registry**: Organization-controlled repository containing vetted, scanned, and approved base images (primary source for all builds)
- **Google distroless images**: No shell, no package manager, minimal attack surface -- preferred for production workloads
- **Docker Hub Official Images**: Publisher-verified images only (e.g., `python`, `node`, `golang` official library images)
- **Google-provided base images**: Images provided by Google for Cloud Run, Vertex AI, and GKE-specific workloads

Images from personal repositories, unverified publishers, community-maintained registries, or any source not listed above are prohibited. Any new base image source requires written approval from Information Security and documentation in the Approved Base Image Registry.

*HITRUST Mapping*: 10.b (Technical Vulnerability Management), 09.aa (Change Control Procedures) | *NIST 800-53*: CM-2, CM-6, SI-7

**5.1.2 Base Image Maximum Age**

No container image deployed to a production or staging environment shall be built on a base image older than thirty (30) calendar days from its last published update. Base images shall be refreshed at minimum monthly to incorporate the latest security patches from upstream maintainers.

When a Critical or High severity CVE (CVSS 7.0+) is disclosed affecting a base image in active use, all dependent images shall be rebuilt on the patched base image and redeployed within fifteen (15) calendar days of CVE publication. If no patched base image is available from the upstream maintainer within 15 days, a documented exception with compensating controls shall be filed per Section 6.

*HITRUST Mapping*: 10.b (Technical Vulnerability Management) | *NIST 800-53*: CM-2, SI-3

**5.1.3 Minimal Base Images**

Minimal base images shall be used wherever operationally feasible to reduce attack surface. Preferred options in order of priority:

1. **Google distroless images** -- no shell, no package manager, minimal attack surface (strongly preferred for production)
2. **Alpine-based images** -- minimal footprint with package manager for cases requiring runtime package installation
3. **Slim variants of official images** -- e.g., `python:3.12-slim`, `node:20-slim`

Full-distribution base images (e.g., `ubuntu:latest`, `debian:latest`) require documented business justification and approval by the DevSecOps lead. The justification shall be recorded in the image's repository README and tracked in Jira.

*HITRUST Mapping*: 09.aa (Change Control Procedures) | *NIST 800-53*: CM-6, CM-2

**5.1.4 Base Image Provenance Verification**

Base image provenance shall be verified prior to use in any MERGE build. Verification shall include at least one of the following:

- Image signature verification using cosign or Sigstore
- Image digest pinning (SHA256 digest in the `FROM` directive, not a mutable tag)
- Sourcing exclusively from MERGE-managed Artifact Registry repositories with IAM-enforced access controls

The use of mutable tags (e.g., `latest`, `stable`, `lts`) as the sole image reference in Dockerfiles targeting staging or production environments is prohibited. All `FROM` directives in production Dockerfiles shall reference a specific version tag combined with a SHA256 digest (e.g., `FROM python:3.12.2-slim@sha256:abc123...`).

*HITRUST Mapping*: 10.b (Technical Vulnerability Management) | *NIST 800-53*: SI-7

**5.1.5 Approved Base Image Registry Governance**

No custom base image shall be introduced into the Approved Base Image Registry in Artifact Registry without a security review conducted by Information Security or the DevSecOps lead. The review shall assess:

- Included packages and dependencies
- Known vulnerabilities (scan results)
- Software licensing compatibility
- Maintenance cadence and support status of the upstream source
- Image size and attack surface analysis

Review results shall be documented in a Jira ticket and retained as evidence.

*HITRUST Mapping*: 09.aa (Change Control Procedures), 10.b (Technical Vulnerability Management) | *NIST 800-53*: CM-2, CM-6

**HITRUST Evidence Note**: Requirements 5.1.1 through 5.1.5 satisfy HITRUST CSF 10.b (Technical Vulnerability Management) requirement for documented procedures governing the identification and remediation of technical vulnerabilities in software components. The 30-day base image age requirement and 15-day CVE response timeline provide assessor-ready evidence of vulnerability management cadence. Base image approval process satisfies 09.aa change control requirements. Export Approved Base Image Registry contents and base image refresh logs quarterly for Vanta.

---

### 5.2 Dockerfile Security

All Dockerfiles (or equivalent container build definitions) shall follow secure construction practices to prevent privilege escalation, credential leakage, and unnecessary attack surface in built images.

**5.2.1 No Root User**

Containers shall not run as the root user. Every Dockerfile shall include a `USER` directive specifying a non-root user with a non-zero UID. The non-root user shall be created within the Dockerfile with minimal permissions:

```dockerfile
# Required pattern
RUN addgroup --system appgroup && adduser --system --ingroup appgroup appuser
USER appuser
```

Exceptions require CISO approval documented in the exception log (Section 6) with compensating controls including: read-only root filesystem, dropped Linux capabilities, and a seccomp profile.

*HITRUST Mapping*: 09.aa (Change Control Procedures) | *NIST 800-53*: CM-6, CM-2

**5.2.2 Multi-Stage Builds Required**

Multi-stage builds shall be used for all container images deployed to production environments. Build tooling, compilers, package managers, source code, test dependencies, and development libraries shall be confined to build stages and shall not be present in the final production image.

```dockerfile
# Required pattern -- multi-stage
FROM golang:1.22 AS builder
COPY . .
RUN go build -o /app

FROM gcr.io/distroless/static:nonroot
COPY --from=builder /app /app
USER nonroot
ENTRYPOINT ["/app"]
```

Single-stage builds that include build tooling in the final image are prohibited for production deployments.

*HITRUST Mapping*: 09.aa (Change Control Procedures) | *NIST 800-53*: CM-6

**5.2.3 Minimal Packages**

Only packages and dependencies required for the application to function at runtime shall be included in the final production image. The following are prohibited in final production images:

- Package managers that are not required at runtime (e.g., `apt`, `yum`, `apk` -- use distroless or remove after installation)
- Shell interpreters that are not required at runtime (use distroless images to eliminate by default)
- Debug tools, compilers, or development utilities (`gcc`, `gdb`, `strace`, `curl`, `wget` -- confine to build stages)
- Documentation, man pages, and locale data not required for operation

Dockerfile linting (hadolint or equivalent) shall be configured in the CI/CD pipeline to flag unnecessary packages.

*HITRUST Mapping*: 09.aa (Change Control Procedures) | *NIST 800-53*: CM-6, SI-3

**5.2.4 No Secrets in Build Arguments or Layers**

No secrets, credentials, API keys, tokens, certificates, or private keys shall be embedded in Dockerfiles, build arguments (`ARG`), environment variables (`ENV`), or any image layer. This prohibition applies to:

- `ARG` directives used to pass secrets at build time (secrets passed via `--build-arg` persist in image layer metadata and are recoverable via `docker history`)
- `ENV` directives that set credential values
- `COPY` or `ADD` of files containing secrets (e.g., `.env` files, key files, certificates)
- `RUN` commands that echo, write, or reference plaintext secrets

Secrets required during the build process (e.g., private package registry credentials) shall be injected using Docker BuildKit secret mounts (`--mount=type=secret`) or equivalent mechanisms that do not persist secrets in image layers. Runtime secrets shall be injected via GCP Secret Manager (see Section 5.9).

*HITRUST Mapping*: 09.aa (Change Control Procedures) | *NIST 800-53*: CM-6, SI-7

**5.2.5 COPY Over ADD**

The `COPY` instruction shall be used instead of `ADD` in Dockerfiles. The `ADD` instruction shall not be used unless the specific capability it provides (automatic tar extraction) is explicitly required and documented in a code comment within the Dockerfile. Remote URL fetching via `ADD` is prohibited; use `RUN curl` or `RUN wget` with checksum verification instead.

*HITRUST Mapping*: 09.aa (Change Control Procedures) | *NIST 800-53*: CM-6

**5.2.6 Version Pinning**

All package and dependency versions shall be pinned to specific versions in Dockerfiles. The `latest` tag shall not be used for base images or dependencies. Pinning applies to:

- Base image tags (use digest or specific version, e.g., `python:3.12.2-slim@sha256:...` not `python:latest`)
- OS packages (pin to specific versions where the package manager supports it)
- Application dependencies (lock files: `requirements.txt` with pinned versions, `package-lock.json`, `go.sum`, etc.)

*HITRUST Mapping*: 10.b (Technical Vulnerability Management) | *NIST 800-53*: CM-2, SI-7

**5.2.7 Health Checks**

Health check definitions shall be included for all production containers. Platform-appropriate mechanisms shall be used:

- **GKE**: Readiness probes, liveness probes, and startup probes defined in Kubernetes manifests
- **Cloud Run**: Startup probes and liveness checks configured in the service definition
- **Dockerfiles**: `HEALTHCHECK` directive where platform probes are not available

Health checks shall verify application-level readiness (e.g., HTTP endpoint responding, database connection established), not merely process existence.

*HITRUST Mapping*: 09.aa (Change Control Procedures) | *NIST 800-53*: CM-6

**HITRUST Evidence Note**: Requirements 5.2.1 through 5.2.7 satisfy HITRUST CSF 09.aa (Change Control Procedures) requirement for controlled, documented build procedures. Non-root enforcement, secrets exclusion, multi-stage builds, and minimal packages constitute implementation evidence for least functionality and configuration hardening controls. Include representative Dockerfiles demonstrating compliance in the Vanta evidence package with annotations highlighting the relevant controls.

---

### 5.3 Image Scanning

All container images shall undergo automated vulnerability scanning to identify and remediate known vulnerabilities before deployment and throughout the image lifecycle.

**5.3.1 Automated Scanning in CI/CD Pipeline**

Automated vulnerability scanning shall be executed on every container image build within the CI/CD pipeline (GitHub Actions, Cloud Build, or equivalent). No image shall be pushed to a production or staging registry without completing a vulnerability scan. The scan shall execute after the image build step and before the image push step. Pipeline configurations shall enforce this gate -- the push step shall depend on a successful scan completion.

*HITRUST Mapping*: 10.b (Technical Vulnerability Management) | *NIST 800-53*: SI-7, SI-3

**5.3.2 Block Deployment on Critical and High CVEs**

Critical and High severity vulnerabilities shall block image promotion to production registries. The following remediation SLAs are mandatory:

| Severity | CVSS Score | Pipeline Action | Remediation SLA |
| -------- | ---------- | --------------- | --------------- |
| Critical | 9.0 -- 10.0 | **Block deployment** | 15 calendar days from CVE publication |
| High | 7.0 -- 8.9 | **Block deployment** | 15 calendar days from CVE publication |
| Medium | 4.0 -- 6.9 | Allow deployment with documented risk acceptance | 30 calendar days |
| Low | 0.1 -- 3.9 | Allow deployment; track for remediation | 90 calendar days |

Deployment of images with unresolved Critical or High findings to production requires a documented exception approved by the CISO per Section 6. The exception must include a documented exploitability analysis specific to MERGE's configuration and active monitoring for vendor patch availability.

*HITRUST Mapping*: 10.b (Technical Vulnerability Management) | *NIST 800-53*: SI-3, SI-7

**5.3.3 Scanner Coverage Requirements**

Vulnerability scanning shall be performed using GCP Artifact Registry Container Analysis as the primary scanner, supplemented by one or more of the following for additional coverage: Trivy, Grype, or Snyk Container. The selected tool combination shall scan for:

- OS-level package vulnerabilities (CVE database)
- Application dependency vulnerabilities (language-specific package advisories)
- Known malware signatures
- Dockerfile misconfigurations (when supported by the tool)

Scanner databases shall be updated at least daily to ensure detection of newly disclosed vulnerabilities.

*HITRUST Mapping*: 10.b (Technical Vulnerability Management) | *NIST 800-53*: SI-3, SI-7

**5.3.4 Continuous Scanning**

Continuous scanning shall be enabled for all images stored in production Artifact Registry repositories. When new vulnerabilities are disclosed affecting previously scanned images, alerts shall be generated and routed to the DevSecOps team within 24 hours. Triage and remediation shall follow the SLAs defined in 5.3.2, measured from the date the alert is generated.

*HITRUST Mapping*: 10.b (Technical Vulnerability Management) | *NIST 800-53*: SI-3

**5.3.5 Scan Result Retention**

Vulnerability scan results shall be retained for a minimum of one (1) year. Retention shall include: image identifier (digest), scan date, scanner version and database version, full vulnerability findings, severity ratings, and remediation actions taken. Results shall be stored in a location accessible for HITRUST audit evidence collection (Vanta, GCP logging, or dedicated artifact storage).

*HITRUST Mapping*: 10.b (Technical Vulnerability Management) | *NIST 800-53*: SI-7

**HITRUST Evidence Note**: Requirements 5.3.1 through 5.3.5 satisfy HITRUST CSF 10.b (Technical Vulnerability Management) requirement for automated vulnerability identification, documented remediation timelines, and evidence retention. The remediation SLA table provides assessor-ready evidence of vulnerability management cadence. Continuous scanning satisfies ongoing monitoring requirements. Upload quarterly scan summary reports and sample pipeline logs showing blocking enforcement to Vanta.

---

### 5.4 Image Signing and Verification

All container images deployed to production shall be cryptographically signed and verified at deployment to ensure supply chain integrity and prevent execution of tampered or unauthorized images.

**5.4.1 Image Signing with Cosign / Sigstore**

All container images that pass vulnerability scanning (Section 5.3) shall be signed using cosign (Sigstore project) or an equivalent cryptographic signing mechanism integrated into the CI/CD pipeline. Signing shall occur after the scan gate passes and before the image is pushed to the production registry or promoted from a staging tag.

The signing key or identity shall be managed through:

- Keyless signing via Sigstore Fulcio (preferred -- tied to CI/CD workload identity, no long-lived keys)
- KMS-managed signing keys in GCP Cloud KMS (alternative -- keys stored and rotated in KMS)

Signing key material shall never be stored in source code repositories, CI/CD configuration files, or developer workstations.

*HITRUST Mapping*: 10.b (Technical Vulnerability Management), 09.aa (Change Control Procedures) | *NIST 800-53*: SI-7

**5.4.2 Binary Authorization on GKE**

GCP Binary Authorization shall be enabled and enforced on all production GKE clusters. The Binary Authorization policy shall be configured to:

- **Require attestation**: Only images with a valid attestation (signature) from an authorized attestor may be deployed to production namespaces
- **Deny all unattested images**: The default rule shall deny images that lack attestation
- **Allow-list only MERGE registries**: Only images from MERGE's Artifact Registry shall be permitted; images from external registries shall be blocked at admission
- **Break-glass procedure**: A documented break-glass procedure shall exist for emergency deployments of unattested images, requiring CISO or on-call security lead approval and post-incident documentation within 24 hours

Binary Authorization policies and attestor configurations shall be managed via Terraform (see Section 5.8).

*HITRUST Mapping*: 09.aa (Change Control Procedures), 10.b (Technical Vulnerability Management) | *NIST 800-53*: SI-7, CM-6

**5.4.3 Cloud Run Image Verification**

Cloud Run services in production shall be configured to pull images exclusively from MERGE's Artifact Registry. Cloud Run service configurations shall reference images by digest (SHA256), not mutable tags, to prevent tag-based image substitution attacks.

*HITRUST Mapping*: 10.b (Technical Vulnerability Management) | *NIST 800-53*: SI-7

**HITRUST Evidence Note**: Requirements 5.4.1 through 5.4.3 satisfy HITRUST CSF 10.b requirement for software integrity verification and 09.aa requirement for controlled software distribution. Binary Authorization policy exports and cosign verification logs provide direct evidence of supply chain integrity controls. Export Binary Authorization policy configurations and a sample attestation verification log for the evidence package in Vanta.

---

### 5.5 Artifact Registry Security

MERGE's GCP Artifact Registry is the authoritative source for all container images deployed to MERGE environments. The registry shall be secured to ensure image integrity, access control, and auditability.

**5.5.1 Private Registry Requirement**

All production container images shall be stored in MERGE's GCP Artifact Registry within an organization-controlled GCP project. Production workloads shall not pull images directly from public registries at runtime. Public base images and third-party images shall be mirrored or rebuilt in the organization registry before use in any MERGE environment.

Anonymous pull access is prohibited for all organization-controlled Artifact Registry repositories. All registry access shall be authenticated via GCP IAM.

*HITRUST Mapping*: 09.aa (Change Control Procedures), 09.m (Network Controls) | *NIST 800-53*: CM-2, SC-7

**5.5.2 Vulnerability Scanning Enabled**

GCP Artifact Registry Container Analysis vulnerability scanning shall be enabled on all Artifact Registry repositories that store container images. Scanning shall be configured in automatic mode so that every image pushed to the repository is scanned without requiring manual trigger. Scan results shall be visible in the GCP console and exported to Cloud Logging for SIEM integration.

*HITRUST Mapping*: 10.b (Technical Vulnerability Management) | *NIST 800-53*: SI-3, SI-7

**5.5.3 Registry Access Controls**

Registry access shall be restricted using the principle of least privilege via GCP IAM:

| Access Level | Authorized Principals | IAM Role |
| ------------ | -------------------- | -------- |
| Push (write) | CI/CD service accounts only | `roles/artifactregistry.writer` |
| Pull (read) | GKE node service accounts, Cloud Run service identities, authorized personnel | `roles/artifactregistry.reader` |
| Administration | TechOps / Information Security personnel | `roles/artifactregistry.admin` |
| Vulnerability scan viewing | DevSecOps, Information Security | `roles/artifactregistry.reader` + Container Analysis viewer |

The following are prohibited:

- `allUsers` or `allAuthenticatedUsers` IAM bindings on any Artifact Registry repository
- Human accounts with push (write) access to production repositories (all production pushes shall originate from CI/CD service accounts)
- Service accounts with broader access than their function requires

Registry IAM bindings shall be reviewed quarterly by Information Security.

*HITRUST Mapping*: 09.aa (Change Control Procedures), 09.m (Network Controls) | *NIST 800-53*: CM-6, SC-7

**5.5.4 Registry Audit Logging**

All image push, pull, delete, tag modification, and access control change events shall be logged via GCP Cloud Audit Logs. Audit logs shall be forwarded to Google SecOps SIEM and retained for a minimum of one (1) year. Alerts shall be configured for:

- Image deletion events in production repositories
- IAM policy changes on Artifact Registry resources
- Image pulls from unexpected service accounts or IP ranges
- High-volume pull patterns that may indicate credential compromise

*HITRUST Mapping*: 09.aa (Change Control Procedures) | *NIST 800-53*: SI-7

**HITRUST Evidence Note**: Requirements 5.5.1 through 5.5.4 satisfy HITRUST CSF 09.aa requirement for controlled software repositories and 09.m requirement for network-level access controls on software distribution infrastructure. Export Artifact Registry IAM configurations, Container Analysis scan settings, and audit log samples quarterly for Vanta.

---

### 5.6 Runtime Security

Container runtime environments shall be configured to enforce least privilege, resource isolation, and defense-in-depth to limit the blast radius of compromise and support incident detection.

**5.6.1 Read-Only Root Filesystem**

Read-only root filesystems shall be enabled for all production containers. In Kubernetes, this is enforced via `securityContext.readOnlyRootFilesystem: true` in the pod specification. Containers requiring writable filesystem access shall use explicitly defined `emptyDir` volume mounts or `tmpfs` mounts limited to specific paths (e.g., `/tmp`, `/var/cache`). Justification for writable root filesystem exceptions shall be documented in the workload's deployment manifest and approved by the DevSecOps lead.

*HITRUST Mapping*: 09.aa (Change Control Procedures) | *NIST 800-53*: CM-6

**5.6.2 Resource Limits Required**

CPU and memory resource limits shall be defined for all containers deployed to production and staging environments. Both `requests` and `limits` shall be specified in Kubernetes manifests, Cloud Run service configurations, or equivalent orchestration definitions:

```yaml
resources:
  requests:
    cpu: "100m"
    memory: "128Mi"
  limits:
    cpu: "500m"
    memory: "512Mi"
```

Containers without defined resource limits shall not be deployed to production. Resource limits prevent resource exhaustion attacks and noisy-neighbor conditions that could impact availability of co-located workloads.

*HITRUST Mapping*: 09.aa (Change Control Procedures) | *NIST 800-53*: CM-6

**5.6.3 Security Contexts Required**

All production container pods shall define explicit security contexts. The following settings are mandatory for production workloads:

```yaml
securityContext:
  runAsNonRoot: true
  readOnlyRootFilesystem: true
  allowPrivilegeEscalation: false
  capabilities:
    drop:
      - ALL
```

Additional capabilities shall only be added when explicitly required and documented. The following are prohibited in production without CISO-approved exception:

- `privileged: true`
- `hostNetwork: true`
- `hostPID: true`
- `hostIPC: true`
- Adding `SYS_ADMIN`, `NET_ADMIN`, or `SYS_PTRACE` capabilities without documented justification

*HITRUST Mapping*: 09.aa (Change Control Procedures) | *NIST 800-53*: CM-6, CM-2

**5.6.4 No Privileged Containers**

Privileged containers (containers running with `--privileged` flag, `privileged: true`, or equivalent elevated capabilities) shall not be deployed to production environments. Any exception requires:

- Written CISO approval
- Documented business justification explaining why the workload cannot function without elevated privileges
- Compensating controls (dedicated node pool, enhanced runtime monitoring, network isolation from other workloads)
- Time-bound exception not exceeding six (6) months without re-approval

*HITRUST Mapping*: 09.aa (Change Control Procedures) | *NIST 800-53*: CM-6

**5.6.5 No Dangerous Volume Mounts**

Containers shall not mount the Docker socket (`/var/run/docker.sock`), the Kubernetes API socket, or host filesystem paths (`hostPath` volumes) unless explicitly required and approved by Information Security. These mounts create container escape vectors and shall be treated as privileged access requiring the same exception process as 5.6.4.

*HITRUST Mapping*: 09.aa (Change Control Procedures) | *NIST 800-53*: CM-6, SC-7

**HITRUST Evidence Note**: Requirements 5.6.1 through 5.6.5 satisfy HITRUST CSF 09.aa requirement for configuration hardening controls and provide implementation evidence for least functionality in containerized workloads. Export sample Kubernetes manifests showing security context enforcement, GKE Pod Security Standards configuration, and exception logs for Vanta.

---

### 5.7 Network Policies

Container network traffic shall be restricted to the minimum required for application functionality. Default-open container networking is prohibited in production.

**5.7.1 Default-Deny Network Policies**

Default-deny network policies shall be applied at the namespace level in all production GKE clusters. Both ingress and egress default-deny policies shall be configured:

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: default-deny-all
spec:
  podSelector: {}
  policyTypes:
    - Ingress
    - Egress
```

All allowed communication paths shall be explicitly defined in additional NetworkPolicy resources with documented business justification.

*HITRUST Mapping*: 09.m (Network Controls) | *NIST 800-53*: SC-7

**5.7.2 Explicit Allow Rules**

Allowed ingress and egress network paths shall be defined in Kubernetes NetworkPolicy resources specifying:

- Source and destination pod selectors or namespace selectors
- Allowed ports and protocols
- Documented purpose for each allow rule (in annotations or accompanying documentation)

Network policies shall be version-controlled in the same repository as the application's Kubernetes manifests and subject to the same pull request review process.

*HITRUST Mapping*: 09.m (Network Controls) | *NIST 800-53*: SC-7

**5.7.3 Service Mesh Where Applicable**

For production workloads requiring service-to-service authentication and encrypted inter-service communication, a service mesh (Anthos Service Mesh / Istio or equivalent) shall be deployed with the following controls:

- Mutual TLS (mTLS) enforced for all inter-service traffic within the mesh
- Service-level authorization policies restricting which services may communicate
- Traffic observability and access logging for inter-service calls

Service mesh deployment is mandatory for workloads processing sensitive data (PII, PHI, or data classified as High under MERGE's data classification policy). For other workloads, service mesh deployment is recommended and shall be evaluated on a per-cluster basis.

Unauthenticated service-to-service communication in production is prohibited for sensitive workloads.

*HITRUST Mapping*: 09.m (Network Controls) | *NIST 800-53*: SC-7, CM-6

**5.7.4 Cloud Run Ingress Controls**

Cloud Run services in production shall be configured with ingress restrictions appropriate to their function:

- **Internal-only services**: Set ingress to `internal` or `internal-and-cloud-load-balancing`
- **External-facing services**: Set ingress to `all` only when the service is designed for public access, with Cloud Armor WAF policies applied
- Cloud Run service-to-service authentication via IAM shall be enforced for all internal calls

*HITRUST Mapping*: 09.m (Network Controls) | *NIST 800-53*: SC-7

**HITRUST Evidence Note**: Requirements 5.7.1 through 5.7.4 satisfy HITRUST CSF 09.m (Network Controls) requirement for documented network segmentation and access controls within containerized environments. Export default-deny network policies, explicit allow rules, and service mesh mTLS configurations as audit evidence for Vanta.

---

### 5.8 Container Orchestration Security (GKE and Cloud Run)

Container orchestration platforms shall be configured to enforce security boundaries, maintain current patches, and eliminate static credential exposure.

**5.8.1 Workload Identity**

Workload Identity shall be the required authentication method for all GKE workloads accessing GCP services. GKE pods shall use Workload Identity Federation to assume IAM service account permissions without static credential files.

- Service account key files (JSON key files) are prohibited in production GKE workloads
- Cloud Run services shall use the built-in service account identity
- Any exception for key-based authentication requires CISO approval and a documented migration plan to Workload Identity with a timeline not exceeding 90 days

*HITRUST Mapping*: 09.aa (Change Control Procedures) | *NIST 800-53*: CM-6, SI-7

**5.8.2 Shielded GKE Nodes**

All GKE clusters shall be provisioned with Shielded GKE Nodes enabled. Shielded Nodes provide verifiable node integrity through:

- Secure Boot: Ensures only verified, signed software runs during the boot process
- vTPM (Virtual Trusted Platform Module): Provides a virtual root of trust for node integrity measurement
- Integrity Monitoring: Validates node boot integrity and alerts on changes

Existing clusters without Shielded Nodes shall be migrated to Shielded Node pools within 90 days of this standard's approval. New clusters shall be provisioned with Shielded Nodes from creation.

*HITRUST Mapping*: 10.b (Technical Vulnerability Management) | *NIST 800-53*: SI-7, CM-6

**5.8.3 Private Clusters**

All production GKE clusters shall be configured as Private Clusters with the following settings:

- **Private nodes**: Cluster nodes shall not have external IP addresses. All node egress shall route through Cloud NAT or a defined egress gateway.
- **Private endpoint**: The Kubernetes API server shall be accessible only via private IP address (VPC-internal) or authorized networks. Public endpoint access, if enabled, shall be restricted to authorized CIDR ranges documented and approved by Information Security.
- **Master authorized networks**: Authorized networks shall be configured to restrict which IP ranges can reach the Kubernetes API server. Only MERGE corporate networks, VPN endpoints, and CI/CD service account source ranges shall be authorized.

*HITRUST Mapping*: 09.m (Network Controls) | *NIST 800-53*: SC-7

**5.8.4 Node Auto-Upgrade and Auto-Repair**

Node auto-upgrade shall be enabled for all GKE node pools to ensure security patches are applied to the underlying Kubernetes nodes without manual intervention:

- Maintenance windows shall be configured to minimize production impact (e.g., off-peak hours)
- Surge upgrade settings shall be configured to maintain application availability during upgrades
- Node auto-repair shall be enabled to automatically replace unhealthy nodes

GKE master (control plane) auto-upgrade shall remain enabled (default) and shall not be disabled.

*HITRUST Mapping*: 10.b (Technical Vulnerability Management) | *NIST 800-53*: CM-2, SI-3

**5.8.5 Pod Security Standards Enforcement**

Pod Security Standards shall be enforced on all GKE clusters via admission controllers:

| Environment | Pod Security Standard | Enforcement Mode |
| ----------- | --------------------- | ---------------- |
| Production | Restricted | Enforce (reject non-compliant pods) |
| Staging | Restricted | Warn and audit |
| Development | Baseline | Warn and audit |

The Restricted profile prohibits: privileged containers, host namespace sharing, host path volumes, and containers running as root. Violations in production shall be rejected at admission time.

*HITRUST Mapping*: 09.aa (Change Control Procedures) | *NIST 800-53*: CM-6, CM-2

**5.8.6 Namespace Isolation**

Each application or team shall operate within a dedicated Kubernetes namespace with:

- **Resource quotas**: Preventing resource exhaustion across namespace boundaries
- **Network policies**: Restricting cross-namespace communication to explicitly approved paths (see Section 5.7)
- **RBAC policies**: Limiting namespace access to authorized personnel and service accounts using Kubernetes Role and RoleBinding resources

Cluster-wide RBAC (ClusterRole bindings) shall be limited to platform administrators and shall not be used for application workloads.

*HITRUST Mapping*: 09.m (Network Controls), 09.aa (Change Control Procedures) | *NIST 800-53*: SC-7, CM-6

**HITRUST Evidence Note**: Requirements 5.8.1 through 5.8.6 satisfy HITRUST CSF 09.aa and 09.m requirements for secure configuration and network segmentation of orchestration platforms. Shielded Nodes and Private Clusters provide infrastructure integrity evidence for 10.b. Export GKE cluster configurations (Terraform state or console exports) showing Workload Identity, Shielded Nodes, Private Cluster, node auto-upgrade, and Pod Security Standards settings for Vanta.

---

### 5.9 Secrets Management in Containers

Secrets used by containerized workloads shall be managed through GCP Secret Manager with runtime injection. Static secrets in container configurations are prohibited.

**5.9.1 No Environment Variable Secrets in Manifests**

Secrets shall never be defined as plaintext values in Kubernetes manifests, ConfigMaps, Helm values files, Cloud Run environment variable definitions, Terraform variable files, or source code repositories. The following patterns are explicitly prohibited:

```yaml
# PROHIBITED -- secret as plaintext env var in manifest
env:
  - name: DB_PASSWORD
    value: "my-secret-password"

# PROHIBITED -- secret in ConfigMap
apiVersion: v1
kind: ConfigMap
data:
  api-key: "sk-abc123..."
```

*HITRUST Mapping*: 09.aa (Change Control Procedures) | *NIST 800-53*: CM-6, SI-7

**5.9.2 GCP Secret Manager Required**

All secrets consumed by containerized workloads shall be stored in GCP Secret Manager and injected at runtime using one of the following approved methods:

- **GKE workloads**: Secret Manager CSI driver, init containers that fetch secrets, or sidecar patterns that mount secrets as files
- **Cloud Run services**: Environment variable references pointing to Secret Manager secret versions (e.g., `SECRET_NAME=projects/PROJECT/secrets/NAME/versions/latest`) or volume mounts from Secret Manager
- **Vertex AI custom containers**: Secret Manager references via Workload Identity-authenticated API calls

Kubernetes Secrets (`kind: Secret`) are permitted only as an intermediary when populated by automation from Secret Manager -- not as a primary secret store with manually managed values.

*HITRUST Mapping*: 09.aa (Change Control Procedures) | *NIST 800-53*: CM-6, SI-7

**5.9.3 Secret Rotation Support**

Applications shall be designed to handle secret rotation without downtime where feasible. Specifically:

- Applications shall periodically re-read secrets from their injection source (file mount or API) rather than caching secrets indefinitely at startup
- Secret versions in GCP Secret Manager shall be rotated per the rotation cadence defined in STD-0001 CI/CD Pipeline Security Standard, Section 3.6.3
- Rotation events shall be logged in Cloud Audit Logs

*HITRUST Mapping*: 09.aa (Change Control Procedures) | *NIST 800-53*: CM-6

**HITRUST Evidence Note**: Requirements 5.9.1 through 5.9.3 satisfy HITRUST CSF 09.aa requirement for controlled credential management in containerized environments. Export GCP Secret Manager access logs, sample Kubernetes manifests showing Secret Manager integration (not plaintext secrets), and rotation compliance reports for Vanta.

---

### 5.10 Logging and Monitoring

Container workloads shall generate and forward security-relevant logs to MERGE's centralized SIEM for monitoring, alerting, and incident investigation.

**5.10.1 Container Logs to Cloud Logging**

All production container workloads shall forward stdout/stderr output to Google Cloud Logging. GKE clusters shall be configured with Cloud Logging enabled for system and workload logs. Cloud Run services forward logs to Cloud Logging by default; this shall not be disabled.

Container logs shall include at minimum:

- Container start and stop events
- Application stdout/stderr output
- Health check results (pass/fail)
- Authentication and authorization events (success and failure)
- Error events and unhandled exceptions

Logs shall be structured (JSON format preferred) to enable efficient searching and alerting in the SIEM.

*HITRUST Mapping*: 09.aa (Change Control Procedures) | *NIST 800-53*: CM-6, SI-7

**5.10.2 Runtime Threat Detection**

Runtime threat detection shall be enabled for all production container workloads to identify active threats including container escape attempts, cryptomining, reverse shells, and anomalous process execution.

- **GKE Security Posture**: GKE Security Posture dashboard shall be enabled for vulnerability and configuration scanning of running workloads
- **Container Threat Detection**: GCP Security Command Center Container Threat Detection (or equivalent) shall be enabled to detect runtime threats including:
  - Execution of unexpected binaries
  - Reverse shell connections
  - Cryptocurrency mining processes
  - Privilege escalation attempts
  - Modified system binaries

Alerts from runtime threat detection shall be forwarded to Google SecOps SIEM and triaged by the Security Operations team with the following response SLAs:

| Alert Severity | Initial Triage SLA | Escalation |
| -------------- | ------------------- | ---------- |
| Critical (active exploit) | 15 minutes | Immediate escalation to CISO |
| High (suspicious activity) | 1 hour | SecOps investigation |
| Medium (policy violation) | 4 hours | DevSecOps review |
| Low (informational) | Next business day | Logged for trend analysis |

*HITRUST Mapping*: 10.b (Technical Vulnerability Management), 09.m (Network Controls) | *NIST 800-53*: SI-3, SI-7

**5.10.3 Log Retention**

Container logs shall be retained per the following schedule:

| Log Type | Minimum Retention | Rationale |
| -------- | ----------------- | --------- |
| Security events (auth, access, threat alerts) | 1 year | HITRUST audit trail, incident investigation |
| Application operational logs | 90 days | Troubleshooting, performance analysis |
| Container lifecycle events (start/stop/restart) | 1 year | Compliance, forensics |
| Audit logs (registry, orchestration platform) | 1 year | HITRUST evidence, change control |

*HITRUST Mapping*: 09.aa (Change Control Procedures) | *NIST 800-53*: SI-7

**HITRUST Evidence Note**: Requirements 5.10.1 through 5.10.3 satisfy HITRUST CSF 09.aa audit logging requirements and 10.b monitoring requirements for containerized workloads. Runtime threat detection satisfies SI-3 (Malicious Code Protection) requirements within container environments. Export Cloud Logging configuration, Container Threat Detection alert samples, and log retention policy configurations for Vanta.

---

### 5.11 Image Lifecycle Management

Container images shall be managed throughout their lifecycle from creation through retirement to ensure currency, reduce storage costs, and prevent deployment of deprecated or vulnerable images.

**5.11.1 Image Retention Policies**

Image retention policies shall be configured in GCP Artifact Registry:

| Image Category | Minimum Retention | Maximum Undeployed Retention | Rationale |
| -------------- | ----------------- | ---------------------------- | --------- |
| Production images (currently deployed) | Indefinite (while deployed) | N/A | Rollback capability |
| Production images (previously deployed) | 1 year from last deployment | 1 year | Audit trail, incident investigation |
| Staging / QA images | 90 days from creation | 90 days | Testing reference |
| Development images | 90 days from creation | 90 days | Development reference |
| CI/CD ephemeral images | 30 days from creation | 30 days | Build reproducibility |

Retention policies shall be enforced via GCP Artifact Registry cleanup policies configured in Terraform. Manual image deletion from production repositories requires Information Security approval and audit log documentation.

*HITRUST Mapping*: 09.aa (Change Control Procedures) | *NIST 800-53*: CM-6

**5.11.2 Deprecated Image Removal**

A process shall be established for identifying and removing deprecated images from active use:

- When a base image is deprecated by its upstream maintainer (end-of-life, no longer receiving security patches), all dependent MERGE images shall be migrated to a supported base image within 30 calendar days of the deprecation announcement
- Deprecated images shall be tagged with a `deprecated` label in Artifact Registry and excluded from automated deployment pipelines
- Workloads still running on deprecated base images shall be flagged in the monthly compliance report and escalated to the responsible team lead for remediation
- After migration is complete and the retention period has elapsed, deprecated images shall be deleted from the registry

*HITRUST Mapping*: 10.b (Technical Vulnerability Management) | *NIST 800-53*: CM-2, SI-3

**5.11.3 Base Image Update Cadence**

The Approved Base Image Registry shall be refreshed on the following schedule:

| Update Trigger | Cadence | Responsible Party |
| -------------- | ------- | ----------------- |
| Scheduled refresh (rebuild all approved base images with latest patches) | Monthly (minimum) | DevSecOps |
| Critical/High CVE affecting a base image | Within 15 calendar days of CVE publication | DevSecOps |
| Upstream base image major version release | Evaluate within 30 days; adopt within 90 days if applicable | DevSecOps |
| Upstream base image end-of-life | Migrate within 30 days of deprecation | DevSecOps + Application Teams |

The DevSecOps lead shall maintain a base image currency dashboard (or equivalent tracking mechanism) showing the age and patch status of all approved base images. This dashboard shall be reviewed monthly and reported to the CISO.

*HITRUST Mapping*: 10.b (Technical Vulnerability Management) | *NIST 800-53*: CM-2, SI-3

**HITRUST Evidence Note**: Requirements 5.11.1 through 5.11.3 satisfy HITRUST CSF 10.b requirements for ongoing vulnerability management and software currency. Artifact Registry cleanup policy configurations, base image currency dashboards, and deprecated image migration records provide auditable evidence of lifecycle management controls. Upload quarterly base image currency reports to Vanta.

---

### 5.12 Container-Specific Incident Response

Container security incidents present unique challenges including ephemeral evidence, rapid lateral movement, and container escape risks. MERGE's Incident Response Plan shall be supplemented with the following container-specific procedures.

**5.12.1 Container Incident Classification**

The following container-specific events shall be classified as security incidents and handled per the Incident Response Plan:

| Event | Severity | Initial Response |
| ----- | -------- | ---------------- |
| Container escape detected (breakout to host) | Critical | Isolate node immediately; preserve container and node state; escalate to CISO |
| Cryptominer or reverse shell detected in container | Critical | Kill container; isolate pod/node; investigate image provenance; escalate to CISO |
| Unauthorized image deployed (Binary Authorization bypass) | High | Investigate deployment path; revoke credentials used; audit break-glass usage |
| Privilege escalation within container | High | Kill container; investigate root cause; review security context configuration |
| Secrets exposure in container logs or image layers | High | Rotate compromised secrets immediately; investigate exposure scope |
| Network policy violation (unexpected cross-namespace traffic) | Medium | Investigate traffic source; review and tighten network policies |
| Deployment of image with unpatched Critical CVE | Medium | Assess exploitability; initiate emergency patching or rollback |
| Anomalous container behavior (unexpected process, file modification) | Medium | Investigate via runtime logs; compare against baseline behavior |

*HITRUST Mapping*: 10.b (Technical Vulnerability Management), 09.m (Network Controls) | *NIST 800-53*: SI-3, SI-7

**5.12.2 Evidence Preservation for Container Incidents**

Container environments are ephemeral by design. When a container security incident is detected, the following evidence shall be preserved before remediation actions destroy it:

- Container logs (stdout/stderr) from Cloud Logging for the affected container
- Container runtime state (if possible -- snapshot the pod before termination)
- Kubernetes events for the affected namespace and pod
- Network flow logs for the affected pod/service
- Image manifest and digest of the running container
- Artifact Registry audit logs showing when and how the image was pushed and pulled
- Node-level logs if a container escape is suspected
- GKE audit logs for any API calls related to the affected workload

Evidence shall be collected within the first hour of incident detection and stored in a dedicated, access-restricted GCS bucket for forensic analysis. Evidence retention for security incidents shall be a minimum of two (2) years.

*HITRUST Mapping*: 09.aa (Change Control Procedures), 10.b (Technical Vulnerability Management) | *NIST 800-53*: SI-7

**5.12.3 Container Incident Post-Mortem Requirements**

All container security incidents classified as High or Critical shall include a post-mortem review within five (5) business days of incident closure. The post-mortem shall address:

- Root cause: How did the incident occur? (e.g., image vulnerability, misconfigured security context, missing network policy)
- Detection: How was the incident detected? Was detection timely?
- Response: Were container-specific response procedures adequate?
- Prevention: What changes to this standard, CI/CD pipeline gates, runtime policies, or monitoring are needed to prevent recurrence?
- Standard updates: Are updates to this Container Security Standard required based on lessons learned?

Post-mortem findings that require changes to this standard shall be fast-tracked through the ad hoc update process (Section 8).

*HITRUST Mapping*: 10.b (Technical Vulnerability Management) | *NIST 800-53*: SI-3

**HITRUST Evidence Note**: Requirements 5.12.1 through 5.12.3 satisfy HITRUST CSF requirements for incident response procedures specific to the technical environment. Container incident classification and evidence preservation procedures demonstrate mature incident handling capabilities for HITRUST r2 assessor review. Retain post-mortem reports and evidence preservation records in Vanta.

---

### 5.13 AI and ML Container Security

Container workloads supporting AI and ML systems -- including Vertex AI, Gemini, and custom model-serving containers -- shall meet all requirements of Sections 5.1 through 5.12 and the following additional requirements.

**5.13.1** AI model-serving containers shall not include training data, datasets, or data processing scripts in the production image. Model artifacts (weights, configurations, tokenizers) shall be loaded at runtime from GCS buckets or Vertex AI Model Registry with appropriate IAM access controls via Workload Identity.

**5.13.2** AI inference endpoint containers shall enforce input validation and output sanitization controls to mitigate prompt injection, model evasion, and adversarial input attacks as required by POL-0011 (AI Governance, Security, and Acceptable Use Policy).

**5.13.3** Changes to AI model-serving container images shall be tracked through Jira change management workflows. Container image digests shall be recorded in the change ticket prior to production deployment.

**5.13.4** AI containers shall be subject to the same vulnerability scanning (Section 5.3), runtime security (Section 5.6), and image signing (Section 5.4) requirements as all other production containers. AI workload containers are not exempt from any requirement in this standard.

*HITRUST Mapping*: 09.aa (Change Control Procedures), 10.b (Technical Vulnerability Management) | *NIST 800-53*: CM-6, SI-7

**HITRUST Evidence Note**: Requirements 5.13.1 through 5.13.4 support HITRUST AI2 assessment requirements for AI model security controls governing the deployment environment. Links container security to AI governance under POL-0011.

---

### 5.14 Infrastructure as Code Integration

Container infrastructure provisioned via Terraform shall incorporate the security requirements of this standard as code to ensure consistent, repeatable, and auditable deployments.

**5.14.1** GKE cluster configurations, Cloud Run service definitions, Artifact Registry settings, Binary Authorization policies, and network policy resources shall be managed via Terraform and stored in MERGE's GitHub repositories per STD-0003 Infrastructure as Code Security Standard. Manual configuration of production container infrastructure is prohibited except during approved incident response actions.

**5.14.2** Terraform configurations shall enforce the security requirements of this standard, including: Pod Security Standard settings, Shielded GKE Nodes, Private Cluster configuration, Workload Identity, node auto-upgrade, Artifact Registry access controls and cleanup policies, and Binary Authorization attestor configurations.

**5.14.3** Automated policy checks (Checkov, tfsec, or OPA/Gatekeeper) in the CI/CD pipeline shall validate Terraform configurations for container infrastructure against this standard's requirements before `terraform apply`.

*HITRUST Mapping*: 09.aa (Change Control Procedures) | *NIST 800-53*: CM-2, CM-6

**HITRUST Evidence Note**: IaC-managed container infrastructure provides auditable evidence of configuration change control for HITRUST 09.aa. Terraform state files, plan outputs, and policy check results serve as evidence artifacts.

---

## 6. Compliance

Exception requests to any requirement in this standard shall be submitted to the Chief of Information Security with the following documentation:

1. **Business justification**: Clear explanation of why the requirement cannot be met and the operational impact of non-compliance
2. **Specific requirement(s)**: Identification of the exact section(s) and sub-section(s) of this standard being waived
3. **Risk analysis**: Assessment of the risk introduced by the exception, including potential impact to MERGE's HITRUST r2 and AI2 certification posture
4. **Compensating controls**: Description of alternative controls that mitigate the risk introduced by the exception
5. **Duration**: Time-bound period not exceeding six (6) months without re-approval
6. **Remediation plan**: Steps and timeline to eliminate the need for the exception
7. **Jira tracking**: Exception request documented in a Jira ticket tagged `security-exception` for tracking and audit

### 6.1 Exception Handling

**Common Exception Scenarios**

- **Privileged containers** (Section 5.6.4): Required for specific infrastructure tooling (e.g., container network plugins, storage drivers). Must include dedicated node pool isolation, enhanced runtime monitoring, network isolation from application workloads, and dropped capabilities where possible.
- **Root user containers** (Section 5.2.1): Required by third-party software that cannot run as non-root. Must include read-only root filesystem, all capabilities dropped except those explicitly required, seccomp profile applied, and a documented migration timeline.
- **Critical/High CVE deployment** (Section 5.3.2): Vendor has not released a fix and the vulnerability is not exploitable in MERGE's configuration. Must include documented exploitability analysis, active monitoring for vendor patch availability, and compensating network or runtime controls.
- **Service account keys** (Section 5.8.1): Legacy system that does not yet support Workload Identity. Must include key rotation every 90 days and a documented migration timeline to Workload Identity not exceeding 90 days.
- **Writable root filesystem** (Section 5.6.1): Application architecture requires writable paths beyond what volume mounts can accommodate. Must include enhanced monitoring of filesystem changes and documented path restrictions.

**Emergency Exception Process**

If this standard's requirements conflict with an active security incident response (e.g., deploying an unattested emergency patch via Binary Authorization break-glass), follow the Incident Response Plan. Document the exception within 24 hours of resolution, including: the nature of the emergency, the specific requirements bypassed, the compensating actions taken, and retroactive CISO approval within 48 hours.

All approved exceptions shall be logged in the Container Security Exception Register, reviewed quarterly by the CISO, and uploaded to Vanta as HITRUST audit evidence.

**HITRUST Evidence Note**: Exception handling demonstrates MERGE's risk-based approach to control implementation, which HITRUST assessors expect to see. Maintain a current exception register exportable from Jira for assessor review.

---

## 7. Enforcement

Compliance with this standard is mandatory for all personnel building, deploying, or operating containerized workloads at MERGE. The Information Security team enforces this standard through the following mechanisms.

### 7.1 Automated Enforcement

- CI/CD pipeline gates blocking non-compliant images from production registries based on vulnerability scan results (Section 5.3) and Dockerfile linting (Section 5.2)
- Binary Authorization admission control blocking unsigned or unattested images from production GKE clusters and Cloud Run services (Section 5.4)
- Pod Security Standards admission controllers rejecting non-compliant pods in production namespaces (Section 5.8.5)
- Default-deny network policies blocking unauthorized container-to-container communication (Section 5.7.1)
- Terraform policy checks (Checkov, tfsec) blocking non-compliant container infrastructure configurations before apply (Section 5.14.3)
- GCP organization policy constraints enforcing security baselines at the project level

### 7.2 Monitoring and Auditing

- Container Threat Detection and runtime monitoring provide continuous surveillance of production workloads (Section 5.10.2)
- Quarterly access reviews of Artifact Registry IAM bindings and GKE RBAC configurations (Information Security)
- Monthly Pod Security Standards and network policy compliance audits (TechOps)
- Monthly base image currency review against the 30-day maximum age requirement (DevSecOps)
- Continuous compliance monitoring via Vanta for HITRUST-mapped requirements
- Annual full compliance audit against this standard (Information Security with A-LIGN assessor)

### 7.3 Non-Compliance Consequences

Non-compliance with this standard shall be addressed based on severity and intent:

- **First occurrence (non-critical)**: Written notification to the individual and their manager; mandatory review of the violated requirement; remediation within the SLA defined for the finding severity
- **Repeated non-compliance**: Escalation to team leadership; suspension of production deployment privileges pending mandatory retraining on container security practices; documented performance action
- **Willful circumvention of security controls**: Immediate suspension of production deployment and registry access pending investigation; escalation to HR and management per MERGE personnel policy; potential termination depending on severity and intent
- **Non-compliance resulting in a security incident**: Handled per the Incident Response Plan with additional review by the CISO and mandatory post-mortem
- **Non-compliance impacting HITRUST certification posture**: Immediate escalation to CISO for risk assessment and remediation prioritization before assessment fieldwork

---

## 8. Review and Change Management

### 8.1 Review Frequency

| Review Type | Frequency | Trigger |
| ----------- | --------- | ------- |
| Annual Full Review | Annually | Comprehensive review of all requirements against current container environment, threat landscape, and GCP platform changes |
| Quarterly Configuration Audit | Every 90 days | Verify enforcement of controls across GKE clusters, Cloud Run services, and Artifact Registry |
| Ad Hoc Update | As needed | Significant container security incident, new orchestration platform adoption, GCP feature changes affecting container security, regulatory change, or HITRUST assessor feedback |

### 8.2 Approval Workflow

**Current Review Status**: DRAFT -- Pending Legal Review and Leadership Approval

**Approval Requirement for HITRUST r2 Evidence**: This standard must be approved before the HITRUST r2 v11.5 incubation period (May 2026) to satisfy 09.aa (Change Control Procedures), 10.b (Technical Vulnerability Management), and 09.m (Network Controls) evidence requirements. Upload the approved version to Vanta upon approval.

**HITRUST Phase 1 Evidence Checklist**

Complete before Vanta upload:

- [ ] Legal review completed -- date: __________
- [ ] Leadership approval obtained -- date: __________
- [ ] Uploaded to Vanta as HITRUST evidence for controls 09.aa, 10.b, 09.m
- [ ] Standard communicated to all affected personnel (DevSecOps, TechOps, AI Garage, Development Teams)
- [ ] Acknowledgment recorded from all affected personnel
- [ ] CI/CD pipeline gates verified as operational per Section 5.3
- [ ] Binary Authorization verified as enforcing per Section 5.4.2
- [ ] GKE cluster configurations verified against Section 5.8 requirements
- [ ] Next review date set in Vanta: 2027-02-23

---

## 9. Related Documents

| Document | Relationship |
| -------- | ------------ |
| POL-0012 Secure Software Development Lifecycle Policy | Parent policy; this standard implements its container security requirements |
| POL-0011 AI Governance, Security, and Acceptable Use Policy | AI/ML container controls in Section 5.13 implement AI model deployment security requirements |
| STD-0001 CI/CD Pipeline Security Standard | Sibling standard; container image scanning gates (Section 5.3) execute within pipelines governed by STD-0001; secrets rotation cadence referenced in Section 5.9.3 |
| STD-0003 Infrastructure as Code Security Standard | Sibling standard; Terraform management of container infrastructure (Section 5.14) follows IaC requirements in STD-0003 |
| Incident Response Plan | Referenced for container-specific incident escalation (Section 5.12) and Binary Authorization break-glass events |
| Third-Party Risk Management Policy | Governs third-party container images and vendor-managed container platforms excluded from scope |
| Data Classification and Handling Policy | Informs encryption and service mesh requirements for containers processing sensitive data (Section 5.7.3) |
| Change Management Procedure | Container image deployments to production require change tickets per Section 5.13.3 and STD-0001 Section 3.4 |

---

## Revision History

| Version | Date | Author | Change Summary |
| ------- | ---- | ------ | -------------- |
| 1.0 DRAFT | 2026-02-23 | Roze San Nicolas | Initial draft -- Container Security Standard covering base images, Dockerfile security, image scanning, signing/verification, registry security, runtime hardening, network policies, orchestration security (GKE/Cloud Run), secrets management, logging/monitoring, image lifecycle, and container incident response; aligned to HITRUST CSF v11.5 and NIST 800-53 Rev 5 |

---

## Approval

Approved by: _________________________________ Date: ___________

Title: ________________________________________

Approved by: _________________________________ Date: ___________

Title: ________________________________________

---

*This document is controlled and maintained by MERGE TechOps / Information Security. Unauthorized alterations are prohibited.*
