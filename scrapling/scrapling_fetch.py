#!/usr/bin/env python3
"""
Scrapling Fetch - 基于 Scrapling 的高级网页抓取工具
支持快速抓取、隐身模式、动态渲染、批量抓取
"""

import argparse
import json
import sys
from pathlib import Path
from typing import Optional, Dict, Any, List

try:
    from scrapling.fetchers import Fetcher, StealthyFetcher, DynamicFetcher
    HAS_SCRAPLING = True
except ImportError:
    HAS_SCRAPLING = False

try:
    import html2text
    HAS_HTML2TEXT = True
except ImportError:
    HAS_HTML2TEXT = False


def fetch_page(url: str, mode: str = "fast", headless: bool = True,
               wait: int = 0, proxy: Optional[str] = None,
               retry: int = 3) -> Any:
    """抓取单个页面"""
    if not HAS_SCRAPLING:
        print("❌ 未安装 scrapling，请运行：pip install 'scrapling[all]' && scrapling install")
        sys.exit(1)

    kwargs = {}
    if proxy:
        kwargs['proxy'] = proxy

    for attempt in range(retry):
        try:
            if mode == "stealthy":
                page = StealthyFetcher.fetch(
                    url,
                    headless=headless,
                    google_search=False,
                    **kwargs
                )
            elif mode == "dynamic":
                page = DynamicFetcher.fetch(
                    url,
                    headless=headless,
                    network_idle=True,
                    **kwargs
                )
            else:  # fast
                page = Fetcher.get(
                    url,
                    stealthy_headers=True,
                    **kwargs
                )
            return page
        except Exception as e:
            if attempt == retry - 1:
                raise
            import time
            time.sleep(2 * (attempt + 1))
            print(f"⚠️  重试 ({attempt + 1}/{retry}): {e}")

    return None


def extract_data(page, selector: Optional[str] = None,
                 xpath: Optional[str] = None) -> Dict[str, Any]:
    """从页面提取数据"""
    result: Dict[str, Any] = {
        "title": "",
        "content": "",
        "links": [],
        "images": []
    }

    # 标题
    title_el = page.css('title::text')
    if title_el:
        result["title"] = title_el.get() if hasattr(title_el, 'get') else str(title_el)

    # 内容提取
    if selector:
        elements = page.css(selector)
        if hasattr(elements, 'getall'):
            result["content"] = "\n".join(elements.getall())
        else:
            result["content"] = str(elements) if elements else ""
    elif xpath:
        elements = page.xpath(xpath)
        if hasattr(elements, 'getall'):
            result["content"] = "\n".join(elements.getall())
        else:
            result["content"] = str(elements) if elements else ""
    else:
        # 自动提取正文：优先 article > main > body
        for tag in ['article', 'main', '.content', '#content', 'body']:
            content = page.css(tag)
            if content:
                text = content.get() if hasattr(content, 'get') else str(content)
                result["content"] = text
                break

    # 提取链接
    links = page.css('a')
    if links and hasattr(links, '__iter__'):
        for link in list(links)[:20]:
            href = link.attrib.get('href', '') if hasattr(link, 'attrib') else ''
            text = link.css('::text').get() if hasattr(link, 'css') else str(link)
            if href:
                result["links"].append({"text": text or "", "href": href})

    # 提取图片
    imgs = page.css('img')
    if imgs and hasattr(imgs, '__iter__'):
        for img in list(imgs)[:10]:
            src = img.attrib.get('src', '') if hasattr(img, 'attrib') else ''
            alt = img.attrib.get('alt', '') if hasattr(img, 'attrib') else ''
            if src:
                result["images"].append({"alt": alt, "src": src})

    return result


def to_markdown(data: Dict[str, Any]) -> str:
    """转换为 Markdown 格式"""
    content = data.get("content", "")

    # 如果有 html2text，转换 HTML 为 Markdown
    if HAS_HTML2TEXT and content and "<" in content:
        h = html2text.HTML2Text()
        h.ignore_links = False
        h.ignore_images = False
        h.body_width = 0
        content = h.handle(content)

    md = f"# {data.get('title', '无标题')}\n\n"
    md += f"{content}\n\n"

    if data.get("links"):
        md += "## 链接\n\n"
        for link in data["links"]:
            md += f"- [{link['text']}]({link['href']})\n"

    if data.get("images"):
        md += "\n## 图片\n\n"
        for img in data["images"]:
            md += f"![{img['alt']}]({img['src']})\n"

    return md


def to_text(data: Dict[str, Any]) -> str:
    """转换为纯文本"""
    content = data.get("content", "")

    if HAS_HTML2TEXT and content and "<" in content:
        h = html2text.HTML2Text()
        h.ignore_links = True
        h.ignore_images = True
        h.body_width = 0
        content = h.handle(content)

    return f"{data.get('title', '')}\n\n{content}"


def main():
    parser = argparse.ArgumentParser(description='Scrapling 高级网页抓取工具')
    parser.add_argument('--url', type=str, help='目标 URL')
    parser.add_argument('--urls', type=str, help='URL 列表文件（每行一个）')
    parser.add_argument('--mode', type=str, choices=['fast', 'stealthy', 'dynamic'],
                        default='fast', help='抓取模式：fast(快速)/stealthy(隐身)/dynamic(动态)')
    parser.add_argument('--selector', type=str, help='CSS 选择器')
    parser.add_argument('--xpath', type=str, help='XPath 表达式')
    parser.add_argument('--output', type=str, help='输出文件路径')
    parser.add_argument('--format', type=str, choices=['json', 'md', 'text'],
                        default='md', help='输出格式')
    parser.add_argument('--proxy', type=str, help='代理地址')
    parser.add_argument('--wait', type=int, default=0, help='等待时间 (秒)')
    parser.add_argument('--retry', type=int, default=3, help='重试次数')
    parser.add_argument('--headless', type=bool, default=True, help='无头模式')

    args = parser.parse_args()

    if not args.url and not args.urls:
        parser.print_help()
        sys.exit(1)

    # 收集 URL
    urls: List[str] = []
    if args.url:
        urls.append(args.url)
    if args.urls:
        urls.extend(Path(args.urls).read_text().strip().split('\n'))

    results = []
    for url in urls:
        url = url.strip()
        if not url:
            continue
        print(f"📥 抓取 [{args.mode}]：{url}")
        try:
            page = fetch_page(url, mode=args.mode, headless=args.headless,
                              wait=args.wait, proxy=args.proxy, retry=args.retry)
            data = extract_data(page, selector=args.selector, xpath=args.xpath)
            data['url'] = url
            results.append(data)
            print(f"✅ 成功：{data.get('title', '无标题')[:60]}")
        except Exception as e:
            print(f"❌ 失败：{e}")
            results.append({"url": url, "error": str(e)})

    # 输出
    for result in results:
        if "error" in result:
            continue

        if args.format == 'json':
            output_content = json.dumps(result, ensure_ascii=False, indent=2)
        elif args.format == 'text':
            output_content = to_text(result)
        else:
            output_content = to_markdown(result)

        if args.output:
            if len(results) > 1:
                idx = results.index(result)
                out_path = f"{args.output}.{idx}"
            else:
                out_path = args.output
            Path(out_path).write_text(output_content, encoding='utf-8')
            print(f"💾 已保存：{out_path}")
        else:
            print(output_content)

    if args.output and len(results) > 1 and args.format == 'json':
        Path(args.output).write_text(
            json.dumps(results, ensure_ascii=False, indent=2),
            encoding='utf-8'
        )
        print(f"💾 已保存 {len(results)} 条结果到：{args.output}")


if __name__ == '__main__':
    main()
