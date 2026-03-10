# /cpoe-manage

Manage Certificates of Proof of Operational Effectiveness using Corsair integration.

## Usage
```
/cpoe-manage [action] [options]
```

## Actions

### Sign Evidence
```
/cpoe-manage sign --file evidence.json
```
Creates a cryptographically signed CPOE from security evidence.

### Verify CPOE
```
/cpoe-manage verify --file cpoe.jwt
```
Verifies Ed25519 signature and validates claims.

### Drift Detection
```
/cpoe-manage drift --current new.jwt --previous old.jwt
```
Compares CPOEs to detect compliance drift.

### Publish Trust
```
/cpoe-manage publish --domain agency.gov
```
Generates trust.txt for public verification.

## Implementation

1. **Evidence Collection**:
   - Gather security scan results
   - Compile control assessments
   - Format for CPOE generation

2. **Signing Process**:
   - Add provenance metadata
   - Apply Ed25519 signature
   - Generate JWT-VC credential

3. **Verification**:
   - Resolve DID:web identity
   - Verify cryptographic signature
   - Validate control claims

4. **Drift Analysis**:
   - Compare control states
   - Identify regressions
   - Generate drift report

## Integration Points
- Vanta for evidence collection
- GitHub for version control
- SCITT for transparency logging
- trust.txt for discovery

## Output
- Signed CPOE (JWT format)
- Verification reports
- Drift analysis
- Compliance scores