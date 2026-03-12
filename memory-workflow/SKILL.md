---
description: Save conversation summary to Antigravity-settings repo. Use when asked to "保存记忆", "上传 memory", "把这次对话总结并上传记忆仓库", or similar intent.
---

# Memory 工作流规则

## 触发条件

当用户说出以下任一表述时触发：
- "把这次对话总结并上传记忆仓库"
- "保存记忆"
- "上传 memory"
- 或任何类似意图的表达

## 执行步骤

1. **摘要撰写**：将本次对话的关键信息压缩为一个 Markdown 文件，包含：
   - 文件开头用一句话 blockquote 总结本次对话主题
   - 用户环境/配置变更
   - 完成的工作事项（附具体配置值和文件路径）
   - 踩坑记录（如有）
   - 用户偏好更新（如有）

2. **文件命名**：`YYYY-MM-DD_HHmm.md`（按对话结束时间），例如 `2026-03-12_0105.md`

3. **文件位置**：保存到 `Antigravity-settings` 仓库的 `memory/` 文件夹

4. **Git 推送**：
   ```bash
   git add -A
   git commit -m "memory: YYYY-MM-DD session summary"
   git push
   ```

## 写作要求

- 简洁，不要废话，纯干货
- 配置值用表格，踩坑用编号列表
- 文件应能让另一台设备上的 AI 助手快速恢复上下文
- 不要包含敏感的 Secret Key，只记 Access Key ID
