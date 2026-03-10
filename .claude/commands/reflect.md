# /reflect - Session Reflection & Learning Codification

Trigger a structured reflection at the end of a significant work session. Captures what happened, what was learned, and whether anything needs to go to leadership or be codified as institutional knowledge.

## Usage

```
/reflect [session-type] [--no-content] [--commit]
```

**Arguments:**

- `session-type`: Label for the session (e.g., `deep-work`, `meeting-debrief`, `research`, `audit-prep`, `incident-response`, `planning`)
- `--no-content`: Skip thought leadership draft
- `--commit`: Auto-commit session log changes

## When to Reflect

**Always after:**

- Major work sessions (>1 hour)
- Important meetings or presentations
- Deep analysis or research
- Any session with significant findings

**Skip for:**

- Quick lookups
- Routine updates

---

## Workflow

### Phase 1: Session Analysis

Examine:

1. Files created or modified during the session
2. Decisions made and their rationale
3. Intelligence gathered about systems, risks, or compliance
4. Research conducted and sources used
5. Any compliance or risk posture changes

### Phase 2: Structured Reflection Questions

**What Worked? (Preserve in System)**

- Which approaches produced useful results?
- What questions unlocked insights?
- What sources proved valuable?

**What Failed? (Document + Fix)**

- What didn't work as expected?
- What assumptions were wrong?
- What would you do differently?

**What Was Learned? (Codify)**

- What's the key insight?
- Is this generalizable to other situations?
- What's the "one thing" takeaway?

**CISO Impact Check:**

- Did this session change the risk posture for any system?
- Were any compliance gaps found or closed?
- Does leadership need to know anything from this session?

### Phase 3: Generate Outputs

#### 1. Session Log

Create `sessions/YYYY-MM-DD_[session-type].md` using `sessions/templates/SESSION_TEMPLATE.md` as the canonical template. Do not deviate from the template structure.

#### 2. Update Learnings

Append to `memory/learnings.md`:

```markdown
## [YYYY-MM-DD] [Session Type]

**Pattern**: [Codified learning]
**Context**: [When this applies]
**Evidence**: [What supports this]
**Confidence**: X/10
```

#### 3. Update Memory Files

Based on session findings, update as needed:

- `memory/context.md` -- new priorities, blockers, or decisions
- `memory/systems.md` -- system status changes, new findings
- `memory/stakeholders.md` -- new relationship intelligence

#### 4. Thought Leadership Draft (optional, skip with --no-content)

If session produced a shareable insight:
Create `content/thought-leadership/DRAFT_[topic].md` using the post template.

## Examples

```
/reflect deep-work --commit
/reflect meeting-debrief --no-content
/reflect audit-prep
/reflect incident-response
```

## The Feedback Loop

```
BUILD -------> SESSION LOG -------> LEARN
  ^                                   |
  |                                   v
APPLY <------- CODIFY <------- REFLECT
```
