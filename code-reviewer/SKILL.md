---
name: code-reviewer
description: Conduct professional and comprehensive code reviews. Use when asked to "review my code", "check this PR", "review changes", or when reviewing local code changes and remote pull requests to ensure correctness, maintainability, and adherence to project standards.
---

# Code Reviewer

Perform thorough, professional code reviews for local changes and pull requests.

## When to Use
- User asks to "review my code" or "review this PR"
- User wants feedback on code quality, correctness, or maintainability
- Reviewing staged/unstaged git changes
- Reviewing pull request diffs

## Review Process

### 1. Gather Context
- Understand the purpose of the changes (commit messages, PR description)
- Identify the scope: which files changed and why
- Check project conventions (linting rules, coding standards, architecture patterns)

### 2. Review Categories

#### Correctness
- Logic errors and edge cases
- Null/undefined handling
- Race conditions and async issues
- Error handling completeness

#### Security
- Input validation and sanitization
- Authentication/authorization checks
- Sensitive data exposure
- SQL injection, XSS, CSRF risks

#### Performance
- Unnecessary re-renders or computations
- N+1 query problems
- Memory leaks
- Inefficient algorithms or data structures

#### Maintainability
- Code clarity and readability
- Naming conventions
- DRY principle adherence
- Proper abstraction levels
- Documentation and comments

#### Testing
- Test coverage for new/changed code
- Edge case coverage
- Test quality and assertions

### 3. Output Format

For each finding, provide:
```
[SEVERITY] file:line - Description
  → Suggestion: How to fix it
```

Severity levels:
- 🔴 **CRITICAL** - Must fix before merge (bugs, security issues)
- 🟡 **WARNING** - Should fix (performance, maintainability)
- 🔵 **INFO** - Nice to have (style, minor improvements)
- ✅ **PRAISE** - Well-done code worth highlighting

### 4. Summary
End with:
- Overall assessment (approve / request changes / needs discussion)
- Top 3 priorities if changes requested
- Positive highlights
