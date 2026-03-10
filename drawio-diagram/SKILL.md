---
name: drawio-diagram
description: Create and edit draw.io diagrams using XML format. Use when asked to "create a draw.io diagram", "make a flowchart", "design a network diagram", or when generating visual diagrams in draw.io/diagrams.net XML format for architecture, workflows, and system design.
---

# Draw.io Diagram Generator

Create professional diagrams in draw.io XML format for instant browser preview.

## When to Use
- Creating flowcharts, architecture diagrams, network diagrams
- Designing system architecture visually
- Building UML diagrams in draw.io format
- Creating workflow/process diagrams

## Draw.io XML Structure

### Basic Template
```xml
<?xml version="1.0" encoding="UTF-8"?>
<mxfile host="app.diagrams.net">
  <diagram name="Page-1" id="page1">
    <mxGraphModel dx="1422" dy="762" grid="1" gridSize="10">
      <root>
        <mxCell id="0"/>
        <mxCell id="1" parent="0"/>
        <!-- Shapes and connections go here -->
      </root>
    </mxGraphModel>
  </diagram>
</mxfile>
```

### Common Elements

#### Rectangle (Process/Component)
```xml
<mxCell id="2" value="Component" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#dae8fc;strokeColor=#6c8ebf;" vertex="1" parent="1">
  <mxGeometry x="120" y="80" width="120" height="60" as="geometry"/>
</mxCell>
```

#### Arrow (Connection)
```xml
<mxCell id="3" style="edgeStyle=orthogonalEdgeStyle;" edge="1" source="2" target="4" parent="1">
  <mxGeometry relative="1" as="geometry"/>
</mxCell>
```

#### Diamond (Decision)
```xml
<mxCell id="4" value="Decision?" style="rhombus;whiteSpace=wrap;html=1;fillColor=#fff2cc;strokeColor=#d6b656;" vertex="1" parent="1">
  <mxGeometry x="130" y="200" width="100" height="80" as="geometry"/>
</mxCell>
```

## Workflow
1. Understand the diagram requirements
2. Choose appropriate diagram type and style
3. Generate draw.io XML with proper positioning
4. Save as `.drawio` file
5. File can be opened in draw.io/diagrams.net or VS Code draw.io extension

## Style Guide
- Use consistent colors for element types
- Blue (#dae8fc) for processes
- Yellow (#fff2cc) for decisions
- Green (#d5e8d4) for data/storage
- Red (#f8cecc) for errors/alerts
- Maintain consistent spacing (grid-aligned)
- Use orthogonal edge style for clean connections
