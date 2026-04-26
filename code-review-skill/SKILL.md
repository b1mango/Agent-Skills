---
name: code-review-skill
description: Compatibility alias for the canonical code-reviewer skill. Use only when older prompts or users explicitly reference code-review-skill; otherwise prefer Agent-Skills/code-reviewer/SKILL.md for code reviews, PR reviews, diffs, staged or unstaged changes, and systematic analysis of correctness, security, performance, maintainability, and tests.
---

# Code Review Skill

This skill name is kept for backward compatibility.

For new code review tasks, use the canonical skill:

```text
Agent-Skills/code-reviewer/SKILL.md
```

## Compatibility Behavior

When this skill is triggered:

1. Prefer reading `../code-reviewer/SKILL.md` and follow it.
2. If the canonical skill cannot be read, use the fallback checklist below.
3. Do not maintain a separate review style here; keep code review behavior centralized in `code-reviewer`.

## Fallback Checklist

Review in this order:

1. Correctness: logic bugs, edge cases, regressions, async/race issues, error handling.
2. Security: validation, authorization, injection, XSS/CSRF, secret exposure.
3. Data safety: destructive writes, migrations, data loss, permission changes.
4. Performance: inefficient algorithms, N+1 work, excessive rendering, memory leaks.
5. Maintainability: complexity, unclear ownership, brittle abstractions, duplication.
6. Tests: missing regression coverage, weak assertions, flaky tests.

## Fallback Output

Start with findings, ordered by severity. If there are no findings, say so clearly.

```text
## Findings

[P1] file:line - Title
Impact: ...
Why: ...
Fix: ...

## Open Questions

- ...

## Summary

- Overall: approve / request changes / needs discussion
- Tests: ...
```

Severity levels:

- `P0`: critical, must fix immediately.
- `P1`: should fix before merge.
- `P2`: fix soon.
- `P3`: optional improvement.