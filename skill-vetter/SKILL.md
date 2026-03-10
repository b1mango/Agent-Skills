---
name: skill-vetter
description: Security review and audit tool for AI agent skills. Use when asked to "vet a skill", "check skill security", "audit a skill", or when reviewing skills before installation to detect malicious code, unauthorized access, and suspicious patterns.
---

# Skill Vetter

Security review and audit tool for AI agent skills. Checks for potential security risks before skill installation.

## When to Use
- Before installing a new skill from an untrusted source
- User asks to "vet" or "audit" a skill
- Reviewing skill code for security vulnerabilities
- Checking for malicious patterns in skill files

## Security Review Process

### 1. File Analysis
Scan all files in the skill directory:
- `SKILL.md` - Main instruction file
- `scripts/` - Helper scripts
- `references/` - Reference documents
- Any other included files

### 2. Check Categories

#### 🔴 Critical Risks
- **Shell injection**: Commands that could execute arbitrary code
- **File system access**: Unauthorized read/write to sensitive paths
- **Network exfiltration**: Sending data to external servers
- **Credential theft**: Accessing API keys, tokens, passwords
- **Privilege escalation**: Commands requiring elevated permissions

#### 🟡 Medium Risks
- **Broad file permissions**: Overly permissive file access patterns
- **External dependencies**: Downloading scripts from URLs at runtime
- **Environment variable access**: Reading sensitive env vars
- **Hidden obfuscation**: Base64 encoded strings, eval statements

#### 🔵 Low Risks
- **Overly broad instructions**: Instructions that could lead to unintended actions
- **Missing input validation**: No checks on user-provided data
- **Unclear scope**: Ambiguous instructions that could be misinterpreted

### 3. Output Format

```markdown
## Skill Security Report: [skill-name]

### Risk Level: [LOW/MEDIUM/HIGH/CRITICAL]

### Findings
| # | Severity | File | Description |
|---|----------|------|-------------|
| 1 | 🔴 CRITICAL | script.py:15 | Shell injection via user input |
| 2 | 🟡 MEDIUM | SKILL.md:42 | Broad file access pattern |

### Recommendation
[SAFE TO INSTALL / INSTALL WITH CAUTION / DO NOT INSTALL]

### Details
[Detailed explanation of each finding]
```

## Best Practices
- Always vet skills from unknown sources
- Review scripts line by line for suspicious patterns
- Check for obfuscated code
- Verify network access is justified
- Ensure file access is scoped appropriately
