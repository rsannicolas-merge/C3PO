# Claude Code Best Practices Guide
*Extracted from C3PO Security Operations Implementation*
*Version: 1.0 - March 2026*

## Executive Summary

This guide consolidates Claude Code best practices observed in the C3PO security operations platform. These patterns enable building specialized, domain-focused Claude Code implementations that function as "digital employees" rather than generic assistants.

---

## 1. Directory Structure Pattern

### Recommended Project Layout

```
project-root/
├── CLAUDE.md                    # Master personality & behavior definition
├── .claude/
│   ├── commands/               # Slash commands (one per file)
│   ├── agents/                 # Specialized agents
│   └── settings.local.json     # Hook configurations
├── memory/                     # Persistent context system
│   ├── context.md             # Current priorities
│   ├── systems.md             # Asset/system registry
│   ├── learnings.md           # Accumulated insights
│   └── stakeholders.md        # Relationship tracking
├── sessions/                   # Session logs & reflections
│   └── templates/             # Session templates
├── systems/                    # System documentation
├── workspace/                  # Active work & investigations
└── content/                    # Deliverables & communications
```

### Key Principles

1. **Purpose-Driven Directories**: Each directory serves a specific workflow function
2. **Separation of Concerns**: Commands, agents, memory, and work are isolated
3. **Template-Based Organization**: Templates guide consistent documentation

---

## 2. CLAUDE.md Master Prompt Pattern

### Essential Sections

```markdown
# CLAUDE.md -- [Domain] Command Center

## Principle 0: [Core Operating Principle]
[Non-negotiable rule that supersedes all others]

## Your Personality
[Specific role, not generic assistant]

## Identity & Context
**Organization**: [Company/Agency]
**Role**: [Specific title]
**User**: [Primary user]
**Purpose**: [Clear mission statement]

## Memory System
[How memory files work, when to read/update]

## Workflows
[Domain-specific workflows and commands]

## Domain Context
[Industry vocabulary, tools, metrics]

## Communication Standards
[Evidence quality levels, confidence scoring]

## Hook Configuration
[PostToolUse hooks for automation]
```

### Best Practice: FTE Equivalence Framing

Define AI capabilities as "digital employees" with specific job functions:

```markdown
This kit is designed to generate the equivalent of 1-5 FTEs of capacity:
- **FTE 1 -- Documentation Agent**: [Specific function]
- **FTE 2 -- Compliance Agent**: [Specific function]
- **FTE 3 -- Risk Intelligence Agent**: [Specific function]
```

---

## 3. Command Structure Template

### Standard Command Format

```markdown
# /command-name - Brief Description

## Usage
```
/command-name [required-param] [optional-param]
```

## Output Structure
### 1. Section Name
- **Field**: Description
- **Format**: Specific format specification
- **Example**: Concrete example

### 2. Another Section
[Table/JSON/Text format specification]

## Data Sources
1. Primary source (confidence level expected)
2. Secondary source (fallback if primary unavailable)
3. External integration (API/service)

## Processing Steps
1. Gather data from sources
2. Apply domain logic
3. Format output according to specification
4. Update relevant memory files

## After Running
- Update `memory/[file].md` if [condition]
- Create `workspace/[output].md` with results
- Trigger `/next-command` if [condition]

## Examples
```
/command-name production-system
# Returns: Structured analysis of production system
```

## Error Handling
- **Missing data**: Report gaps with confidence level
- **Access denied**: Suggest alternative data sources
- **Timeout**: Provide partial results with disclaimer
```

---

## 4. Agent Design Template

### Specialized Agent Structure

```markdown
# [Agent Name] Agent

## Role
[One sentence defining expertise and primary function]

## Core Capabilities
- [Specific capability with example use case]
- [Another capability with metric/threshold]

## Tools
- **Read**: [Specific files/patterns this agent reads]
- **Write**: [What this agent creates/updates]
- **Bash**: [Commands this agent executes]
- **Task**: [Sub-agents this agent coordinates]

## Domain Expertise
- [Specific knowledge area with depth indicator]
- [Frameworks/standards this agent knows]
- [Industry patterns recognized]

## Methodology
1. **Phase 1 - Discovery**: [What agent does first]
2. **Phase 2 - Analysis**: [How agent processes data]
3. **Phase 3 - Synthesis**: [How agent generates insights]
4. **Phase 4 - Delivery**: [Output format and follow-up]

## Integration Points
- **System A**: [How agent interacts, what data exchanged]
- **API B**: [Authentication method, endpoints used]
- **Tool C**: [Command syntax, expected output]

## Output Formats
### Standard Report
```markdown
## Executive Summary
[Key findings in 2-3 sentences]

## Analysis
[Detailed findings with evidence]

## Recommendations
1. [Specific action with timeline]
```

### Data Export
```json
{
  "timestamp": "ISO-8601",
  "agent": "agent-name",
  "findings": []
}
```

## Success Metrics
- [Metric 1]: Target value
- [Metric 2]: Threshold
```

---

## 5. Memory System Best Practices

### Memory File Categories

| Category | Purpose | Read Trigger | Update Trigger |
|----------|---------|--------------|----------------|
| **Context** | Current priorities, active work | Session start | Priority changes |
| **Registry** | Systems, assets, inventory | Before system work | After discovery |
| **Learnings** | Patterns, what works/doesn't | Before similar task | After reflection |
| **Relationships** | People, teams, preferences | Before communication | New intel |

### Memory File Template

```markdown
# [Category] - [Purpose]
*Last Updated: YYYY-MM-DD*
*Owner: [Role]*

## Current State
[Active/current information]

## Historical Context
[Relevant background]

## Patterns & Insights
[Learned patterns from experience]

## Action Items
- [ ] [Pending action with date]
- [x] [Completed action]

## Notes
**Data Quality**: [Confidence level and source quality]
**Last Review**: [Date]
**Next Review**: [Date]
```

### Update Protocol

```python
# Pseudo-code for memory updates
if significant_change_detected():
    backup_current_memory()
    update_relevant_sections()
    add_timestamp_and_trigger()
    cross_reference_other_memory_files()
```

---

## 6. Session Management & Reflection

### Session Template

```markdown
# Session: [Type] - [Brief Description]
*Date: YYYY-MM-DD*
*Duration: [Estimated time]*

## Objective
[What we're trying to accomplish]

## Executive Summary
[2-3 sentence outcome summary]

## What Happened
### Phase 1: [Activity]
- **Action**: [What was done]
- **Result**: [What happened]
- **Evidence Quality**: [Verified/Corroborated/Reported]

## Key Findings
1. **[Finding Category]**: [Specific finding]
   - Evidence: [Source]
   - Confidence: [X/10]
   - Impact: [Business impact]

## What Worked
- **[Technique/Approach]**: [Why it was effective]

## What Didn't Work
- **[Failed Approach]**: [Why it failed, lesson learned]

## Learnings
1. **[Generalizable Pattern]**
   - Context: [When this applies]
   - Approach: [What to do]
   - Confidence: [X/10]

## Next Actions
- [ ] [Specific action] - Owner: [Role] - Due: [Date]
- [ ] [Another action] - Owner: [Role] - Due: [Date]

## Artifacts Created
- `path/to/file.md` - [Description]
- `path/to/another.json` - [Description]
```

### Reflection Command

```markdown
/reflect [session-type] [--no-content] [--commit]

Triggers:
1. Analyze current session
2. Extract learnings
3. Update memory/learnings.md
4. Generate session log
5. Identify follow-up actions
```

---

## 7. Evidence Quality Standards

### Five-Tier Classification

```markdown
## Evidence Quality Levels

1. **Verified** ✓✓✓
   - Confirmed with primary source
   - Example: Checked actual GCP console

2. **Corroborated** ✓✓
   - Multiple independent sources agree
   - Example: Jira + GitHub + Logs confirm

3. **Reported** ✓
   - Single credible source
   - Example: Team member account

4. **Speculative** ⚠️
   - Logical inference without direct evidence
   - Example: Based on patterns, likely true

5. **Unknown** ❓
   - Insufficient information
   - Example: No data available
```

### Output Format Standard

```markdown
## Analysis Results

**Bottom Line Up Front**: [Key insight in 1-2 sentences]

**Supporting Evidence**:
- Finding 1 (Verified ✓✓✓): [Specific evidence]
- Finding 2 (Reported ✓): [Source statement]
- Finding 3 (Speculative ⚠️): [Logical reasoning]

**Confidence Level**: 7/10
- Justification: [Why this confidence level]

**Recommended Action**: [Specific next step]

**Open Questions**:
- [ ] [What we still don't know]
- [ ] [Information needed]
```

---

## 8. Domain Integration Patterns

### Deep Domain Specialization

Instead of generic tools, create domain-specific implementations:

```markdown
## Domain-Specific Elements

### Vocabulary & Metrics
- Industry-specific terms with definitions
- Key metrics with thresholds
- Compliance frameworks referenced

### Workflow Integration
- Commands map to actual job functions
- Outputs match required deliverable formats
- Integrations with domain tools

### Communication Adaptation
- Use domain language and acronyms
- Reference relevant standards
- Format for expected audiences

### Example: Security Operations
- Commands generate HITRUST evidence
- Risk scoring uses NIST methodology
- Outputs formatted for SOC teams
- Integrates with SIEM platforms
```

---

## 9. Hook Configuration

### PostToolUse Automation

```json
{
  "PostToolUse": [
    {
      "matcher": "Write|Edit",
      "hooks": [
        {
          "type": "command",
          "command": "formatter_command || true"
        }
      ]
    },
    {
      "matcher": "Bash",
      "hooks": [
        {
          "type": "command",
          "command": "security_check || true"
        }
      ]
    }
  ]
}
```

---

## 10. Anti-Patterns to Avoid

### Common Mistakes

1. **Generic Assistant Syndrome**
   - ❌ "I'm here to help with anything"
   - ✅ "I'm your Security Operations AI specialist"

2. **Unstructured Memory**
   - ❌ Single context file with everything
   - ✅ Categorized memory with clear triggers

3. **Vague Commands**
   - ❌ `/help` with generic options
   - ✅ `/system-brief` with specific output format

4. **Missing Evidence Quality**
   - ❌ "The system is secure"
   - ✅ "The system is secure (Verified ✓✓✓ via pen test report)"

5. **No Learning Loop**
   - ❌ Complete task and move on
   - ✅ Complete, reflect, update learnings, apply next time

---

## Implementation Checklist

### Setting Up a New Claude Code Project

- [ ] Create directory structure following pattern
- [ ] Write CLAUDE.md with personality and domain context
- [ ] Define FTE equivalents for capability framing
- [ ] Create memory files with update triggers
- [ ] Build first 3-5 domain-specific commands
- [ ] Design specialized agents for key workflows
- [ ] Implement evidence quality standards
- [ ] Set up session templates
- [ ] Configure PostToolUse hooks
- [ ] Create /reflect command for learning loop
- [ ] Test with domain-specific scenarios
- [ ] Document learnings in memory/learnings.md

---

## Metrics for Success

### Measuring Claude Code Effectiveness

```markdown
## Quantifiable Metrics

1. **Task Completion Rate**
   - Formula: Completed tasks / Total requested
   - Target: > 90%

2. **Evidence Quality Score**
   - Formula: (Verified * 3 + Corroborated * 2 + Reported) / Total
   - Target: > 2.0

3. **Time Savings (FTE Equivalent)**
   - Formula: Human hours saved / 2080 (annual hours)
   - Target: 1+ FTE equivalent

4. **Learning Accumulation**
   - Formula: New patterns in learnings.md per month
   - Target: 10+ patterns/month

5. **Integration Effectiveness**
   - Formula: Automated workflows / Total workflows
   - Target: > 70%
```

---

## Advanced Patterns

### Multi-Agent Orchestration

```markdown
## Coordinating Multiple Agents

/orchestrate [objective]
  ├── Agent 1: Discovery
  ├── Agent 2: Analysis
  ├── Agent 3: Synthesis
  └── Agent 4: Delivery

Each agent:
- Has specific expertise
- Passes structured data to next agent
- Updates shared workspace
- Contributes to final deliverable
```

### Adaptive Memory System

```markdown
## Self-Organizing Memory

- Auto-archive stale information
- Promote frequently accessed data
- Cross-reference related memories
- Generate memory health reports
```

---

## Conclusion

These patterns enable Claude Code to function as a true "digital employee" rather than a chat assistant. The key is deep domain integration, structured workflows, persistent learning, and evidence-based operations.

**Remember**: The goal is not to build a generic tool, but a specialized capability that provides measurable value equivalent to human FTEs in your specific domain.

---

*For C3PO-specific implementation details, refer to the source files in /Users/rsannicolas/Documents/GitHub/C3PO/*