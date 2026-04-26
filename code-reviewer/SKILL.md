---
name: code-reviewer
description: Professional code review workflow for local changes, pull requests, diffs, or pasted code. Use when asked to review code, check PRs, inspect staged or unstaged changes, assess correctness, security, performance, maintainability, tests, or produce actionable findings with severity and file or line references.
---

# Code Reviewer

Use this as the canonical code review skill. It replaces the older `code-review-skill` workflow while preserving its structured review coverage.

## When To Use

- User asks to review code, a PR, a diff, or local changes.
- User asks whether code has bugs, security risks, performance issues, or maintainability problems.
- User wants pre-merge review feedback.
- User wants structured findings with severity and concrete fixes.

## Do Not Use For

- Direct bug fixing without a review request; use `fix` first.
- Frontend visual or UX review; use `frontend-code-review` or `web-design-guidelines` when UI behavior is the focus.
- Documentation-only updates; use `update-docs`.
- Memory or context saving; use `Agent-settings/rules/memory-workflow.md`.

## Review Workflow

### 1. Gather Context

1. Identify the review target: PR, diff, staged changes, unstaged changes, file list, or pasted code.
2. Read project rules and nearby code before judging style or architecture.
3. Understand the intended behavior from issue text, PR description, commit messages, tests, or user notes.
4. Determine risk level: production path, security boundary, data migration, payments, auth, user data, concurrency, or public API.

### 2. Review In Priority Order

Review for issues in this order:

1. Correctness: logic errors, edge cases, regressions, null handling, async/race behavior, error handling.
2. Security: input validation, authz/authn, injection, XSS/CSRF, path traversal, secret exposure, unsafe deserialization.
3. Data safety: data loss, migrations, destructive operations, irreversible writes, permission changes.
4. Performance: algorithmic cost, N+1 queries, excessive re-rendering, memory leaks, avoidable network work.
5. Maintainability: unclear ownership, brittle abstractions, duplicated logic, naming, complexity, project convention drift.
6. Tests: missing coverage for changed behavior, weak assertions, absent regression tests, flaky or over-mocked tests.
7. Documentation: only when docs are required for safe use or changed public behavior.

### 3. Evidence Rules

- Prefer concrete, reproducible findings over broad style opinions.
- Cite file paths and line numbers when available.
- Explain the failure mode and why it matters.
- Suggest a fix or safer direction.
- Do not request changes for harmless preferences.
- If information is missing, list it as an open question, not as a finding.

## Output Format

Start with findings, ordered by severity. If there are no findings, say so clearly.

Use this format:

```text
## Findings

[P0] file:line - Title
Impact: ...
Why: ...
Fix: ...

[P1] file:line - Title
Impact: ...
Why: ...
Fix: ...

## Open Questions

- ...

## Summary

- Overall: approve / request changes / needs discussion
- Main risk: ...
- Tests: ...
```

Severity guide:

- `P0`: must fix immediately; security breach, data loss, build break, severe production outage.
- `P1`: should fix before merge; real bug, important regression, unsafe behavior, missing critical test.
- `P2`: fix soon; maintainability or performance issue with likely cost.
- `P3`: optional improvement; clarity, small cleanup, non-blocking polish.

## Review Quality Bar

- Findings should be few and high signal.
- Do not bury critical issues under long summaries.
- Avoid rewriting the code unless the user asks for implementation.
- Mention positive highlights only after findings, and keep them brief.
- If the review target is large, sample intelligently but disclose limits.
- If tests were not run, say that explicitly.

## Final Check

Before finishing, verify that:

1. Findings are actionable.
2. Severity matches actual risk.
3. Each finding has enough context for another engineer to reproduce or understand it.
4. The response distinguishes confirmed issues from assumptions.
5. The answer does not include secrets or private data from unrelated files.