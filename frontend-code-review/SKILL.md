---
name: frontend-code-review
description: Automate frontend code reviews for .tsx, .ts, .js, .vue, .css, .scss files. Use when asked to "review frontend code", "check my components", or when reviewing frontend-specific files. Generates structured reports with critical fixes and improvement suggestions.
---

# Frontend Code Review

Specialized code review for frontend files focusing on React/Vue components, TypeScript, CSS, and related technologies.

## When to Use
- Reviewing `.tsx`, `.ts`, `.js`, `.vue`, `.css`, `.scss` files
- User asks for frontend-specific code review
- Checking component quality, accessibility, and performance

## Review Checklist

### Component Architecture
- [ ] Components follow single responsibility principle
- [ ] Props interface is well-defined with TypeScript types
- [ ] Component size is manageable (< 200 lines preferred)
- [ ] Proper separation of concerns (logic vs presentation)
- [ ] No unnecessary prop drilling

### Accessibility (a11y)
- [ ] Semantic HTML elements used correctly
- [ ] ARIA labels on interactive elements
- [ ] Keyboard navigation support
- [ ] Color contrast meets WCAG standards
- [ ] Focus management for modals/dialogs

### Performance
- [ ] Memoization used appropriately (useMemo, useCallback, React.memo)
- [ ] No unnecessary re-renders
- [ ] Images optimized with proper sizing and lazy loading
- [ ] Bundle impact considered (heavy imports avoided)
- [ ] Virtual scrolling for large lists

### CSS / Styling
- [ ] No magic numbers; use design tokens/variables
- [ ] Responsive design with proper breakpoints
- [ ] No `!important` overuse
- [ ] Consistent spacing and sizing system
- [ ] Dark mode compatibility considered

### TypeScript
- [ ] Proper type definitions (avoid `any`)
- [ ] Interface/type exports for reusable types
- [ ] Discriminated unions for complex state
- [ ] Generic types where beneficial
- [ ] Strict null checks handled

### State Management
- [ ] State located at appropriate level
- [ ] No redundant state (derived values computed, not stored)
- [ ] Side effects properly managed in useEffect
- [ ] Loading/error states handled

## Output Format

```markdown
## Frontend Code Review Report

### 🔴 Critical Fixes (must fix)
1. **[file:line]** Description → Fix suggestion

### 🟡 Improvements (should fix)
1. **[file:line]** Description → Fix suggestion

### 🔵 Suggestions (nice to have)
1. **[file:line]** Description → Suggestion

### ✅ Highlights
- Good patterns observed
```
