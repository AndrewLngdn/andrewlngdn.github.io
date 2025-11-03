# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a GitHub Pages repository (`andrewlngdn.github.io`) hosting interactive educational visualizations and demos. The repository contains standalone HTML files with embedded CSS and JavaScript.

## Project Structure

```
andrewlngdn.github.io/
├── adam_scaling/
│   └── adam_optimizer_toy.html    # Interactive Adam optimizer visualizer
└── README.md
```

## Architecture

### Standalone HTML Applications

Each visualization is a self-contained HTML file with:
- **Embedded CSS**: All styling is included in `<style>` tags
- **Embedded JavaScript**: All logic is in `<script>` tags
- **External CDN dependencies**: Chart.js, KaTeX for math rendering
- **No build process**: Files can be opened directly in a browser

### Adam Optimizer Visualizer

Located at `adam_scaling/adam_optimizer_toy.html`:

**Purpose**: Interactive educational tool demonstrating how the Adam optimization algorithm adapts learning rates based on different gradient patterns.

**Key Components**:
- `AdamOptimizer` class (line 373): Implements the Adam optimization algorithm with first and second moment tracking
- `gradientPatterns` object (line 353): Defines three test patterns (consistent, noisy, oscillating)
- Chart.js integration for real-time visualization of gradient behavior
- KaTeX for rendering mathematical formulas

**Pattern Architecture**: Each gradient pattern creates:
1. A parameter card with visualization
2. An independent optimizer instance
3. A Chart.js chart tracking gradients, momentum (m̂), and second moment (√v̂)
3-stage animation system for smooth updates

## Development Workflow

### Viewing Changes Locally

Open HTML files directly in a browser:
```bash
open adam_scaling/adam_optimizer_toy.html
```

Or use a simple HTTP server:
```bash
python3 -m http.server 8000
# Then navigate to http://localhost:8000/adam_scaling/adam_optimizer_toy.html
```

### GitHub Pages Deployment

Changes pushed to the `main` branch are automatically published to:
- Repository URL: `https://andrewlngdn.github.io/`
- Subdirectory files: `https://andrewlngdn.github.io/adam_scaling/adam_optimizer_toy.html`

No build step is required. Files are served as-is from the repository.

## Adding New Visualizations

When creating new interactive demos:

1. **Create self-contained HTML files**: Include all CSS and JavaScript inline
2. **Use CDN libraries**: Reference external libraries via CDN (Chart.js, D3.js, KaTeX, etc.)
3. **Organize by topic**: Use subdirectories (like `adam_scaling/`) to group related content
4. **Mobile-responsive design**: Include media queries for mobile devices
5. **Mathematical notation**: Use KaTeX for rendering LaTeX equations

## Code Style Patterns

### JavaScript Structure
- Use ES6 classes for optimizer implementations
- Separate configuration (patterns, parameters) from core logic
- Implement async animation loops with `requestAnimationFrame` and setTimeout
- Store visualization state in history arrays with bounded length

### Chart.js Integration
- Configure responsive charts with `maintainAspectRatio: false`
- Use dataset updates with `chart.update()` for smooth transitions
- Implement custom plugins for specialized rendering (e.g., gradient stems)

### CSS Conventions
- CSS Grid for responsive layouts (`repeat(auto-fit, minmax(...)`)
- Flexbox for component alignment
- Mobile-first media queries at 768px breakpoint
- Monospace fonts for numeric values
