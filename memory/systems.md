# Security Asset Registry
*Last Updated: 2026-03-10*
*Registry Owner: CISO*

## Overview
This registry catalogs all IT systems, security tools, vendors, and SLA contracts within the security program scope. Systems are prioritized by risk tier and compliance requirements.

---

## IT Systems Inventory

### Critical Systems (Tier 1)
*Systems with PHI/PII, revenue-generating, or mission-critical functions*

| System | Purpose | Owner | Stack | Compliance | Documentation | SLA |
|--------|---------|-------|-------|------------|---------------|-----|
| AIgency | Clinical AI decisioning | Clinical Ops | GCP/Vertex AI | HITRUST r2, AI2 | ⚠️ Partial | 99.9% |
| Corsair CPOE | Computerized Provider Order Entry | Clinical | W3C VC/Ed25519 | HITRUST r2 | ⚠️ Missing | [TBD] |
| [TBD - Legacy Clinical] | | | | | | |

### High-Risk Systems (Tier 2)
*Systems with sensitive data or operational importance*

| System | Purpose | Owner | Stack | Compliance | Documentation | SLA |
|--------|---------|-------|-------|------------|---------------|-----|
| Vertex AI Platform | AI/ML infrastructure | Engineering | GCP | HITRUST AI2 | ✅ Complete | 99.95% |
| MERGE Security Dashboard | Executive security intelligence | CISO | React/Vite | Internal | ✅ Complete | Internal |
| [TBD - Data Platform] | | | | | | |

### Medium-Risk Systems (Tier 3)
*Internal tools and support systems*

| System | Purpose | Owner | Stack | Compliance | Documentation | SLA |
|--------|---------|-------|-------|------------|---------------|-----|
| Claude Enterprise | AI assistant platform | IT | Anthropic SaaS | HITRUST AI2 | ✅ Complete | 99.9% |
| Jira | Ticketing & change mgmt | IT | Atlassian Cloud | SOC2 | ✅ Complete | 99.95% |
| C3PO Platform | Security ops command center | CISO | Multi-tool | Internal | ✅ Complete | Internal |
| SecOps Command Center | AI agent orchestration demo | CISO | React/Vite/GCP | HITRUST evidence | ✅ Complete | Demo only |

### Low-Risk Systems (Tier 4)
*Non-sensitive, non-critical systems*

| System | Purpose | Owner | Stack | Compliance | Documentation | SLA |
|--------|---------|-------|-------|------------|---------------|-----|
| Jasper AI | Marketing content | Marketing | SaaS | None | ✅ Complete | Best effort |
| [TBD - Internal tools] | | | | | | |

---

## Security Tools & Platforms

### GRC & Compliance
| Tool | Purpose | Coverage | Status | Contract |
|------|---------|----------|--------|----------|
| Vanta | Compliance automation | HITRUST, SOC2 | ✅ Active | Annual (renews 2026-12) |
| myCSF | HITRUST assessment portal | HITRUST r2/AI2 | ✅ Active | Per assessment |
| Corsair | Compliance verification | CPOE/credentials | ⏳ Implementing | Internal |

### Security Operations
| Tool | Purpose | Coverage | Status | Contract |
|------|---------|----------|--------|----------|
| Google SecOps | SIEM platform | Enterprise-wide | ✅ Operational | Enterprise agreement |
| Sec-Gemini | AI security analysis | Logs/threats | ⏳ Integrating | GCP bundle |
| C3PO Platform | Security command center | Multi-domain | ✅ Operational | Internal |
| [TBD - Vulnerability Scanner] | | | | |
| [TBD - EDR Platform] | | | | |

### DevSecOps
| Tool | Purpose | Coverage | Status | Contract |
|------|---------|----------|--------|----------|
| GitHub | Source control + security | All repos | ✅ Active | Enterprise |
| GitHub Advanced Security | SAST/SCA/Secrets | [TBD repos] | ❓ Unknown | [TBD] |
| [TBD - Container Scanner] | | | | |
| [TBD - IaC Scanner] | | | | |

---

## Vendor Registry

### Critical Vendors
*Vendors with access to sensitive data or critical infrastructure*

| Vendor | Service | Risk Level | Last Assessment | Contract Expires | POC |
|--------|---------|------------|-----------------|------------------|-----|
| Google Cloud | IaaS/PaaS | Critical | 2025-11 | 2027-06 | [TBD] |
| A-LIGN | HITRUST assessor | High | 2026-02 | Per engagement | [TBD] |
| Anthropic | AI platform (Claude) | High | 2026-01 | 2026-12 | [TBD] |

### Standard Vendors
*Regular service providers*

| Vendor | Service | Risk Level | Last Assessment | Contract Expires | POC |
|--------|---------|------------|-----------------|------------------|-----|
| Atlassian | Jira/Confluence | Medium | 2025-09 | 2026-09 | [TBD] |
| Jasper | AI content generation | Low | 2025-06 | 2026-06 | Marketing |
| [TBD] | | | | | |

---

## SLA Tracking

### Active SLAs

| System/Vendor | SLA Target | Current Month | YTD | Status | Penalties |
|---------------|------------|---------------|-----|--------|-----------|
| AIgency | 99.9% uptime | [No data] | [No data] | ❓ Unknown | $10K/month |
| Vertex AI | 99.95% uptime | [No data] | [No data] | ❓ Unknown | Credits |
| Claude Enterprise | 99.9% uptime | [No data] | [No data] | ❓ Unknown | Credits |
| Jira | 99.95% uptime | [No data] | [No data] | ❓ Unknown | Credits |
| Google Cloud | 99.95% uptime | [No data] | [No data] | ❓ Unknown | Credits |

### SLA Gaps
- ⚠️ No automated SLA monitoring in place
- ⚠️ Historical SLA data not aggregated
- ⚠️ Multiple legacy contracts with inconsistent terms
- ⚠️ Corsair CPOE SLA undefined

---

## Documentation Health

### Coverage by Tier
| Tier | Systems | Documented | Coverage |
|------|---------|------------|----------|
| Critical (Tier 1) | 3+ | 0 | 0% |
| High (Tier 2) | 3+ | 2 | ~67% |
| Medium (Tier 3) | 3 | 3 | 100% |
| Low (Tier 4) | 2+ | 1 | ~50% |
| **Overall** | **11+** | **6** | **~55%** |

### Critical Gaps
1. **Corsair CPOE** - No documentation (Critical system)
2. **AIgency** - Partial documentation only
3. **Legacy clinical systems** - Unknown inventory
4. **Security scanning tools** - Incomplete tool registry

---

## Action Items

### Immediate (This Week)
- [ ] Complete Corsair CPOE documentation
- [ ] Inventory all security scanning tools
- [ ] Identify all Tier 1 legacy systems
- [ ] Set up SLA monitoring for critical systems

### Short-term (30 Days)
- [ ] Document all Critical and High systems
- [ ] Establish automated SLA monitoring
- [ ] Complete vendor risk assessments for critical vendors
- [ ] Integrate Sec-Gemini with Google SecOps

### HITRUST Prep (Before May 2026)
- [ ] 100% documentation for in-scope systems
- [ ] Vendor assurance packages collected
- [ ] SLA evidence for past 12 months
- [ ] Complete Corsair integration for CPOE verification

---

## Notes

**Data Quality**:
- Confidence Level: 6/10 (Moderate - merged existing data)
- AI systems from Wood's inventory incorporated
- C3PO platform components integrated
- Legacy system discovery urgently needed

**Last Full Review**: Never (initial merge)
**Next Review Due**: 2026-03-16
