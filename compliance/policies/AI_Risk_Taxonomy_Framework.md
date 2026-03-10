# AI Risk Taxonomy Framework
## MERGE Agency - HITRUST AI2 Implementation

**Version**: 1.0
**Effective Date**: 2026-03-04
**Classification**: Internal Use
**Owner**: Chief Information Security Officer (CISO)
**Review Cycle**: Quarterly

---

## 1. Executive Summary

This AI Risk Taxonomy Framework establishes a systematic approach for identifying, classifying, and managing AI-related risks across MERGE Agency systems. Aligned with HITRUST AI2 requirements and the MITRE ATLAS framework, this taxonomy enables consistent risk assessment and mitigation strategies for all AI systems.

## 2. AI Risk Categories

### 2.1 Primary Risk Domains

#### **DOMAIN A: Model Security Risks**
Threats targeting the AI model itself, its training data, or inference processes.

| Risk Code | Risk Name | Description | MITRE ATLAS Mapping |
|-----------|-----------|-------------|---------------------|
| MS-001 | Model Poisoning | Malicious data injection during training | AML.T0020 |
| MS-002 | Model Extraction | Unauthorized replication of model behavior | AML.T0024 |
| MS-003 | Adversarial Inputs | Crafted inputs causing misclassification | AML.T0043 |
| MS-004 | Model Inversion | Extracting training data from model | AML.T0025 |
| MS-005 | Backdoor Attacks | Hidden malicious behavior in models | AML.T0021 |

#### **DOMAIN B: Data & Privacy Risks**
Risks related to data handling, privacy, and compliance.

| Risk Code | Risk Name | Description | HITRUST Control |
|-----------|-----------|-------------|-----------------|
| DP-001 | Training Data Leakage | Exposure of sensitive training data | 06.01.01 |
| DP-002 | PII in Model Outputs | Unintended disclosure of personal data | 06.02.01 |
| DP-003 | Data Poisoning | Corrupted training datasets | 09.01.01 |
| DP-004 | Inference Data Exposure | Leakage through model queries | 06.01.03 |
| DP-005 | Cross-Border Data Transfer | AI processing violating data residency | 06.04.01 |

#### **DOMAIN C: Operational Risks**
Risks affecting AI system operations and reliability.

| Risk Code | Risk Name | Description | Impact Level |
|-----------|-----------|-------------|--------------|
| OP-001 | Model Drift | Performance degradation over time | HIGH |
| OP-002 | Availability Attacks | DoS targeting AI services | CRITICAL |
| OP-003 | Supply Chain Compromise | Vulnerable dependencies/libraries | HIGH |
| OP-004 | Resource Exhaustion | Excessive computational demands | MEDIUM |
| OP-005 | Integration Failures | AI/system interface breakdowns | HIGH |

#### **DOMAIN D: Governance & Compliance Risks**
Risks related to regulatory compliance and governance.

| Risk Code | Risk Name | Description | Regulatory Impact |
|-----------|-----------|-------------|-------------------|
| GC-001 | Algorithmic Bias | Discriminatory model decisions | LEGAL LIABILITY |
| GC-002 | Explainability Gaps | Inability to explain AI decisions | COMPLIANCE VIOLATION |
| GC-003 | Audit Trail Deficiency | Inadequate logging of AI decisions | HITRUST FAILURE |
| GC-004 | Third-Party AI Risk | Unvetted vendor AI services | VENDOR RISK |
| GC-005 | Regulatory Non-Compliance | Violation of AI regulations | PENALTIES |

#### **DOMAIN E: Business & Strategic Risks**
Risks affecting business operations and strategy.

| Risk Code | Risk Name | Description | Business Impact |
|-----------|-----------|-------------|-----------------|
| BS-001 | Hallucination Risk | AI generating false information | REPUTATION |
| BS-002 | Over-Reliance | Excessive dependency on AI | OPERATIONAL |
| BS-003 | Intellectual Property | IP infringement in outputs | LEGAL |
| BS-004 | Cost Overrun | Unexpected AI operational costs | FINANCIAL |
| BS-005 | Competitive Disadvantage | Inferior AI capabilities | STRATEGIC |

---

## 3. AI System Risk Classification

### 3.1 Risk Tiers

#### **Tier 1: Critical Risk AI Systems**
- **Criteria**: Direct impact on life, safety, or critical infrastructure
- **Examples**: Medical diagnosis AI, security threat detection
- **Assessment Frequency**: Monthly
- **Approval**: CISO + Executive Leadership

#### **Tier 2: High Risk AI Systems**
- **Criteria**: Significant financial, legal, or privacy impact
- **Examples**: Vertex AI (production), AIgency platform
- **Assessment Frequency**: Quarterly
- **Approval**: CISO + Department Head

#### **Tier 3: Medium Risk AI Systems**
- **Criteria**: Moderate operational or reputational impact
- **Examples**: Jasper (content), Lovable (development)
- **Assessment Frequency**: Semi-Annual
- **Approval**: Security Team Lead

#### **Tier 4: Low Risk AI Systems**
- **Criteria**: Minimal impact, internal use only
- **Examples**: Development assistants, testing tools
- **Assessment Frequency**: Annual
- **Approval**: Team Manager

### 3.2 Classification Criteria Matrix

| Factor | Weight | Critical (4) | High (3) | Medium (2) | Low (1) |
|--------|--------|-------------|----------|-----------|---------|
| Data Sensitivity | 30% | PII/PHI/PCI | Confidential | Internal | Public |
| User Scope | 20% | Public-facing | External partners | Department | Individual |
| Decision Authority | 20% | Autonomous | Semi-autonomous | Advisory | Informational |
| Financial Impact | 15% | >$1M | $100K-$1M | $10K-$100K | <$10K |
| Regulatory Scope | 15% | Federal/HIPAA | Industry | Internal | None |

**Risk Score Calculation**: Σ(Factor Score × Weight) = Final Risk Tier

---

## 4. MITRE ATLAS Threat Mapping

### 4.1 Attack Tactics

| Tactic ID | Tactic Name | Applicable Systems | Mitigation Strategy |
|-----------|-------------|-------------------|---------------------|
| AML.TA0000 | Reconnaissance | All | Access controls, monitoring |
| AML.TA0001 | Resource Development | Vertex AI, AIgency | Supply chain security |
| AML.TA0002 | Initial Access | External-facing | Authentication, rate limiting |
| AML.TA0003 | Execution | All production | Input validation |
| AML.TA0004 | Persistence | Critical systems | Integrity monitoring |
| AML.TA0005 | Defense Evasion | High-risk systems | Anomaly detection |
| AML.TA0006 | Discovery | All | Least privilege |
| AML.TA0009 | Collection | Data-processing | Encryption, DLP |
| AML.TA0010 | ML Model Access | All models | API security |
| AML.TA0011 | ML Attack Staging | Production models | Staging validation |

### 4.2 Technique-Specific Controls

```yaml
Model_Poisoning:
  Detection:
    - Data validation pipelines
    - Statistical anomaly detection
    - Provenance tracking
  Prevention:
    - Trusted data sources
    - Input sanitization
    - Differential privacy

Adversarial_Examples:
  Detection:
    - Input similarity analysis
    - Confidence thresholds
    - Ensemble validation
  Prevention:
    - Adversarial training
    - Input preprocessing
    - Defensive distillation
```

---

## 5. Risk Scoring Methodology

### 5.1 Risk Score Formula

```
AI_Risk_Score = (Threat_Likelihood × Impact_Severity × Control_Gap) / Mitigation_Effectiveness
```

### 5.2 Component Definitions

#### Threat Likelihood (1-5)
1. **Rare**: <5% annual probability
2. **Unlikely**: 5-20% annual probability
3. **Possible**: 20-50% annual probability
4. **Likely**: 50-80% annual probability
5. **Almost Certain**: >80% annual probability

#### Impact Severity (1-5)
1. **Negligible**: No measurable impact
2. **Minor**: Limited impact, quick recovery
3. **Moderate**: Noticeable impact, manageable
4. **Major**: Significant disruption
5. **Catastrophic**: Critical failure, extensive damage

#### Control Gap (0.1-1.0)
- 0.1-0.3: Mature controls in place
- 0.4-0.6: Partial controls implemented
- 0.7-0.9: Limited controls
- 1.0: No controls

#### Mitigation Effectiveness (1-5)
1. **None**: No mitigation available
2. **Limited**: Minimal reduction
3. **Moderate**: 25-50% risk reduction
4. **Substantial**: 50-75% risk reduction
5. **Comprehensive**: >75% risk reduction

### 5.3 Risk Rating Matrix

| Risk Score | Rating | Action Required |
|------------|--------|-----------------|
| 15-25 | CRITICAL | Immediate executive action |
| 10-14.9 | HIGH | CISO approval, 30-day remediation |
| 5-9.9 | MEDIUM | Security team review, 90-day plan |
| 2-4.9 | LOW | Standard controls, annual review |
| <2 | MINIMAL | Accept risk, document |

---

## 6. Implementation Requirements

### 6.1 Phase 1: Foundation (March 2026)
- [ ] Inventory all AI systems
- [ ] Assign initial risk tiers
- [ ] Document current controls
- [ ] Identify control gaps

### 6.2 Phase 2: Assessment (April 2026)
- [ ] Conduct risk assessments per tier
- [ ] Calculate risk scores
- [ ] Create remediation plans
- [ ] Establish monitoring baselines

### 6.3 Phase 3: Operationalization (May-June 2026)
- [ ] Implement continuous monitoring
- [ ] Integrate with Google SecOps SIEM
- [ ] Automate risk scoring where possible
- [ ] Train assessment teams

### 6.4 Phase 4: HITRUST Validation (July 2026)
- [ ] Map all risks to HITRUST controls
- [ ] Generate evidence packages
- [ ] Conduct internal audit
- [ ] Prepare for A-LIGN assessment

---

## 7. Roles & Responsibilities

### CISO
- Approve taxonomy updates
- Review Critical/High risks monthly
- Sign off on risk acceptance

### AI Risk Committee
- Quarterly taxonomy review
- Cross-functional risk assessment
- Policy enforcement

### Security Team
- Maintain risk register
- Conduct assessments
- Monitor controls

### System Owners
- Provide system documentation
- Implement controls
- Report incidents

### Third-Party Assessor (A-LIGN)
- Validate taxonomy alignment
- Assess control effectiveness
- Certify HITRUST compliance

---

## 8. Integration Points

### Technical Integrations
- **Vanta**: Automated evidence collection
- **Google SecOps**: Real-time monitoring
- **GitHub**: Code scanning for AI risks
- **Jira**: Risk tracking and remediation

### Process Integrations
- Change management reviews
- Incident response procedures
- Vendor assessment workflows
- Audit preparations

---

## 9. Metrics & KPIs

| Metric | Target | Frequency |
|--------|--------|-----------|
| Systems Assessed | 100% | Quarterly |
| Critical Risks Mitigated | <2 | Monthly |
| Mean Time to Detect | <24 hours | Continuous |
| Control Coverage | >80% | Quarterly |
| HITRUST Readiness | 95% | Monthly |

---

## 10. Appendices

### Appendix A: AI System Inventory Template
[See AI_System_Inventory_Template.xlsx]

### Appendix B: Risk Assessment Worksheet
[See AI_Risk_Assessment_Form.pdf]

### Appendix C: HITRUST Control Mapping
[See HITRUST_AI2_Mapping.xlsx]

### Appendix D: Third-Party AI Services
- Google Vertex AI / Gemini
- Anthropic Claude
- Jasper
- Lovable
- GitHub Copilot

---

**Document Control**
Review Date: Quarterly
Next Review: 2026-06-01
Distribution: Security Team, AI Risk Committee, System Owners

*This document is part of MERGE Agency's HITRUST r2 v11.5 + AI2 certification preparation*