# 🛠️ Agent Skills

AI Agent 通用技能集合，适用于 OpenClaw / Antigravity 等 Agent 系统。

---

## 📋 技能分类

### 🔍 代码审查

| 技能 | 说明 | 触发关键词 |
|------|------|-----------|
| [code-review-skill](./code-review-skill/) | 结构化代码分析，覆盖正确性、性能、安全性 | `review code`、`check code quality` |
| [code-reviewer](./code-reviewer/) | 专业代码审查 (PR + 本地变更) | `review my code`、`check this PR` |
| [frontend-code-review](./frontend-code-review/) | 前端专用审查 (.tsx/.ts/.vue/.css) | `review frontend code`、`check components` |

### 🏗️ 代码生成与文档

| 技能 | 说明 | 触发关键词 |
|------|------|-----------|
| [codegen-doc](./codegen-doc/) | 从代码自动生成文档 (JSDoc/TypeDoc/Rustdoc) | `generate docs`、`document this code` |
| [codegen-diagram](./codegen-diagram/) | 从代码生成架构图 (Mermaid/PlantUML) | `generate diagram`、`visualize architecture` |
| [drawio-diagram](./drawio-diagram/) | 创建 draw.io XML 格式的流程/架构图 | `create flowchart`、`design diagram` |
| [pptgen-drawio](./pptgen-drawio/) | 从 draw.io 图表生成 PPT 演示文稿 | `create presentation`、`make PPT` |

### 🐛 调试与修复

| 技能 | 说明 | 触发关键词 |
|------|------|-----------|
| [fix](./fix/) | 系统性 Bug 定位与修复流程 | `fix this bug`、`debug this issue` |

### 🎨 前端设计

| 技能 | 说明 | 触发关键词 |
|------|------|-----------|
| [frontend-design](./frontend-design/) | 生产级前端界面设计，避免 AI 模板感 | 构建网页组件、Landing Page、Dashboard |
| [web-design-guidelines](./web-design-guidelines/) | Web 界面规范检查 (可访问性/UX) | `review my UI`、`check accessibility` |
| [vercel-react-best-practices](./vercel-react-best-practices/) | React/Next.js 性能优化指南 | React 组件编写、Next.js 优化 |

### 🧪 测试

| 技能 | 说明 | 触发关键词 |
|------|------|-----------|
| [webapp-testing](./webapp-testing/) | Playwright 驱动的 Web 应用测试 | 前端功能验证、截图、日志查看 |

### 📝 写作

| 技能 | 说明 | 触发关键词 |
|------|------|-----------|
| [paper-write](./paper-write/) | 学术/技术论文写作辅助 | `write a paper`、`draft research paper` |
| [wechat-article-writer](./wechat-article-writer/) | 微信公众号文章撰写与排版 | `write WeChat article` |

### 📦 工程化

| 技能 | 说明 | 触发关键词 |
|------|------|-----------|
| [pr-creator](./pr-creator/) | 标准化 Pull Request 创建 | `create a PR`、`submit changes` |
| [update-docs](./update-docs/) | 根据代码变更同步更新文档 | `update docs`、`sync documentation` |

### ⚙️ 技能管理

| 技能 | 说明 | 触发关键词 |
|------|------|-----------|
| [find-skills](./find-skills/) | 发现和安装新技能 | `find a skill for X` |
| [skill-create](./skill-create/) | 创建/编辑/评测技能 | 创建新 Skill、优化 Skill |
| [skill-prompt-convert](./skill-prompt-convert/) | 在不同 Agent 格式间转换技能 | `convert a prompt`、`port a skill` |
| [skill-vetter](./skill-vetter/) | 技能安全审计 | `vet a skill`、`audit skill security` |

### 🚀 效率优化

| 技能 | 说明 | 触发关键词 |
|------|------|-----------|
| [optimizing-tokens](./optimizing-tokens/) | 减少 Token 消耗，优化输出效率 | 始终自动生效 |

---

## 🚀 快速安装

克隆本仓库后，使用安装脚本一键导入 skills 到目标工具。

```bash
git clone https://github.com/b1mango/Agent-Skills.git
cd Agent-Skills
```

### macOS / Linux

```bash
chmod +x setup.sh

# 安装到指定工具（全局）
./setup.sh antigravity     # → ~/.gemini/skills/
./setup.sh copilot         # → ~/.vscode/skills/
./setup.sh openclaw        # → ~/.openclaw/skills/
./setup.sh claude          # → ~/.claude/skills/

# 一键安装到所有工具
./setup.sh all
```

### Windows (PowerShell)

```powershell
# 安装到指定工具（全局）
.\setup.ps1 antigravity     # → ~/.gemini/skills/
.\setup.ps1 copilot         # → ~/.vscode/skills/
.\setup.ps1 openclaw        # → ~/.openclaw/skills/
.\setup.ps1 claude          # → ~/.claude/skills/

# 一键安装到所有工具
.\setup.ps1 all
```

---

## 📂 项目级安装

如果只想在某个项目中使用这些 skills（而非全局），使用 `--project` 参数：

### macOS / Linux

```bash
# 安装到当前项目
./setup.sh copilot --project

# 安装到指定项目路径
./setup.sh antigravity --project /path/to/project
```

### Windows (PowerShell)

```powershell
# 安装到当前项目
.\setup.ps1 copilot -Project

# 安装到指定项目路径
.\setup.ps1 antigravity -Project -ProjectPath C:\path\to\project
```

项目级安装路径：

| 工具 | 项目路径 | 说明 |
|------|----------|------|
| Antigravity | `.agents/workflows/` | 自动转为 workflow 格式 |
| VS Code Copilot | `.github/skills/` | 直接复制 SKILL.md |
| OpenClaw | `skills/` | 直接复制 SKILL.md |
| Claude Code | `.claude/skills/` | 直接复制 SKILL.md |

> **注意**：Antigravity 项目级安装会自动将 `SKILL.md` 转换为 workflow 格式（`---\ndescription: ...\n---` 的 frontmatter），安装后可通过 `/技能名称` 斜杠命令调用，如 `/fix`、`/code-reviewer`。

---

## 🔧 手动安装（可选）

如果你不想使用安装脚本，也可以手动复制：

<details>
<summary>OpenClaw</summary>

```bash
cp -R ./*/ ~/.openclaw/skills/
```
</details>

<details>
<summary>Antigravity / Gemini CLI（全局）</summary>

```bash
cp -R ./*/ ~/.gemini/skills/
```
</details>

<details>
<summary>VS Code Copilot（通过 settings.json）</summary>

在 `settings.json` 中添加：

```json
{
  "github.copilot.chat.codeGeneration.instructions": [
    { "file": "/path/to/Agent-Skills/frontend-design/SKILL.md" },
    { "file": "/path/to/Agent-Skills/fix/SKILL.md" }
  ]
}
```

或在 Copilot Chat 中用 `#file` 按需加载：

```
#file:code-reviewer/SKILL.md 请审查我当前的代码改动
```
</details>

<details>
<summary>Cursor</summary>

```bash
mkdir -p <项目路径>/.cursor/rules
for d in */; do
  name=$(basename "$d")
  cp "$d/SKILL.md" "<项目路径>/.cursor/rules/${name}.mdc"
done
```
</details>

