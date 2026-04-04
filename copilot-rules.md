# Copilot 工作规则

## 用户仓库体系

| 仓库 | 地址 | 用途 |
|------|------|------|
| Agent-settings | https://github.com/b1mango/Agent-settings | 记忆(memory/)和规则(rules/)仓库，所有 Agent/IDE 共用 |
| Agent-Skills | https://github.com/b1mango/Agent-Skills | 技能(skills/)仓库，所有 Agent/IDE 共用 |
| deepfake-detector | https://github.com/b1mango/deepfake-detector | 当前项目 |

## 可调用的技能列表 (Agent-Skills)

交流中自动匹配以下技能，优先使用本地 `.github/skills/` 目录下的文件（如已安装）：

| 技能 | 触发场景 |
|------|----------|
| code-review-skill | 审查代码质量、正确性、安全性 |
| fix | 系统性 Bug 定位与修复 |
| paper-write | 学术论文写作（匹配本项目论文撰写需求） |
| frontend-design | 前端界面设计（匹配本项目 Web 系统） |
| web-design-guidelines | UI 规范、可访问性检查 |
| webapp-testing | Playwright Web 应用测试 |
| pr-creator | 创建 Pull Request |
| update-docs | 代码变更后同步文档 |
| memory-workflow | 保存对话记忆到 Agent-settings 仓库 |

## 需求到 Skill 的自动判断

当用户不说 skill 名字、只描述需求时，我按下面规则自动判断：

| 用户需求特征 | 优先调用的 skill |
|---|---|
| 代码质量、重构、找 bug、审查文件 | `code-review-skill` 或 `fix` |
| 论文写作、文献整理、章节改写、实验描述 | `paper-write` |
| 前端页面、布局、视觉风格、组件交互 | `frontend-design` |
| UI 规范、可访问性、界面稳定性、风格约束 | `web-design-guidelines` |
| 打开网页验证、联调接口、端到端测试 | `webapp-testing` |
| 需要把文档与代码同步更新 | `update-docs` |
| 保存对话记忆、总结本轮会话、上传 memory | `memory-workflow` |

- 如果一个需求同时命中多个 skill，优先选择“最接近当前目标且最少改动”的那个
- 如果仍然不确定，我会先用最短问题确认一次，不会凭空猜测
- 只要用户给出的描述明显属于上表中的任一类，我就会自动读取对应 skill / workflow，再开始执行

### 常见口语触发词

| 用户常说的话 | 我会优先理解为 |
|---|---|
| “帮我看看这段代码有没有问题”“顺手修一下 bug”“代码规范一下” | `code-review-skill` / `fix` |
| “把论文文献整理一下”“给我找几篇相关论文”“这章帮我改得更像论文” | `paper-write` |
| “这个页面太丑了，帮我改下”“前端排版优化一下”“做个更稳的展示页” | `frontend-design` |
| “这个界面要符合规范”“帮我检查可访问性/一致性” | `web-design-guidelines` |
| “打开页面试一下”“把接口联调通”“看看能不能跑起来” | `webapp-testing` |
| “文档跟代码同步一下”“把说明补上”“更新 README/进度记录” | `update-docs` |
| “把这次对话记下来”“总结一下今天做了什么”“保存记忆” | `memory-workflow` |

- 优先级顺序：**记忆工作流 > 测试/联调 > 代码修复 > 论文写作 > 前端/UI > 文档同步**
- 如果用户一句话里同时有多个意图，我先按“最紧急、最贴近交付”的目标选 skill
- 如果用户特别强调“稳定”“可维护”“别乱改”，我会把 `web-design-guidelines` 和 `code-review-skill` 的权重提高

## 触发与读取原则

- 如果用户指令明显匹配某个技能的用途说明，优先读取该 skill 的说明文件，再开始执行
- 如果用户指令明显属于记忆保存、对话总结、上下文压缩一类，优先读取 `rules/memory-workflow.md` 和已有记忆文件，再按 memory-workflow 执行
- 如果指令同时可能命中多个 skill，先用最贴近目标的 skill；不确定时先简短澄清，不要盲目执行
- 如果用户要求“调用规则文件和工作流文件”“确认是否记住要求”，先读 `rules/copilot-rules.md`、`rules/memory-workflow.md` 和相关 memory，再回答或修改
- 为避免漏触发，用户只要使用“总结对话”“保存记忆”“上传 memory”“代码审查”“前端设计”“Web 测试”“更新文档”等关键词，我都要主动检查是否需要进入对应 skill 流程

## 操作规则

### 1. 每步说明
- 开始每个操作前，用 1-2 句中文简要说明要做什么、为什么做
- 用户的技术水平为零基础，解释要通俗

### 2. 进度记录
- 每完成一轮有意义的改动，将改动追加写入 `项目进度记录.md`
- 格式：时间 + 简述完成内容 + 关键文件路径
- 不要在进度记录中写代码细节，只记"做了什么"

### 3. 下载策略
- 用户网络环境：600M 家庭宽带 + Clash TUN 模式代理（代理带宽约几十兆）
- 国内源（清华/阿里镜像、百度网盘）：直连更快，不走代理
- 国外源（GitHub、PyPI、PyTorch 官方 whl、HuggingFace）：评估是否有国内镜像可替代
- pip 安装：优先尝试国内镜像源（`-i https://mirrors.aliyun.com/pypi/simple/`），PyTorch 除外（必须用官方 index-url）
- 大文件下载前提醒用户预估时间

### 4. 记忆保存
- 只要用户发出“总结对话”“保存记忆”“上传 memory”或同类指令，就视为需要执行 memory-workflow：先压缩本轮对话为 md，再同步到 `https://github.com/b1mango/Agent-settings/tree/main/memory`

### 5. Python 环境
- 本项目使用 `f:\deepfake-detector\venv\` 虚拟环境
- 运行 Python 时始终用 `f:\deepfake-detector\venv\Scripts\python.exe`
- pip 操作始终用 `f:\deepfake-detector\venv\Scripts\pip.exe`
- 若 VSCode 终端激活了 venv，可直接用 `python` / `pip`
