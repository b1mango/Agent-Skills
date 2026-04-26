# Agent Skills

AI Agent 通用技能存储仓库。

本仓库只负责保存可复用技能，不负责安装、复制或适配到具体 Agent / IDE。不同 Agent / IDE 应通过各自的提示词或规则读取本仓库，并按自身机制调用对应 skill。

## 使用方式

1. 先读取 `Agent-settings/rules/universal-repos.md`，确认通用仓库体系。
2. 再读取 `Agent-settings/rules/skill-matching-rules.md`，根据用户任务匹配 skill。
3. 进入本仓库对应 skill 目录。
4. 读取该目录下的 `SKILL.md`。
5. 如有 `references/`、`scripts/`、`assets/`，只在任务需要时按需读取或使用。

## 仓库职责

| 内容 | 放置位置 |
|---|---|
| 技能主说明 | `<skill-name>/SKILL.md` |
| 长参考资料 | `<skill-name>/references/` |
| 可执行辅助脚本 | `<skill-name>/scripts/` |
| 输出素材或模板 | `<skill-name>/assets/` |

## Skill 规范

每个 skill 目录应满足：

1. 必须包含 `SKILL.md`。
2. `SKILL.md` frontmatter 建议只保留 `name` 和 `description`，以兼容更多 Agent / IDE。
3. `name` 使用小写字母、数字和连字符。
4. `description` 写清楚能力和触发场景。
5. 正文只保留核心流程，长文档放入 `references/`。
6. 不写入密钥、令牌、密码、Cookie、验证码、私钥等敏感内容。
7. 不写入某个本地机器独有的路径或临时项目状态。

## 技能索引

技能匹配以 `Agent-settings/rules/skill-matching-rules.md` 为准。本 README 只提供仓库入口，避免维护重复索引。

常见入口：

| 场景 | 入口 |
|---|---|
| 代码审查 | `code-reviewer/` |
| Bug 定位与修复 | `fix/` |
| 前端代码审查 | `frontend-code-review/` |
| 前端设计 | `frontend-design/` |
| Web 测试 | `webapp-testing/` |
| 联网访问 | `web-access/` |
| 文档更新 | `update-docs/` |
| 论文写作 | `paper-write/` |
| 技能创建与转换 | `skill-create/`、`skill-prompt-convert/` |

## 代码审查技能

`code-reviewer/` 是当前代码审查主入口。

`code-review-skill/` 只作为旧名称兼容入口保留；新规则和新提示词应优先匹配 `code-reviewer/`。

## 不再维护安装脚本

本仓库不再维护 `setup.ps1`、`setup.sh` 等批量安装脚本。

原因：

1. 通用仓库提示词已经负责让 Agent / IDE 知道如何读取本仓库。
2. 批量复制 skill 会产生本地副本漂移。
3. 不同 Agent / IDE 的调用方式应由对应工具侧提示词或规则处理。
4. 本仓库应作为单一事实源，而不是安装器。

## 与 Agent-settings 的关系

- `Agent-settings/rules/`：放通用规则，例如仓库读取、技能匹配、GitHub 上传、上下文压缩。
- `Agent-settings/memory/`：放对话压缩记忆。
- `Agent-Skills/`：只放技能。