---
name: update-docs
description: Update project documentation based on code changes. Use when asked to "update docs", "sync documentation", "document changes", or when code changes require documentation updates. Analyzes code diffs and updates existing docs or creates new documentation.
---

# Update Docs

Keep documentation synchronized with code changes.

## When to Use
- After implementing new features
- After modifying existing APIs or interfaces
- When code changes affect user-facing behavior
- User asks to "update docs" or "sync documentation"

## Documentation Update Workflow

### 1. Analyze Changes
- Review git diff to identify what changed
- Categorize changes: new feature, modification, deprecation, removal
- Identify which documentation files are affected

### 2. Update Existing Docs
For each affected documentation file:
- Update descriptions to match new behavior
- Update code examples to reflect changes
- Update configuration options if changed
- Mark deprecated features clearly
- Update API reference (parameters, return types, errors)

### 3. Create New Docs (for new features)
- Add feature description and purpose
- Include usage examples with code snippets
- Document configuration options
- Add troubleshooting section if complex
- Link from relevant existing docs

### 4. Documentation Checklist

#### README.md
- [ ] Installation instructions still accurate
- [ ] Usage examples up to date
- [ ] Configuration options documented
- [ ] Dependencies listed correctly

#### API Documentation
- [ ] New endpoints/functions documented
- [ ] Parameters and return types accurate
- [ ] Error responses documented
- [ ] Authentication requirements noted

#### Changelog
- [ ] Version bumped appropriately
- [ ] Changes categorized (Added, Changed, Fixed, Removed)
- [ ] Breaking changes highlighted
- [ ] Migration guide if needed

### 5. Quality Checks
- Verify all code examples actually work
- Check for broken internal links
- Ensure consistent terminology
- Proofread for clarity and grammar
- Verify formatting renders correctly
