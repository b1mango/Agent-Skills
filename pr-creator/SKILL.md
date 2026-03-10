---
name: pr-creator
description: Automate creation of high-quality, standardized pull requests. Use when asked to "create a PR", "submit changes", "make a pull request", or when automating code submission workflows. Ensures PRs follow project templates and quality standards.
---

# PR Creator

Create high-quality, standardized pull requests that follow project conventions and best practices.

## When to Use
- User asks to "create a PR" or "make a pull request"
- Automating code submission workflow
- Standardizing PR quality across a team

## PR Creation Workflow

### 1. Pre-flight Checks
Before creating the PR:
- Ensure all changes are committed
- Run linting and formatting: `npm run lint`, `npm run format`
- Run tests: `npm test`
- Check for merge conflicts with target branch
- Verify branch naming convention

### 2. PR Title
Format: `type(scope): description`

Types: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `chore`, `ci`

Examples:
- `feat(auth): add OAuth2 login support`
- `fix(api): handle null response in user endpoint`
- `docs(readme): update installation instructions`

### 3. PR Description Template

```markdown
## What
Brief description of what changed and why.

## Why
Context and motivation for the change.

## How
Technical approach and key decisions.

## Testing
- [ ] Unit tests added/updated
- [ ] Integration tests pass
- [ ] Manual testing performed

## Screenshots (if UI changes)
Before | After

## Checklist
- [ ] Code follows project conventions
- [ ] Self-review completed
- [ ] Documentation updated
- [ ] No breaking changes (or documented)
```

### 4. Create PR Command
```bash
# Using GitHub CLI
gh pr create --title "type(scope): description" --body-file pr_body.md --base main

# Or with labels
gh pr create --title "type(scope): description" --body-file pr_body.md --base main --label "enhancement"
```

### 5. Post-Creation
- Add appropriate labels
- Request reviewers
- Link related issues
- Verify CI checks pass
