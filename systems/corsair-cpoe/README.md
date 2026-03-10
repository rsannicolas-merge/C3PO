# Corsair CPOE System Documentation
*System Owner: Clinical Operations*
*Technical Owner: Security Engineering*
*Last Updated: 2026-03-09*
*Classification: CRITICAL (Tier 1)*

## Executive Summary

Corsair CPOE (Computerized Provider Order Entry) is a cryptographic compliance verification system that generates and validates verifiable credentials for clinical orders and compliance evidence. The system produces tamper-proof evidence packages (CPOEs as JWT-VCs) that meet HITRUST r2 requirements for audit trail integrity and non-repudiation.

**Business Purpose**: Ensure cryptographic integrity of clinical orders and compliance evidence for federal healthcare requirements.

**Risk Profile**: CRITICAL - Handles clinical decision documentation and compliance proofs required for regulatory audits.

---

## System Architecture

### Core Components

```
┌─────────────────────────────────────────────┐
│            Corsair CPOE System              │
├─────────────────────────────────────────────┤
│                                             │
│  ┌─────────────┐    ┌──────────────┐       │
│  │   Signing   │───▶│   Evidence   │       │
│  │   Engine    │    │  Generation  │       │
│  └─────────────┘    └──────────────┘       │
│         │                   │               │
│         ▼                   ▼               │
│  ┌─────────────┐    ┌──────────────┐       │
│  │  Ed25519    │    │   JWT-VC     │       │
│  │   Keypair   │    │   Creation   │       │
│  └─────────────┘    └──────────────┘       │
│                            │                │
│                            ▼                │
│                    ┌──────────────┐         │
│                    │  Verifiable  │         │
│                    │ Credentials  │         │
│                    └──────────────┘         │
└─────────────────────────────────────────────┘
```

### Technology Stack

- **Cryptography**: Ed25519 digital signatures
- **Standards**: W3C Verifiable Credentials, JWT (RFC 7519)
- **Runtime**: Bun v1.3.9+, Node.js compatible
- **CLI**: @grcorsair/cli v0.6.0
- **Storage**: Local filesystem for keys, cloud for CPOEs

---

## Security Controls

### Authentication & Access

| Control | Implementation | Evidence |
|---------|---------------|----------|
| Multi-factor Authentication | Required for key operations | IAM logs |
| Role-based Access | Clinical staff + Security admins only | RBAC config |
| Key Management | Hardware security module (HSM) planned | Key generation logs |

### Data Protection

| Control | Implementation | Evidence |
|---------|---------------|----------|
| Encryption at Rest | AES-256 for stored evidence | Encryption configs |
| Encryption in Transit | TLS 1.3 minimum | Network configs |
| Digital Signatures | Ed25519 for all CPOEs | Signature logs |
| Tamper Detection | JWT-VC integrity verification | Audit trail |

### Compliance Mappings

| Framework | Controls | Status |
|-----------|----------|--------|
| HITRUST r2 v11.5 | 01.a, 06.d, 09.ab | ⏳ Implementing |
| NIST 800-53 | AU-10, SI-7 | ⏳ Implementing |
| FISMA | Integrity controls | ⏳ Implementing |

---

## Operations

### Key Management Procedures

1. **Key Generation**
   ```bash
   corsair init --algorithm ed25519
   ```
   - Generates keypair in `keys/` directory
   - Private key MUST be protected (never commit)
   - Public key distributed for verification

2. **Key Rotation**
   - Quarterly rotation required
   - Grace period: 30 days for transition
   - Old keys archived in HSM

### Evidence Generation Workflow

1. **Create Evidence**
   ```bash
   # Collect clinical/compliance data
   echo '{"control":"01.a","status":"pass"}' > evidence.json
   ```

2. **Sign Evidence**
   ```bash
   corsair sign --file evidence.json --format hitrust
   ```

3. **Verify CPOE**
   ```bash
   corsair verify --file evidence.cpoe.jwt
   ```

### Monitoring & Alerting

| Metric | Threshold | Alert Channel |
|--------|-----------|---------------|
| Signing failures | > 5/hour | PagerDuty |
| Verification errors | > 10/day | Slack #security |
| Key access attempts | Any unauthorized | SOC immediate |
| System availability | < 99.9% | Exec escalation |

---

## Incident Response

### Runbook: Key Compromise

1. **Immediate Actions**
   - Revoke compromised key
   - Generate new keypair
   - Alert SOC and clinical ops

2. **Investigation**
   - Review access logs
   - Identify affected CPOEs
   - Document timeline

3. **Remediation**
   - Re-sign critical evidence
   - Update trust.txt
   - Notify auditors if needed

### Runbook: System Unavailable

1. **Failover**
   - Switch to backup signing service
   - Enable manual approval workflow

2. **Root Cause**
   - Check Bun runtime health
   - Verify key accessibility
   - Review error logs

---

## Integration Points

### Upstream Systems
- Clinical Order Management System
- Electronic Health Records (EHR)
- Compliance scanning tools

### Downstream Systems
- HITRUST myCSF portal
- Vanta GRC platform
- Audit evidence repository

### APIs & Interfaces

```javascript
// Example integration
const corsair = require('@grcorsair/sdk');

// Sign clinical order
const cpoe = await corsair.sign({
  evidence: orderData,
  format: 'clinical',
  mapping: 'hitrust-r2'
});

// Verify received CPOE
const valid = await corsair.verify(cpoe);
```

---

## Disaster Recovery

### RTO/RPO Targets
- **RTO**: 4 hours (manual workaround available)
- **RPO**: 1 hour (evidence can be re-signed)

### Backup Strategy
- **Keys**: HSM + encrypted cloud backup
- **CPOEs**: Immutable S3 with versioning
- **Configs**: Git repository

### DR Testing
- Quarterly key recovery drill
- Semi-annual full system failover
- Annual third-party DR audit

---

## Maintenance

### Patching Schedule
- **Security patches**: Within 24 hours
- **Minor updates**: Weekly maintenance window
- **Major upgrades**: Quarterly with testing

### Dependencies
```json
{
  "@grcorsair/cli": "^0.6.0",
  "bun": "^1.3.9",
  "jsonwebtoken": "^9.0.0"
}
```

### Health Checks
```bash
# Daily automated checks
corsair health --verbose
corsair verify --self-test
```

---

## Compliance Evidence

### HITRUST r2 Requirements

| Requirement | Evidence Location | Status |
|-------------|-------------------|--------|
| 01.a - Access Control | `/evidence/access-logs/` | ⏳ Setup |
| 06.d - Audit Logging | `/evidence/audit-trail/` | ⏳ Setup |
| 09.ab - Transmission Security | Network configs | ⏳ Setup |

### Audit Trail
- All signing operations logged
- Verification attempts tracked
- Key access monitored
- Immutable audit log in SIEM

---

## Known Issues & Gaps

### Critical Gaps
1. **No SLA monitoring** - Manual availability tracking
2. **Stateless operations** - No persistent cert/TPRM tracking
3. **Missing HSM integration** - Keys on filesystem

### Remediation Plan
| Gap | Solution | Target Date |
|-----|----------|-------------|
| SLA monitoring | Deploy Prometheus metrics | 2026-03-15 |
| State persistence | Implement database backend | 2026-04-01 |
| HSM integration | GCP Cloud KMS integration | 2026-04-15 |

---

## Contacts

| Role | Name | Contact | Escalation |
|------|------|---------|------------|
| System Owner | Clinical Ops Lead | [TBD] | Primary |
| Technical Lead | Security Engineering | security@agency | Secondary |
| Vendor Support | GRCorsair Team | support@grcorsair | External |
| Executive Sponsor | CISO | roze.sannicolas@ | Final |

---

## Appendix

### A. Configuration Files

**trust.txt** (/.well-known/trust.txt)
```
did: did:web:agency.gov
cpoes: https://agency.gov/evidence/cpoes/
scitt: https://agency.gov/api/scitt
catalog: https://agency.gov/evidence/catalog.json
flagship: https://agency.gov/evidence/security-posture.json
```

### B. Evidence Schema

```json
{
  "$schema": "https://hitrust.org/schema/r2/v11.5",
  "control": "string",
  "status": "pass|fail|partial",
  "evidence": {
    "type": "clinical|compliance|audit",
    "timestamp": "ISO8601",
    "hash": "sha256"
  }
}
```

### C. Monitoring Queries

```sql
-- Failed verifications
SELECT * FROM corsair_logs
WHERE operation='verify' AND status='failed'
AND timestamp > NOW() - INTERVAL '24 hours';

-- Key access audit
SELECT user, action, key_id, timestamp
FROM key_access_logs
WHERE action IN ('read', 'use', 'rotate')
ORDER BY timestamp DESC;
```

---

*This document satisfies HITRUST r2 v11.5 documentation requirements for critical systems.*