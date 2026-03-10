# /command-name - Brief One-Line Description

## Usage
```
/command-name [required-param] <optional-param>
```

## Purpose
[2-3 sentences explaining when and why to use this command]

## Output Structure

### 1. Primary Output Section
- **Field Name**: Description and format
- **Another Field**: What this contains
- **Status**: Possible values [Active|Inactive|Unknown]

### 2. Secondary Information
| Column | Description | Format |
|--------|-------------|--------|
| Item | What this represents | String/Number/Date |
| Value | The measurement | Format specification |
| Status | Current state | Enum values |

### 3. Summary Section
```json
{
  "summary_field": "value_description",
  "metrics": {
    "metric1": "number",
    "metric2": "percentage"
  }
}
```

## Data Sources

1. **Primary Source**: `path/to/file.md` or system name
   - Confidence: High/Medium/Low
   - Fallback: Alternative if unavailable

2. **Secondary Source**: API or integration point
   - Authentication: Method used
   - Rate limits: Any restrictions

3. **Tertiary Source**: Manual input or calculation
   - Validation: How to verify

## Processing Logic

1. **Gather Phase**
   - Collect data from all sources
   - Validate data quality
   - Handle missing data gracefully

2. **Analysis Phase**
   - Apply domain-specific logic
   - Calculate derived metrics
   - Identify patterns or anomalies

3. **Synthesis Phase**
   - Format according to output structure
   - Apply evidence quality ratings
   - Generate recommendations

## After Running

### Updates Required
- Update `memory/context.md` if priorities changed
- Update `memory/systems.md` if new systems discovered
- Create `workspace/[timestamp]-results.md` with detailed findings

### Trigger Conditions
- If [condition], run `/follow-up-command`
- If critical finding, create alert in `workspace/alerts/`
- If complete, update relevant tracking files

## Error Handling

### Common Issues
| Error | Cause | Resolution |
|-------|-------|------------|
| Data unavailable | Source system down | Use cached data with disclaimer |
| Permission denied | Insufficient access | Request access or use alternative |
| Timeout | Long-running operation | Provide partial results |

### Graceful Degradation
- Missing required param: Prompt user for input
- Partial data: Provide results with confidence rating
- Complete failure: Explain issue and suggest alternatives

## Examples

### Basic Usage
```
/command-name production-system
```
**Output**: Standard analysis of production system

### Advanced Usage
```
/command-name production-system --deep --format=json
```
**Output**: Detailed analysis in JSON format

### Error Case
```
/command-name nonexistent-system
```
**Output**: "System not found. Did you mean: [similar-system]?"

## Integration Points

- **Upstream Commands**: Commands that typically precede this
- **Downstream Commands**: Commands that typically follow
- **Related Commands**: Similar or complementary commands

## Notes

- **Performance**: Expected runtime for typical usage
- **Limitations**: Known constraints or edge cases
- **Dependencies**: Required tools or configurations
- **Security**: Any security considerations

---

*Template Version: 1.0*
*Based on: C3PO Security Operations Best Practices*