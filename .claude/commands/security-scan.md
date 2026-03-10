# /security-scan

Perform comprehensive security analysis using integrated tools.

## Usage
```
/security-scan [type] [target]
```

## Types
- `logs` - Analyze security logs with Sec-Gemini
- `image` - Scan images for security threats
- `infrastructure` - Scan GCP/Terraform configurations
- `dependencies` - Check for vulnerable dependencies
- `secrets` - Scan for exposed credentials
- `compliance` - Check against security policies

## Implementation

1. **Log Analysis** (via Sec-Gemini):
   - Parse and analyze security logs
   - Identify anomalies and threats
   - Generate threat intelligence reports

2. **Infrastructure Scanning**:
   - Review Terraform configurations
   - Check GCP security settings
   - Identify misconfigurations

3. **Dependency Scanning**:
   - Check for known CVEs
   - License compliance
   - Supply chain risks

4. **Secrets Detection**:
   - Scan code for exposed credentials
   - Check for API keys and tokens
   - Validate secrets management

5. **Compliance Verification**:
   - Check against NIST controls
   - Verify HITRUST requirements
   - Generate compliance evidence

## Output
- Security findings report
- Risk scores
- Remediation recommendations
- Evidence for compliance