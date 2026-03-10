# /grc-engineer - Apply GRC Engineering Principles

## Usage
```
/grc-engineer [analyze|design|automate] <target>
```

## Purpose
Apply GRC Engineering principles to transform manual GRC processes into engineered solutions. Move from compliance theater to engineered assurance using the three pillars: Reality before compliance, Outcomes before tools, Process before automation.

## Output Structure

### 1. Current State Analysis
- **Process Type**: Manual/Semi-automated/Automated
- **Maturity Level**: 1-5 scale per GRC Engineering
- **Pain Points**: Specific inefficiencies identified
- **Automation Potential**: Deterministic/AI-augmented/Autonomous

### 2. Engineering Approach
| Principle | Current State | Target State | Implementation |
|-----------|--------------|--------------|----------------|
| Reality before compliance | Framework-driven | Threat-driven | [Specific steps] |
| Outcomes before tools | Tool-first | Outcome-first | [Metrics to track] |
| Process before automation | Automating broken | Optimized process | [Process fixes] |

### 3. Automation Strategy
```yaml
type: [Deterministic|AI-Augmented|Autonomous]
current_tools: [Existing tools/scripts]
proposed_architecture:
  collect: [Data sources]
  analyze: [Processing method]
  execute: [Action steps]
metrics:
  before: [Current metrics]
  after: [Expected improvement]
```

## Data Sources

1. **Process Documentation**: `workspace/`, `systems/` directories
2. **Current Automation**: Scripts in `scripts/`, workflows in `workflows/`
3. **GRC Principles**: `memory/grc-engineering-principles.md`
4. **Risk Philosophy**: `memory/grc-philosophy.md`

## Processing Logic

1. **Analyze Phase**
   - Map current process flow
   - Identify manual touchpoints
   - Calculate coordination costs
   - Assess API availability

2. **Design Phase**
   - Apply "shift left" principle
   - Design for practitioner needs
   - Plan iterative improvements
   - Define success metrics

3. **Automate Phase**
   - Choose appropriate automation type
   - Build with scale in mind
   - Implement telemetry
   - Enable continuous improvement

## After Running

### Updates Required
- Update `memory/learnings.md` with new patterns discovered
- Create `workspace/grc-engineering-[target].md` with detailed plan
- Update relevant system documentation if process changes

### Trigger Conditions
- If process is broken, fix before automating
- If no clear outcome defined, run `/define-outcomes` first
- If purely deterministic, create script in `scripts/`
- If AI-augmented needed, design hybrid workflow

## Examples

### Basic Analysis
```
/grc-engineer analyze vendor-risk-assessment
```
**Output**: Analysis showing manual CSV uploads could be deterministic API integration

### Design New Process
```
/grc-engineer design continuous-compliance-monitoring
```
**Output**: Shift-left design moving compliance checks into CI/CD pipeline

### Automate Workflow
```
/grc-engineer automate evidence-collection
```
**Output**: Hybrid workflow with deterministic collection + AI analysis

## Integration Points

- **Upstream**: `/system-brief` for current state understanding
- **Downstream**: `/implement-automation` for execution
- **Related**: `/risk-assessment`, `/compliance-check`

## GRC Engineering Checklist

Before automating, verify:
- [ ] Problem has been questioned and validated
- [ ] Process has been optimized (not just digitized)
- [ ] Outcomes are defined with metrics
- [ ] Reality-based controls exist (not framework hopefuls)
- [ ] Engineering team can implement the solution
- [ ] Telemetry is built in for continuous improvement

## Anti-Patterns to Detect

| Anti-Pattern | Detection | Resolution |
|--------------|-----------|------------|
| Framework-first design | Starts with compliance requirements | Pivot to threat identification |
| Tool obsession | Tool selected before outcome defined | Define success metrics first |
| Automation theater | Automating broken process | Fix process, then automate |
| Perfect API assumption | Expects everything automated | Plan for 90% manual reality |
| Complexity worship | Overly complex for simple problem | Simplify to appropriate level |

## Maturity Assessment

### Level 1: Manual Processes
- Document-heavy
- No automation
- Reactive compliance

### Level 2: Basic Automation
- Scripts for repetitive tasks
- Scheduled reports
- Some evidence collection

### Level 3: AI-Augmented (C3PO Current)
- Hybrid workflows
- Intelligent analysis
- Proactive monitoring

### Level 4: Autonomous Systems
- Self-healing controls
- Predictive adjustments
- Minimal human intervention

### Level 5: Predictive GRC
- Prevents issues before they occur
- Continuous optimization
- Full engineering integration

## Notes

- **Philosophy**: Engineering mindset > compliance mindset
- **Focus**: Build what works, translate to auditor language second
- **Scale**: Design for enterprise heterogeneity, not startup simplicity
- **Accessibility**: PowerAutomate and spreadsheets are valid GRC Engineering

---

*"Question the problem before solving it. Optimize the process before automating it."*
*— GRC Engineering Principle*