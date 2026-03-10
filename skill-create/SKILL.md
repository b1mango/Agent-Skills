---
name: skill-creator
description: Create new skills, modify and improve existing skills, and measure skill performance. Use when users want to create a skill from scratch, edit, or optimize an existing skill, run evals to test a skill, benchmark skill performance with variance analysis, or optimize a skill's description for better triggering accuracy.
---

# Skill Creator

Create, test, and optimize agent skills with structured workflows.

## When to Use
- User wants to create a new skill from scratch
- User wants to edit or improve an existing skill
- User wants to run evaluations to test a skill
- User wants to benchmark skill performance
- User wants to optimize a skill's description for better triggering

## Creating a Skill

### 1. Capture Intent
- What task should this skill automate?
- What triggers should activate this skill?
- What is the expected input and output?

### 2. Interview and Research
- Ask clarifying questions about the domain
- Research existing patterns and best practices
- Identify edge cases and constraints

### 3. Write the SKILL.md

```yaml
---
name: skill-name
description: Clear description of when and how to use this skill. Include trigger phrases.
---
```

Follow with detailed instructions:
- **Context**: When and why to use this skill
- **Workflow**: Step-by-step process
- **Output Format**: Expected output structure
- **Examples**: Concrete usage examples
- **Edge Cases**: How to handle special situations

### Skill Writing Guide
- Be specific and actionable
- Use imperative mood ("Do X", not "You should do X")
- Include concrete examples
- Define clear input/output contracts
- Keep instructions focused on the task

### Test Cases
Create test scenarios to validate:
1. Happy path - normal usage
2. Edge cases - unusual inputs
3. Error handling - invalid inputs
4. Performance - complex scenarios

## Improving a Skill

### How to Think About Improvements
- Read user feedback carefully
- Identify patterns in failures
- Focus on the highest-impact changes first
- Make one change at a time for measurable results

### The Iteration Loop
1. Identify an issue or opportunity
2. Hypothesize a fix
3. Implement the change
4. Test with existing and new test cases
5. Compare results
6. Document what worked

## Description Optimization

### How Skill Triggering Works
The skill description in YAML frontmatter determines when the skill is activated.

### Optimization Steps
1. Generate trigger eval queries - What should activate this skill?
2. Review with user - Confirm expected triggers
3. Run the optimization loop - Test different descriptions
4. Apply the best result
