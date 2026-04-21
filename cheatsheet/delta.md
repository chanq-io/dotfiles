# Delta Cheatsheet

A syntax-highlighting pager for git, diff, and grep output. Makes diffs readable with side-by-side views, line numbers, and language-aware highlighting.

---

## Installation & Git Integration

Add delta as your pager in `~/.gitconfig`:

```ini
[core]
    pager = delta

[interactive]
    diffFilter = delta --color-only

[delta]
    navigate = true
    side-by-side = true
    line-numbers = true

[merge]
    conflictstyle = diff3

[diff]
    colorMoved = default
```

Once configured, all git commands that produce diffs (`git diff`, `git log -p`, `git show`, `git stash show -p`) automatically use delta.

---

## Key Features

| Feature | Description |
|---------|-------------|
| Syntax highlighting | Language-aware highlighting for 200+ languages via syntect |
| Side-by-side view | Two-column diff layout |
| Line numbers | Configurable line number display |
| Navigate mode | Jump between files in a diff with `n`/`N` |
| Word-level diff | Highlights changed words within lines |
| Git blame | Enhanced `git blame` output |
| Merge conflicts | Colored merge conflict display (with `diff3`) |
| Grep integration | Syntax-highlighted `git grep` output |
| Hyperlinks | Clickable file paths in terminals that support OSC 8 |
| Color moves | Detects moved code blocks |

---

## Configuration Options

All options go in the `[delta]` section of `~/.gitconfig` or in a delta config file.

### Display Layout

| Option | Values | Description |
|--------|--------|-------------|
| `side-by-side` | `true` / `false` | Two-column diff view |
| `line-numbers` | `true` / `false` | Show line numbers |
| `line-numbers-left-format` | format string | Left line number format (default `"{nm:^4}"`) |
| `line-numbers-right-format` | format string | Right line number format |
| `line-numbers-left-style` | style | Style for left gutter |
| `line-numbers-right-style` | style | Style for right gutter |
| `line-numbers-minus-style` | style | Style for removed line numbers |
| `line-numbers-plus-style` | style | Style for added line numbers |
| `line-numbers-zero-style` | style | Style for unchanged line numbers |
| `width` | number / `variable` | Output width (default: terminal width) |
| `max-line-length` | number | Truncate long lines (default: 512) |
| `wrap-max-lines` | number | Max wrapped lines (0 = unlimited) |
| `tabs` | number | Tab width (default: 4) |

### Navigation

| Option | Values | Description |
|--------|--------|-------------|
| `navigate` | `true` / `false` | Enable n/N to jump between files |
| `file-modified-label` | string | Label for modified files |
| `file-added-label` | string | Label for added files |
| `file-removed-label` | string | Label for removed files |
| `file-renamed-label` | string | Label for renamed files |
| `file-style` | style | Style for file header lines |
| `file-decoration-style` | style | File header decoration (e.g., `"ol ul"`) |
| `hunk-header-style` | style | Style for hunk headers |
| `hunk-header-decoration-style` | style | Hunk header decoration |

### Syntax & Colors

| Option | Values | Description |
|--------|--------|-------------|
| `syntax-theme` | theme name | Syntect theme name |
| `dark` | `true` / `false` | Use dark background defaults |
| `light` | `true` / `false` | Use light background defaults |
| `minus-style` | style | Style for removed lines |
| `minus-emph-style` | style | Style for emphasized (changed) parts of removed lines |
| `minus-non-emph-style` | style | Style for non-emphasized parts of removed lines |
| `minus-empty-line-marker-style` | style | Style for removed empty lines |
| `plus-style` | style | Style for added lines |
| `plus-emph-style` | style | Style for emphasized parts of added lines |
| `plus-non-emph-style` | style | Style for non-emphasized parts of added lines |
| `plus-empty-line-marker-style` | style | Style for added empty lines |
| `zero-style` | style | Style for unchanged lines |
| `whitespace-error-style` | style | Highlight trailing whitespace |

### Blame

| Option | Values | Description |
|--------|--------|-------------|
| `blame-format` | format string | Format for `git blame` output |
| `blame-palette` | color list | Background colors for alternating blame groups |
| `blame-separator-format` | format string | Separator between blame entries |
| `blame-timestamp-format` | format string | Timestamp format in blame |

### Other

| Option | Values | Description |
|--------|--------|-------------|
| `paging` | `always` / `never` / `auto` | Pager behavior |
| `hyperlinks` | `true` / `false` | Enable OSC 8 hyperlinks |
| `hyperlinks-file-link-format` | format | Custom hyperlink format (e.g., for editors) |
| `keep-plus-minus-markers` | `true` / `false` | Keep `+`/`-` markers in output |
| `diff-stat-align-width` | number | Alignment for diff stat output |
| `true-color` | `always` / `auto` / `never` | True color support |
| `inspect-raw-lines` | `true` / `false` | Detect raw line changes for emphasis |
| `map-styles` | style map | Remap diff styles (for color-moved support) |

---

## Available Syntax Themes

```bash
# List all available themes
delta --list-syntax-themes

# Preview themes against a diff
delta --show-syntax-themes
```

Common themes:

| Theme | Description |
|-------|-------------|
| `Dracula` | Dark theme |
| `Monokai Extended` | Dark, popular |
| `Nord` | Dark, muted |
| `OneHalfDark` | Dark |
| `OneHalfLight` | Light |
| `Solarized (dark)` | Dark solarized |
| `Solarized (light)` | Light solarized |
| `gruvbox-dark` | Dark gruvbox |
| `gruvbox-light` | Light gruvbox |
| `GitHub` | Light, GitHub-style |
| `ansi` | Uses terminal ANSI colors |
| `base16` | Base16 compatible |

---

## Style Strings

Style strings are space-separated and can include:

| Component | Examples | Description |
|-----------|----------|-------------|
| Foreground | `red`, `"#ff0000"`, `"124"` | Text color |
| Background | `bg:red`, `bg:"#282c34"` | Background color |
| Attributes | `bold`, `italic`, `ul` (underline), `ol` (overline), `strike` | Text attributes |
| Special | `syntax` | Use syntax highlighting for fg |
| Special | `auto` | Auto-detect color |
| Special | `raw` | No processing |
| Special | `omit` | Hide element |
| Special | `normal` | Default terminal style |

### Examples

```ini
# Green text on dark background
plus-style = syntax "#003800"

# Red background for removed, bold emphasis
minus-style = syntax "#3f0001"
minus-emph-style = syntax bold "#901011"

# Line numbers styled
line-numbers-minus-style = "#a04060"
line-numbers-plus-style = "#40a060"
```

---

## Named Profiles (Features)

Define reusable named profiles and activate them:

```ini
[delta]
    features = my-theme

[delta "my-theme"]
    side-by-side = true
    syntax-theme = Dracula
    minus-style = syntax "#3f0001"
    minus-emph-style = syntax bold "#901011"
    plus-style = syntax "#003800"
    plus-emph-style = syntax bold "#006000"
    line-numbers = true
    line-numbers-minus-style = "#a04060"
    line-numbers-plus-style = "#40a060"

[delta "minimal"]
    side-by-side = false
    line-numbers = false
    keep-plus-minus-markers = true
```

Switch profile on the fly:

```bash
git diff | delta --features "minimal"
```

---

## Example Full Configuration

```ini
[core]
    pager = delta

[interactive]
    diffFilter = delta --color-only --features=interactive

[delta]
    navigate = true
    side-by-side = true
    line-numbers = true
    syntax-theme = Monokai Extended
    plus-style = syntax "#003800"
    plus-emph-style = syntax bold "#006000"
    minus-style = syntax "#3f0001"
    minus-emph-style = syntax bold "#901011"
    file-style = bold yellow ul
    file-decoration-style = none
    hunk-header-decoration-style = cyan box ul
    line-numbers-left-style = cyan
    line-numbers-right-style = cyan
    line-numbers-minus-style = red
    line-numbers-plus-style = green
    hyperlinks = true
    tabs = 4

[delta "interactive"]
    keep-plus-minus-markers = false

[merge]
    conflictstyle = diff3

[diff]
    colorMoved = default
```

---

## Command-Line Usage

```bash
# Use delta directly on any diff
diff -u file1 file2 | delta

# Override config options on the fly
git diff | delta --side-by-side --line-numbers

# View with a specific theme
git diff | delta --syntax-theme="GitHub"

# Disable side-by-side for narrow terminals
git diff | delta --side-by-side=false

# Show a diff with no pager
git diff | delta --paging=never
```

---

## Navigation Keys (in less pager)

When `navigate = true`, delta sets `LESS` flags for navigation:

| Key | Action |
|-----|--------|
| `n` | Jump to next file |
| `N` | Jump to previous file |
| `q` | Quit |
| `/pattern` | Search forward |
| `?pattern` | Search backward |
| `g` | Go to top |
| `G` | Go to bottom |
