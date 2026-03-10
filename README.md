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

## 使用方式

### OpenClaw

复制到 Skills 目录：

```bash
cp -R ./* ~/.openclaw/workspace/skills/
```

### Antigravity

复制为 Workflow 文件：

```bash
mkdir -p <项目路径>/.agents/workflows
for d in */; do
  name=$(basename "$d")
  cp "$d/SKILL.md" "<项目路径>/.agents/workflows/${name}.md"
done
```

然后通过 `/技能名称` 斜杠命令调用，如 `/fix`、`/code-reviewer`。
