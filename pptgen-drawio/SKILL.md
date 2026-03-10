---
name: pptgen-drawio
description: Generate PowerPoint presentations from draw.io diagrams and content. Use when asked to "create a presentation", "generate slides", "make a PPT", or when converting draw.io diagrams and structured content into professional PowerPoint presentations.
---

# PPT Generator with Draw.io Integration

Generate professional PowerPoint presentations with integrated draw.io diagrams.

## When to Use
- Creating presentations from structured content
- Converting draw.io diagrams into slide decks
- Building technical presentations with architecture diagrams
- Generating pitch decks, reports, or training materials

## Workflow

### 1. Content Structuring
Organize content into slides:
```
Slide 1: Title Slide (title, subtitle, author)
Slide 2-N: Content Slides (title, body, diagrams)
Final Slide: Summary/Q&A
```

### 2. Diagram Integration
- Create draw.io diagrams for technical slides
- Export as SVG/PNG for embedding
- Or use Python `drawio2pptx` for direct conversion

### 3. Generation Methods

#### Method A: Python python-pptx
```python
from pptx import Presentation
from pptx.util import Inches, Pt

prs = Presentation()
slide = prs.slides.add_slide(prs.slide_layouts[1])
title = slide.shapes.title
title.text = "Architecture Overview"

# Add diagram image
slide.shapes.add_picture('diagram.png', Inches(1), Inches(2), Inches(8))

prs.save('presentation.pptx')
```

#### Method B: drawio2pptx
```bash
pip install drawio2pptx
drawio2pptx input.drawio output.pptx
```

### 4. Design Guidelines
- **Font**: Use consistent fonts (Calibri, Arial, or Noto Sans)
- **Colors**: Use a cohesive color palette
- **Layout**: Follow the 6x6 rule (6 lines, 6 words per line)
- **Diagrams**: Center diagrams, use high-resolution exports
- **Consistency**: Same header position and style across slides

### 5. Slide Templates

| Slide Type | Content |
|-----------|---------|
| Title | Project name, subtitle, date, author |
| Agenda | Numbered topic list |
| Content | Title, bullet points, optional diagram |
| Diagram | Full-width draw.io diagram |
| Comparison | Side-by-side before/after |
| Summary | Key takeaways, next steps |
| Q&A | Contact info, discussion prompt |
