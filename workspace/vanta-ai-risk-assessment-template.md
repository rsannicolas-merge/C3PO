# Vanta AI Risk Assessment Configuration Template
## MERGE Federal Agency - HITRUST r2 v11.5 Compliance

### Assessment Metadata
- **Assessment Type**: AI System Risk Assessment
- **Frequency**: 180 days (6 months)
- **Next Assessment Due**: Calculate from implementation date
- **Risk Framework**: HITRUST CSF v11.5 + NIST AI RMF
- **Criticality Level**: HIGH (Federal Agency, Healthcare Data)

---

## Risk Scoring Matrix

### Likelihood Ratings
- **Low (1)**: < 10% chance in 180 days
- **Medium (2)**: 10-50% chance in 180 days
- **High (3)**: > 50% chance in 180 days

### Impact Ratings
- **Low (1)**: Minimal operational impact, < $10K cost
- **Medium (2)**: Service degradation, $10K-$100K cost
- **High (3)**: Major disruption, $100K-$1M cost, regulatory notice
- **Critical (4)**: Mission failure, > $1M cost, regulatory action

### Risk Score Calculation
- **Risk Score** = Likelihood × Impact
- **Critical**: 9-12 (Immediate remediation required)
- **High**: 6-8 (Remediation within 30 days)
- **Medium**: 3-5 (Remediation within 90 days)
- **Low**: 1-2 (Accept or monitor)

---

## Enterprise Risk Context

### Agency Risk Appetite Statement
"As a federal agency handling sensitive constituent data, we maintain a LOW risk appetite for:
- Data privacy violations
- Regulatory non-compliance
- Service availability below 99%
- AI decision-making without human oversight

We accept MODERATE risk for:
- Innovation adoption with proper controls
- Cost optimization initiatives
- Performance improvements with testing"

### Risk Treatment Options
1. **Avoid**: Eliminate the risk by not using the AI capability
2. **Mitigate**: Implement controls to reduce likelihood or impact
3. **Transfer**: Use insurance or vendor agreements
4. **Accept**: Document acceptance with compensating controls

---

## Vanta Configuration Steps

### 1. Create Custom Risk Framework
```
Navigation: Settings > Risk Management > Frameworks
- Name: "AI System Risk Assessment - HITRUST"
- Based on: Custom Framework
- Map to: HITRUST r2 v11.5 controls
```

### 2. Configure Risk Categories
```
Primary Categories:
- Model Risk
- Data Risk
- Security Risk
- Operational Risk
- Compliance Risk
```

### 3. Set Up Automated Evidence Collection

#### Vertex AI Integration
- **Log Collection**: GCP Cloud Logging API
- **Metrics**: Vertex AI Model Monitoring
- **Alerts**: Cloud Monitoring integration
- **Frequency**: Daily sync

#### Required API Permissions
```json
{
  "gcp_permissions": [
    "logging.logs.list",
    "monitoring.metricDescriptors.list",
    "aiplatform.models.get",
    "aiplatform.endpoints.list"
  ]
}
```

### 4. Risk Owner Assignments
- **Primary Owner**: Roze San Nicolas (CISO)
- **Technical Owner**: Michael Wood
- **Review Board**: Executive Leadership Team

### 5. Notification Configuration
```
Alert Triggers:
- New Critical Risk: Immediate
- New High Risk: Within 24 hours
- Assessment Due: 30 days prior
- Overdue Remediation: Weekly escalation
```

---

## Assessment Workflow

### Phase 1: Risk Identification (Days 1-5)
1. Review AI inventory from Michael Wood's team
2. Identify new AI systems or changes
3. Document risk scenarios
4. Assign initial scores

### Phase 2: Control Assessment (Days 6-10)
1. Evaluate existing controls
2. Test control effectiveness
3. Document gaps
4. Calculate residual risk

### Phase 3: Treatment Planning (Days 11-15)
1. Prioritize by risk score
2. Define remediation plans
3. Assign remediation owners
4. Set target dates

### Phase 4: Review & Approval (Days 16-20)
1. Management review
2. Risk acceptance decisions
3. Update risk register
4. Schedule next assessment

---

## Evidence Requirements

### Per Risk Item
- **Current State Documentation**: Screenshots, configs, policies
- **Control Evidence**: Test results, audit logs, metrics
- **Remediation Evidence**: Tickets, change logs, approvals
- **Acceptance Documentation**: Sign-offs, exceptions, compensating controls

### Automated Collection Points
1. **GCP/Vertex Logs**: Daily via API
2. **Jira Tickets**: Real-time webhook
3. **GitHub Changes**: Commit hooks
4. **Monitoring Alerts**: CloudWatch/Stackdriver

### MCP Integration (C3PO AI Agent)
The C3PO AI Agent can automatically orchestrate evidence collection and risk mapping using the Vanta MCP. Direct the agent to use the following tools:
- `list_framework_controls`: To retrieve controls mapped to HITRUST and automatically populate this assessment template.
- `list_risk_scenarios`: To fetch current scoring and treatment plans for existing AI risks.
- `documents`: To retrieve or upload supporting evidence.

---

## Reporting Templates

### Executive Dashboard Metrics
- Total AI Risks by Category
- Critical/High Risk Trends
- Remediation Progress %
- Days to Assessment
- Compliance Score

### Board Reporting Elements
- AI Risk Posture Summary
- Top 5 Risks with Treatments
- Resource Requirements
- Regulatory Compliance Status
- Incident Metrics

---

## HITRUST Control Mapping

### Primary AI Controls
- **01.00a**: AI Security Management Program
- **01.02a**: AI Roles and Responsibilities
- **01.03a**: AI Risk Management
- **06.09b**: AI Change Management
- **06.10h**: AI Model Documentation
- **07.07a**: AI Asset Inventory
- **07.10b**: AI Input Validation
- **09.09s**: AI Data Protection
- **11.01c**: AI Access Control
- **12.09ab**: AI Monitoring

### Risk-Specific Mappings
See `vanta-ai-risk-register.csv` for detailed control mappings per risk

---

## Implementation Checklist

- [ ] Import risk register CSV into Vanta
- [ ] Configure risk framework and categories
- [ ] Set up GCP API integration
- [ ] Assign risk owners in Vanta
- [ ] Configure notification rules
- [ ] Schedule initial assessment
- [ ] Train assessment team
- [ ] Document acceptance criteria
- [ ] Create executive dashboard
- [ ] Test evidence collection

---

## Next Steps

1. **Week 1**: Configure Vanta framework and import risks
2. **Week 2**: Set up integrations and automation
3. **Week 3**: Conduct initial assessment
4. **Week 4**: Present findings to leadership

## Support Contacts

- **Vanta Support**: support@vanta.com
- **A-LIGN Assessor**: [Contact from report]
- **GCP Support**: [Federal support channel]
- **HITRUST MyCSF**: support@hitrustalliance.net