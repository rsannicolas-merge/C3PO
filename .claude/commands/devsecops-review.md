# /devsecops-review

Perform comprehensive DevSecOps security review of pipelines, IaC, and dependencies.

## Usage
```
/devsecops-review [scope] [options]
```

## Scopes
- `pipeline` - CI/CD pipeline security
- `iac` - Infrastructure as Code review
- `dependencies` - Dependency security analysis
- `containers` - Container image scanning
- `secrets` - Secrets management review
- `full` - Complete DevSecOps assessment

## Implementation

1. **Pipeline Security**:
   - Review GitHub Actions workflows
   - Check for hardcoded credentials
   - Validate security gates
   - Assess deployment controls

2. **IaC Security** (Terraform/CloudFormation):
   - Scan for misconfigurations
   - Check security group rules
   - Validate IAM policies
   - Review encryption settings

3. **Dependency Analysis**:
   - Scan for known CVEs
   - Check license compliance
   - Generate SBOM
   - Assess supply chain risks

4. **Container Security**:
   - Scan Docker images
   - Check base image vulnerabilities
   - Review Dockerfile practices
   - Validate runtime configs

5. **Secrets Management**:
   - Detect exposed credentials
   - Review secret rotation
   - Check vault integration
   - Validate access controls

## Security Checks

### SAST (Static Analysis)
- Code vulnerability scanning
- Security anti-patterns
- Injection vulnerabilities
- Authentication issues

### SCA (Composition Analysis)
- Third-party vulnerabilities
- License risks
- Outdated packages
- Supply chain threats

### IaC Scanning
- Terraform security
- CloudFormation validation
- Kubernetes manifests
- Docker configurations

## HITRUST Evidence Generation
Maps findings to HITRUST controls:
- SA-3: Secure Development
- SA-11: Developer Security Testing
- CM-3: Configuration Change Control
- RA-5: Vulnerability Scanning

## Integration Tools
- tfsec/Checkov for Terraform
- Trivy for containers
- Gitleaks for secrets
- Dependabot for dependencies
- Snyk for vulnerability scanning

## Output
- Security assessment report
- Vulnerability findings
- Remediation recommendations
- HITRUST control evidence
- Risk scores by category
- Compliance mapping
