---
name: code-review-skill
description: Comprehensive code review skill with structured analysis and actionable feedback. Use when asked to "review code", "check code quality", or when performing systematic code analysis for correctness, performance, security, and maintainability.
---

# Code Review Skill

Comprehensive, structured code review with actionable feedback and severity-based prioritization.

## When to Use
- Reviewing pull requests or code changes
- User asks for code quality feedback
- Systematic code analysis before deployment
- Learning and mentoring through code review

## Review Framework

### Phase 1: Understanding
1. Read the code to understand its purpose
2. Identify the scope of changes
3. Check for related documentation/tests

### Phase 2: Analysis Dimensions

#### Correctness
- Does the code do what it's supposed to?
- Are edge cases handled?
- Is error handling complete?
- Are there off-by-one errors?

#### Performance
- Are there unnecessary computations?
- Is memory usage optimal?
- Are there potential bottlenecks?
- Could caching help?

#### Security
- Input validation present?
- SQL injection / XSS / CSRF protection?
- Authentication and authorization checks?
- Sensitive data handling?

#### Maintainability
- Is the code readable?
- Are naming conventions followed?
- Is complexity manageable?
- Are there proper abstractions?

#### Testing
- Are critical paths tested?
- Are edge cases covered?
- Are tests meaningful (not just coverage)?

### Phase 3: Report

```
## Code Review Summary

**Overall: [APPROVE / REQUEST CHANGES / NEEDS DISCUSSION]**

### 🔴 Critical (X issues)
- [file:line] Issue description → Suggested fix

### 🟡 Important (X issues)
- [file:line] Issue description → Suggested fix

### 🔵 Suggestions (X items)
- [file:line] Improvement → How to improve

### ✅ Positive Highlights
- Well-structured error handling in X
- Good use of design pattern Y
```
