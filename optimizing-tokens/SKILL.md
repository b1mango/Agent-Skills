---
name: optimizing-tokens
description: Toolkit for reducing token usage and cost while maintaining output quality. Use this skill ALWAYS to enforce token-efficient behaviors across all operations. Analyzes token distribution, minimizes context reads, optimizes prompts for directness, structures outputs concisely, and batches operations to avoid redundant context loading.
---

# Optimizing Tokens

减少 token 使用量和成本的综合工具包，同时保持输出质量。

## 核心原则

### 1. 最小化上下文读取
- **只读必要的文件区域**，不要读取整个文件
- 使用 `grep_search` 定位再精确查看，而非浏览整文件
- 对大文件使用 `view_file_outline` 了解结构，仅查看相关函数
- 避免重复读取已知内容

### 2. 精简输出
- **JSON 优于 prose**：结构化数据用 JSON 格式返回
- **表格优于段落**：比较性信息用表格展示
- **列表优于描述**：枚举项用列表而非段落
- 省略客套话和填充短语
- 不要重复用户已知的信息

### 3. 批量操作
- 合并可并行的工具调用到同一批次
- 避免多次小调用，使用一次大调用
- 合并相关的文件编辑到 `multi_replace_file_content`
- 一次性收集所有需要的上下文，不要分多次

### 4. 直接性优先
- 直接给出答案，不要铺垫
- 如果已知解决方案，直接实施
- 减少确认性对话（"让我来看看..."、"接下来我会..."）
- 仅在必要时提问

## Token 优化策略

### 代码操作
```
❌ 低效: 读取整个 500 行文件来修改第 42 行
✅ 高效: 用 grep 找到目标行，只读 40-50 行范围，直接修改

❌ 低效: 分 5 次调用修改同一文件的 5 个不同位置
✅ 高效: 用 multi_replace_file_content 一次完成所有修改

❌ 低效: 先浏览整个文件结构，再逐个查看每个文件
✅ 高效: 用 grep_search 直接搜索关键词定位目标
```

### 输出格式
```
❌ 低效: "我已经完成了对文件的修改，主要变更包括以下几个方面..."
✅ 高效: "已修改 `config.ts`：添加了 `timeout` 配置项。"

❌ 低效: 重复粘贴大段已修改的代码
✅ 高效: 仅展示 diff 或描述关键变更
```

### 研究与探索
```
❌ 低效: 打开每个文件查看内容
✅ 高效: 用 find_by_name + grep_search 精确定位

❌ 低效: 读取文档全文了解一个 API
✅ 高效: 搜索特定函数名或关键词
```

## 自检清单

在每次操作前问自己:
- [ ] 这个文件真的需要完整读取吗？
- [ ] 能否通过搜索直接定位？
- [ ] 这些工具调用能否合并？
- [ ] 输出中是否有冗余信息？
- [ ] 是否在重复已知的上下文？
