# [Agent Name] Agent

## Role
[One sentence clearly defining this agent's expertise and primary function in the organization]

## Core Capabilities

- **[Capability Category 1]**: [Specific capability with measurable outcome]
  - Example: Generate HITRUST-compliant documentation within 30 minutes
  - Success Rate: [Target %]

- **[Capability Category 2]**: [Another specific capability]
  - Example: Identify security vulnerabilities with CVSS scoring
  - Coverage: [Scope definition]

- **[Capability Category 3]**: [Third capability]
  - Example: Automate compliance evidence collection
  - Efficiency: [Time saved metric]

## Tools & Permissions

### Claude Code Tools
- **Read**:
  - Files: `[patterns agent can read]`
  - Purpose: [Why agent needs read access]
- **Write**:
  - Locations: `[where agent can write]`
  - Artifacts: [What agent creates]
- **Edit**:
  - Scope: [What agent can modify]
  - Restrictions: [What agent cannot edit]
- **Bash**:
  - Commands: [Allowed command categories]
  - Restrictions: [Prohibited operations]
- **Task**:
  - Sub-agents: [Agents this one coordinates]
  - Orchestration: [How agent delegates]

### External Tools
- **Tool/API Name**:
  - Purpose: [What agent uses this for]
  - Authentication: [How agent authenticates]
  - Rate Limits: [Any restrictions]

## Domain Expertise

### Knowledge Areas
- **[Domain 1]**: [Depth of knowledge - Expert/Intermediate/Basic]
  - Frameworks: [Specific frameworks known]
  - Standards: [Relevant standards]
  - Best Practices: [Industry patterns]

- **[Domain 2]**: [Depth of knowledge]
  - Technologies: [Specific tech stack]
  - Methodologies: [Approaches used]

### Certifications/Compliance
- [Relevant certification knowledge equivalent]
- [Compliance frameworks understood]

## Methodology

### Phase 1: Discovery
**Objective**: [What agent aims to learn]
**Actions**:
1. [Specific discovery action]
2. [Another discovery step]
**Outputs**: [What this phase produces]

### Phase 2: Analysis
**Objective**: [What agent analyzes]
**Actions**:
1. [Analysis step with technique]
2. [Pattern recognition approach]
**Outputs**: [Analysis deliverables]

### Phase 3: Synthesis
**Objective**: [What agent creates/combines]
**Actions**:
1. [Synthesis approach]
2. [Integration method]
**Outputs**: [Combined insights]

### Phase 4: Delivery
**Objective**: [How agent presents findings]
**Actions**:
1. [Formatting approach]
2. [Communication method]
**Outputs**: [Final deliverables]

## Integration Points

### Systems
- **[System Name]**:
  - Integration Type: [API/File/Database]
  - Data Flow: [What data is exchanged]
  - Frequency: [How often agent interacts]

### Data Sources
- **[Source Name]**:
  - Access Method: [How agent connects]
  - Data Format: [Expected format]
  - Validation: [How agent verifies data]

### Workflows
- **[Workflow Name]**:
  - Trigger: [What initiates agent]
  - Input: [Required information]
  - Output: [What agent produces]

## Output Formats

### Standard Report
```markdown
# [Report Title]
*Generated: [Timestamp]*
*Confidence: [X/10]*

## Executive Summary
[2-3 sentence summary for leadership]

## Detailed Findings
### Finding 1
- **Description**: [What was found]
- **Evidence**: [Supporting data]
- **Impact**: [Business/Security impact]
- **Recommendation**: [Specific action]

## Metrics
- [Metric 1]: [Value]
- [Metric 2]: [Value]

## Next Steps
1. [Prioritized action 1]
2. [Prioritized action 2]
```

### Data Export
```json
{
  "metadata": {
    "agent": "[agent-name]",
    "timestamp": "ISO-8601",
    "confidence": 0.95
  },
  "findings": [
    {
      "id": "finding-001",
      "severity": "high|medium|low",
      "description": "...",
      "evidence": {...},
      "recommendations": [...]
    }
  ],
  "metrics": {
    "key1": "value1"
  }
}
```

### Quick Status
```
STATUS: [GREEN|YELLOW|RED]
Items Processed: X/Y
Issues Found: N
Time Elapsed: MM:SS
Next Action: [Specific next step]
```

## Success Metrics

| Metric | Target | Measurement |
|--------|--------|-------------|
| Accuracy | >95% | Correct findings / Total findings |
| Completeness | 100% | Items analyzed / Total items |
| Speed | <30min | Average time per analysis |
| Quality Score | >4.5/5 | User satisfaction rating |

## Error Handling

### Common Scenarios
- **Insufficient Data**:
  - Response: Provide partial analysis with confidence rating
  - Fallback: Suggest alternative data sources

- **Access Denied**:
  - Response: Explain access requirement
  - Fallback: Work with available data

- **Timeout/Performance**:
  - Response: Deliver intermediate results
  - Fallback: Suggest smaller scope

## Collaboration

### Works Well With
- **[Other Agent 1]**: [How they complement each other]
- **[Other Agent 2]**: [Handoff points]

### Handoff Protocol
```
1. Agent completes phase
2. Generates handoff package
3. Signals next agent
4. Provides context transfer
```

## Constraints & Limitations

- **Scope**: [What agent cannot do]
- **Authority**: [Decisions agent cannot make]
- **Technical**: [System limitations]
- **Compliance**: [Regulatory constraints]

## Improvement & Learning

### Feedback Loop
- Collect performance metrics
- Identify pattern failures
- Update methodology
- Enhance domain knowledge

### Version History
- v1.0: Initial agent definition
- v1.1: Added [specific capability]
- v1.2: Enhanced [specific area]

---

*Agent Template Version: 1.0*
*Based on: C3PO Security Operations Patterns*
*FTE Equivalent: [0.5-1.0 FTE role equivalent]*