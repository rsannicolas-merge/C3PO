# AI System Inventory Template
## MERGE Agency - HITRUST AI2 Compliance

**Template Version**: 1.0
**Last Updated**: 2026-03-04
**Purpose**: Standardized inventory of all AI systems for risk assessment and compliance

---

## Instructions

1. Complete one record for each AI system/model in use
2. Update quarterly or upon significant changes
3. Submit to Security Team for risk scoring
4. Maintain in Vanta for evidence collection

---

## AI System Inventory Records

### System ID: AI-001
**System Name**: Google Vertex AI / Gemini
**Category**: Infrastructure Platform
**Vendor**: Google Cloud Platform
**Deployment**: Production

#### Technical Details
- **Model Type**: Large Language Model (LLM)
- **Model Version**: Gemini Pro 1.5
- **API Endpoint**: https://[region]-aiplatform.googleapis.com
- **Architecture**: Multi-modal transformer
- **Parameters**: 1.5T (estimated)

#### Business Context
- **Primary Use Case**: AI-powered security analysis, log reasoning
- **Business Owner**: Engineering Department
- **Technical Owner**: DevSecOps Team
- **Users**: Security analysts, incident responders
- **User Count**: 15-20
- **Criticality**: HIGH

#### Data Handling
- **Input Data Types**: Security logs, configurations, alerts
- **Input Sensitivity**: CONFIDENTIAL
- **Output Data Types**: Analysis reports, recommendations
- **Data Retention**: 90 days
- **PII Processing**: No
- **PHI Processing**: No

#### Risk Classification
- **Risk Tier**: Tier 2 - High Risk
- **Risk Score**: 12.5 (HIGH)
- **Last Assessment**: 2026-03-01
- **Next Assessment**: 2026-06-01

#### Security Controls
- **Authentication**: OAuth 2.0 + API keys
- **Encryption**: TLS 1.3 in transit, AES-256 at rest
- **Access Controls**: IAM roles, least privilege
- **Monitoring**: Google Cloud Logging, SecOps SIEM
- **Audit Logging**: Enabled, 1-year retention

#### Compliance
- **HITRUST Controls**: 01.01, 06.01, 09.01, 12.01
- **Regulatory Scope**: FedRAMP, FISMA
- **Contract Date**: 2025-06-15
- **SLA**: 99.9% uptime
- **BAA/DPA**: Yes, executed 2025-06-20

#### Vendor Assessment
- **Last Review**: 2026-01-15
- **Risk Rating**: ACCEPTABLE
- **SOC2 Report**: Yes, Type II
- **AI Ethics Policy**: Published
- **Incident History**: None in last 12 months

---

### System ID: AI-002
**System Name**: AIgency Platform
**Category**: Internal Application
**Vendor**: In-house Development
**Deployment**: Production

#### Technical Details
- **Model Type**: Custom fine-tuned models
- **Model Version**: v3.2.1
- **API Endpoint**: https://aigency.merge.gov
- **Architecture**: Ensemble (multiple models)
- **Parameters**: Various

#### Business Context
- **Primary Use Case**: Agency AI operations platform
- **Business Owner**: CISO Office
- **Technical Owner**: AI Engineering Team
- **Users**: All agency staff
- **User Count**: 500+
- **Criticality**: CRITICAL

#### Data Handling
- **Input Data Types**: Documents, queries, workflows
- **Input Sensitivity**: UP TO SECRET
- **Output Data Types**: Processed documents, decisions
- **Data Retention**: Per classification guidelines
- **PII Processing**: Yes
- **PHI Processing**: No

#### Risk Classification
- **Risk Tier**: Tier 1 - Critical Risk
- **Risk Score**: 18.5 (CRITICAL)
- **Last Assessment**: 2026-02-15
- **Next Assessment**: 2026-03-15

#### Security Controls
- **Authentication**: PIV/CAC + MFA
- **Encryption**: FIPS 140-2 validated
- **Access Controls**: Attribute-based (ABAC)
- **Monitoring**: Continuous, SOC integration
- **Audit Logging**: Immutable, indefinite retention

#### Compliance
- **HITRUST Controls**: All applicable
- **Regulatory Scope**: FISMA HIGH
- **Contract Date**: N/A (internal)
- **SLA**: 99.99% for critical functions
- **BAA/DPA**: N/A

#### Vendor Assessment
- **Last Review**: N/A (internal)
- **Risk Rating**: MANAGED
- **SOC2 Report**: N/A
- **AI Ethics Policy**: Internal governance
- **Incident History**: 2 minor in last 12 months

---

### System ID: AI-003
**System Name**: Anthropic Claude
**Category**: AI Assistant
**Vendor**: Anthropic
**Deployment**: SaaS

#### Technical Details
- **Model Type**: Large Language Model
- **Model Version**: Claude 3 Opus
- **API Endpoint**: https://api.anthropic.com
- **Architecture**: Transformer
- **Parameters**: Undisclosed

#### Business Context
- **Primary Use Case**: Code review, documentation, analysis
- **Business Owner**: Engineering Department
- **Technical Owner**: Development Teams
- **Users**: Developers, analysts
- **User Count**: 50-75
- **Criticality**: MEDIUM

#### Data Handling
- **Input Data Types**: Code, documentation, queries
- **Input Sensitivity**: INTERNAL
- **Output Data Types**: Code suggestions, analysis
- **Data Retention**: Per Anthropic policy
- **PII Processing**: Prohibited by policy
- **PHI Processing**: No

#### Risk Classification
- **Risk Tier**: Tier 3 - Medium Risk
- **Risk Score**: 7.5 (MEDIUM)
- **Last Assessment**: 2026-02-01
- **Next Assessment**: 2026-08-01

#### Security Controls
- **Authentication**: API keys, SSO pending
- **Encryption**: TLS 1.3
- **Access Controls**: Project-based keys
- **Monitoring**: Usage tracking via API
- **Audit Logging**: API call logs

#### Compliance
- **HITRUST Controls**: 06.01, 09.01, 15.01
- **Regulatory Scope**: Commercial terms
- **Contract Date**: 2025-11-01
- **SLA**: 99.5% uptime
- **BAA/DPA**: DPA executed

#### Vendor Assessment
- **Last Review**: 2025-11-01
- **Risk Rating**: ACCEPTABLE
- **SOC2 Report**: Yes, Type II
- **AI Ethics Policy**: Constitutional AI
- **Incident History**: None reported

---

### System ID: AI-004
**System Name**: Jasper
**Category**: Content Generation
**Vendor**: Jasper AI Inc.
**Deployment**: SaaS

#### Technical Details
- **Model Type**: Fine-tuned GPT
- **Model Version**: Jasper v2
- **API Endpoint**: https://api.jasper.ai
- **Architecture**: GPT-based
- **Parameters**: Proprietary

#### Business Context
- **Primary Use Case**: Marketing content, communications
- **Business Owner**: Communications Office
- **Technical Owner**: Marketing Team
- **Users**: Content creators
- **User Count**: 10-15
- **Criticality**: LOW

#### Data Handling
- **Input Data Types**: Text prompts, templates
- **Input Sensitivity**: PUBLIC
- **Output Data Types**: Marketing content
- **Data Retention**: 30 days
- **PII Processing**: No
- **PHI Processing**: No

#### Risk Classification
- **Risk Tier**: Tier 4 - Low Risk
- **Risk Score**: 3.2 (LOW)
- **Last Assessment**: 2026-01-01
- **Next Assessment**: 2027-01-01

#### Security Controls
- **Authentication**: Username/password + MFA
- **Encryption**: Standard TLS
- **Access Controls**: User-based
- **Monitoring**: Basic usage metrics
- **Audit Logging**: Limited

#### Compliance
- **HITRUST Controls**: 09.01, 15.01
- **Regulatory Scope**: None
- **Contract Date**: 2025-09-01
- **SLA**: Best effort
- **BAA/DPA**: Standard terms

#### Vendor Assessment
- **Last Review**: 2025-09-01
- **Risk Rating**: LOW RISK
- **SOC2 Report**: No
- **AI Ethics Policy**: Basic guidelines
- **Incident History**: None

---

## Summary Statistics

| Metric | Value |
|--------|-------|
| Total AI Systems | 4 |
| Critical Risk | 1 |
| High Risk | 1 |
| Medium Risk | 1 |
| Low Risk | 1 |
| Systems Requiring Assessment | 2 |
| Average Risk Score | 10.4 |
| Compliance Coverage | 85% |

---

## Risk Heat Map

```
         Impact →
    Low    Med    High   Crit
L   |Jasper|      |      |      |
i   |      |      |      |      |
k   |      |Claude|      |      |
e   |      |      |Vertex|      |
l → |      |      |      |AIgency|
i
h
o
o
d
```

---

## Action Items

1. **IMMEDIATE**: Update AIgency risk assessment (overdue)
2. **30 DAYS**: Implement SSO for Anthropic Claude
3. **60 DAYS**: Complete Vertex AI control validation
4. **90 DAYS**: Refresh all vendor assessments

---

## Attestation

I certify that this AI System Inventory is complete and accurate to the best of my knowledge.

**Name**: _________________________
**Title**: _________________________
**Date**: _________________________
**Signature**: _____________________

---

*This template is part of MERGE Agency's HITRUST AI2 compliance program*
*For questions, contact: security@merge.gov*