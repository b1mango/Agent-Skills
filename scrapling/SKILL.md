---
name: scrapling
description: 使用 Scrapling 进行高级网页抓取，支持反爬绕过（Cloudflare Turnstile）、隐身浏览、自适应解析、Spider 爬虫框架。适用于被反爬保护的网站、动态内容抓取、批量数据提取等场景。
version: 1.0.0
---

# Scrapling Skill - 高级网页抓取

基于 [Scrapling](https://github.com/D4Vinci/Scrapling) 框架的高级网页抓取技能。

## 何时使用

- 需要绕过 Cloudflare 等反爬保护
- 需要抓取 JavaScript 动态渲染的页面
- 需要隐身浏览器指纹欺骗
- 需要自适应元素追踪（页面结构变化后仍能定位）
- 需要批量爬取多个页面
- 需要会话保持和 Cookie 管理

## 抓取模式

### 1. 快速 HTTP 抓取 (Fetcher)
最快速，适用于无反爬保护的静态页面：

```python
from scrapling.fetchers import Fetcher

page = Fetcher.get('https://example.com/', stealthy_headers=True)
title = page.css('title::text').get()
content = page.css('article').get()
```

### 2. 隐身模式 (StealthyFetcher)
绕过 Cloudflare Turnstile/Interstitial，指纹欺骗：

```python
from scrapling.fetchers import StealthyFetcher

page = StealthyFetcher.fetch(
    'https://protected-site.com/',
    headless=True,
    google_search=False
)
data = page.css('.content').getall()
```

### 3. 动态渲染 (DynamicFetcher)
完整浏览器自动化，支持 Playwright：

```python
from scrapling.fetchers import DynamicFetcher

page = DynamicFetcher.fetch(
    'https://spa-app.com/',
    headless=True,
    network_idle=True
)
data = page.xpath('//div[@class="item"]/text()').getall()
```

### 4. 会话模式 (Session)
保持 Cookie 和状态，适合需要登录或多步操作：

```python
from scrapling.fetchers import FetcherSession, StealthySession

# 快速会话
with FetcherSession(impersonate='chrome') as session:
    page1 = session.get('https://example.com/login')
    page2 = session.get('https://example.com/dashboard')

# 隐身会话
with StealthySession(headless=True, solve_cloudflare=True) as session:
    page = session.fetch('https://protected.com/')
```

### 5. Spider 爬虫
批量并发爬取：

```python
from scrapling.spiders import Spider, Request, Response

class MySpider(Spider):
    name = "my_spider"
    start_urls = ["https://example.com/"]
    concurrent_requests = 10

    async def parse(self, response: Response):
        for item in response.css('.item'):
            yield {
                "title": item.css('h2::text').get(),
                "link": item.css('a::attr(href)').get(),
            }
        next_page = response.css('.next a')
        if next_page:
            yield response.follow(next_page[0].attrib['href'])

result = MySpider().start()
result.items.to_json("output.json")
```

## 选择器支持

- **CSS 选择器**：`page.css('.class::text')`
- **XPath**：`page.xpath('//div/text()')`
- **文本搜索**：`page.find_by_text('搜索文本')`
- **相似元素**：`element.find_similar()`

## 安装依赖

```bash
# 基础安装（仅解析器）
pip install scrapling

# 安装 fetcher 依赖（包含浏览器）
pip install "scrapling[fetchers]"
scrapling install

# 安装 AI/MCP 支持
pip install "scrapling[ai]"

# 安装全部功能
pip install "scrapling[all]"
scrapling install
```

## 运行脚本

本 skill 包含 `scrapling_fetch.py` 辅助脚本：

```bash
# 快速抓取
python scrapling_fetch.py --url "https://example.com"

# 隐身模式
python scrapling_fetch.py --url "https://protected.com" --mode stealthy

# 动态渲染
python scrapling_fetch.py --url "https://spa.com" --mode dynamic

# 指定选择器提取
python scrapling_fetch.py --url "https://example.com" --selector "article h1"

# 输出为 JSON
python scrapling_fetch.py --url "https://example.com" --format json --output result.json

# 批量抓取
python scrapling_fetch.py --urls urls.txt --output results.json
```

## 配置项

| 参数 | 说明 | 默认值 |
|------|------|--------|
| --url | 目标 URL | 必填 |
| --urls | URL 列表文件 | - |
| --mode | 抓取模式 (fast/stealthy/dynamic) | fast |
| --selector | CSS 选择器 | 自动检测 |
| --xpath | XPath 表达式 | - |
| --output | 输出文件路径 | stdout |
| --format | 输出格式 (json/md/text) | md |
| --proxy | 代理地址 | - |
| --wait | 等待时间 (秒) | 0 |
| --retry | 重试次数 | 3 |
| --headless | 无头模式 | true |

## 安全注意

- 遵守 robots.txt 和网站服务条款
- 控制请求频率，避免对目标站点造成压力
- 不要抓取敏感个人信息
- 合理使用隐身模式，仅在必要时启用
