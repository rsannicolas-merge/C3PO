# DRAFT: Your HITRUST r2 Is Actually an AI Governance Audit

Status: DRAFT
Topic: HITRUST r2 for AI-forward organizations
Format: LinkedIn post
Audience: CISOs, security leaders, GRC professionals pursuing HITRUST
Key insight: If you're using AI in production, your HITRUST r2 gaps are probably AI governance gaps -- not traditional security controls

---

## Post

We just completed our HITRUST r2 gap assessment with A-LIGN.

I expected the usual suspects: patch management gaps, access control findings, logging coverage holes.

What we actually got: four high-priority gaps, all AI governance.

→ No centralized AI Governance Policy
→ No structured AI Risk Assessment process
→ Incomplete AI model and dataset inventory
→ No formal change control for AI model updates

Not a firewall finding in sight.

Here's what that tells me: if you're running AI systems in production -- Vertex, Gemini, whatever -- HITRUST r2 is no longer just a security audit. It's an AI governance audit wearing a compliance badge.

The good news: this is more tractable than it looks.

The gaps are well-defined. The remediation path is clear. And if you're using Vanta as your GRC platform, you can automate a significant chunk of the evidence collection.

The thing that keeps me up at night isn't the technical controls. It's the approval chain.

An AI Governance Policy isn't just a security document -- it needs Legal, Engineering, and executive sign-off. In a 2-person SecOps team running against a 5-person workload, getting three departments to prioritize a policy review is the actual critical path.

The lesson: your HITRUST r2 timeline is not a security engineering problem. It's a change management problem.

Build your governance infrastructure before your technical controls. Get your policy signed before you write a single configuration. Because the assessor doesn't care how tight your IAM is if you can't show them an approved AI use policy.

What's your biggest surprise from a HITRUST assessment? Drop it below. ↓

---

## Follow-Up Post (queued)

"The one HITRUST r2 evidence item you're probably not collecting: GCP's FedRAMP ATO." -- For GCP-hosted workloads, inherited controls from Google can satisfy multiple HITRUST control specs. Most teams don't know to ask for them.

## Notes

- Add specific timeline context when comfortable sharing publicly (incubation/fieldwork timing)
- Pair with the force multiplier post as a series: Post 1 = AI FTEs, Post 2 = HITRUST AI governance
- Tag: #HITRUST #CISO #AIGovernance #GRC #FedRAMP #SecurityOperations
- Consider sharing after Phase 1 is closed -- more credible with completed governance work behind it
