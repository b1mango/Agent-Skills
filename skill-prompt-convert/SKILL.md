---
name: skill-prompt-convert
description: Convert prompts and instructions between different AI agent formats. Use when asked to "convert a prompt", "translate a skill", "port a skill", or when migrating skills between Claude Code, Cursor, Copilot, and other AI coding assistants.
---

# Skill Prompt Convert

Convert prompts and skill instructions between different AI agent formats.

## When to Use
- Converting Claude Code skills to Cursor/Copilot format
- Converting Cursor rules to Claude Code skills
- Porting prompts between AI tools
- Standardizing skill formats

## Supported Formats

| Format | File | Location |
|--------|------|----------|
| Claude Code | `SKILL.md` | `.claude/skills/` |
| GitHub Copilot | `SKILL.md` | `.github/skills/` |
| Cursor | `.cursorrules` | Project root |
| Gemini CLI | `SKILL.md` | `.gemini/skills/` |
| Codex | `SKILL.md` | `.codex/skills/` |
| Generic | `AGENTS.md` | Project root |

## Conversion Workflow

### 1. Read Source
- Parse the source format
- Extract: name, description, instructions, examples, scripts
- Identify format-specific features

### 2. Map Features
- Map format-specific directives to target format
- Preserve semantic meaning
- Handle unsupported features gracefully

### 3. Generate Target
- Write in target format with proper frontmatter
- Maintain instruction quality and specificity
- Include all relevant metadata

### 4. Validate
- Verify the converted skill is syntactically correct
- Ensure no critical instructions were lost
- Test that triggers/descriptions match intent

## Conversion Rules

### Claude Code → Gemini CLI
- Keep YAML frontmatter (name, description)
- Keep markdown content as-is
- Scripts in `scripts/` dir work across both
- References in `references/` dir work across both

### Cursor Rules → SKILL.md
- Extract rules from `.cursorrules`
- Create proper YAML frontmatter
- Organize rules into structured sections
- Add trigger description

### Generic AGENTS.md → SKILL.md
- Split into individual skills if multiple capabilities
- Add YAML frontmatter per skill
- Create directory structure
