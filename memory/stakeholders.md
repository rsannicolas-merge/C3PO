# Stakeholders -- Relationships & Influence Map

Last Updated: 2026-02-20

---

## Purpose

CISO-level relationship intelligence. Who to involve, how to communicate, and how decisions get made. Read before significant meetings, communications, or escalations.

---

## Leadership / Management

### Michael Wood

**Title**: [Leadership -- oversees AI Garage and broader engineering initiatives]
**Relationship**: Good

**Communication Style:**

- Prefers: Direct, solution-oriented
- Detail level: High-level with option to drill down
- Decision style: Consensus-seeking but decisive

**Priorities:**

- Broader adoption of tools beyond just AI Garage
- Agency-wide scalability of solutions
- Cost efficiency and GCP billing oversight

**How to Work With:**

- Frame SecOps needs in terms of agency-wide benefit and risk reduction
- Lead with concrete output and examples -- not concepts
- Propose clear next steps with effort estimates
- Bring resource asks with quantified risk justification

**Avoid:**

- Pitching tools as narrow SecOps-only solutions (he wants broader applicability)
- Abstract proposals without demonstrated outcomes

---

### Matthew Macaluso

**Title**: [Technical leadership -- permissions and infrastructure management]
**Relationship**: Good

**Communication Style:**

- Prefers: Technical, specific
- Detail level: Detailed
- Decision style: Practical, hands-on

**Priorities:**

- GCP permissions and access management
- Supporting team infrastructure needs
- Navigating bureaucratic friction efficiently

**How to Work With:**

- Be precise about what access or permissions are needed
- Give lead time -- he gets pulled in many directions
- Come with a specific ask, not an open-ended request

**Avoid:**

- Expecting instant turnaround on permissions (GCP admin is slow)
- Vague requests that require back-and-forth to scope

---

## Key Collaborators

### Stephen Dulaney -- AI Garage / PAM Development

**Role**: Building AI-powered tools (PAM ITSM Light, document health) that could extend SecOps capacity
**Collaboration style**: Enthusiastic, demos-oriented, willing to tutor and co-develop
**CISO relevance**: His tools could become the backbone of SecOps automation -- needs Roze's requirements to build right
**Dependencies**: Needs Roze's input on SecOps governance requirements; offered 15-min twice-weekly Cloud Code sessions
**Next touchpoint**: ITSM Light follow-up meeting

---

### Rose -- Security Documentation & Policy

**Role**: Created the security policy and procedure templates that define the compliance baseline
**Collaboration style**: [To be learned]
**CISO relevance**: Her templates are the authoritative source for what "compliant" looks like -- critical input for automated verification
**Dependencies**: Her policy library drives compliance scoring; needs to stay current with regulatory changes
**Open question**: Are her templates current with latest NIST/FedRAMP requirements?

---

### Kurt Miller -- Governance & RACI

**Role**: RACI diagram must be completed with Kurt before ITSM Light agent development proceeds
**Collaboration style**: [To be learned]
**CISO relevance**: RACI defines accountability structure -- foundational governance work
**Dependencies**: RACI completion gates agent development; Roze needs to come prepared with SecOps role definitions
**Next touchpoint**: RACI kickoff meeting (TBD)

---

## Key Teams

### AI Garage

**Leader**: Stephen Dulaney / Michael Wood
**Role**: Building AI-powered tools and exploring agentic capabilities across the agency
**CISO relevance**: Potential force multiplier for understaffed SecOps team
**How to engage**: Through Michael Wood for strategic alignment; directly with Stephen for technical collaboration

---

### SecOps Team (Roze's Team)

**Leader**: Roze San Nicolas
**Members**: 2 FTEs total
**Role**: Security Operations -- security program management, compliance, infrastructure security, incident response
**Capacity reality**: 2 people doing 5+ people's work; AI tooling is the primary scaling strategy
**How to engage**: Directly with Roze; triage ruthlessly -- not everything can be addressed

---

## Decision-Making Map

| Decision Type | Who Decides | Who Influences | Who Executes |
|---------------|-------------|----------------|--------------|
| Tool adoption (ITSM Light) | Michael Wood + Roze | Stephen Dulaney, Matt | Stephen (build) + Roze (requirements) |
| Security policy & compliance | Roze | Rose (templates), Security team | SecOps team |
| Agent / AI development | Michael Wood | Kurt Miller (RACI), Stephen | Stephen Dulaney |
| Resource allocation | Roze San Nicolas | Michael Wood | SecOps team |
| GCP access / permissions | Matthew Macaluso | Roze (requestor) | Matthew |

---

## Communication Preferences

| Person | Best Channel | Best Time | Key Prep |
|--------|--------------|-----------|----------|
| Michael Wood | Meeting / direct message | Grab windows -- back-to-back meetings | Concrete examples, agency-wide framing |
| Matthew Macaluso | Direct message | Flexible | Specific access request, not open-ended |
| Stephen Dulaney | Meeting or chat | Available for 15-min sessions | Come with specific questions or requirements |
| Kurt Miller | [TBD] | [TBD] | RACI framework and SecOps role definitions |
| Rose | [TBD] | [TBD] | Policy questions and compliance baseline context |

---

## Escalation Path

*When something needs to go up the chain:*

1. **Roze** -- first line, owns SecOps decisions
2. **Michael Wood** -- escalate for resource, tooling, or agency-wide decisions
3. **[Agency leadership]** -- major risk findings, compliance failures, significant incidents

---

## Update Protocol

Update when:

- Learning new communication preferences or decision styles
- Relationship dynamics change
- Org structure changes
- After significant meetings or negotiations
- New stakeholders enter the picture
