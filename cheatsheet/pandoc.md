# Pandoc

Universal document converter — markdown, HTML, LaTeX, docx, odt, epub, pdf, and dozens more. Also used by scnvim to render SuperCollider help files.

---

## Basics

Formats are inferred from extensions; override with `-f` (from) and `-t` (to).

```bash
pandoc notes.md -o notes.pdf            # md → pdf (via LaTeX)
pandoc notes.md -o notes.docx           # md → Word
pandoc report.docx -o report.md         # Word → md
pandoc notes.md -s -o notes.html        # md → standalone HTML (-s adds header/css)
pandoc page.html -t gfm -o page.md      # HTML → GitHub-flavored markdown
pandoc ch1.md ch2.md ch3.md -o book.epub  # concatenate → epub
pandoc --list-input-formats             # what it can read
pandoc --list-output-formats            # what it can write
```

## Common Flags

| Flag | Effect |
|------|--------|
| `-s` / `--standalone` | Full document (header + footer), not a fragment |
| `-o <file>` | Output file (format inferred) |
| `-f <fmt>` / `-t <fmt>` | Force input / output format |
| `--toc` | Table of contents |
| `--number-sections` | Numbered headings |
| `-V key=val` | Set template variable (`-V geometry:margin=2cm`, `-V fontsize=12pt`) |
| `--template <file>` | Custom template |
| `--css <file>` | CSS for HTML output |
| `--metadata title="..."` | Set metadata |
| `--pdf-engine=<engine>` | `pdflatex` (default), `xelatex` (unicode/fonts), `typst`, `wkhtmltopdf` |
| `--highlight-style <style>` | Code highlighting (`pygments`, `kate`, `monochrome`…) |
| `--extract-media <dir>` | Pull embedded images out of docx/epub |
| `--citeproc` | Process citations (`--bibliography refs.bib`) |

## PDF Notes

PDF output goes through LaTeX — needs a TeX distribution on PATH. Useful defaults:

```bash
pandoc notes.md -o notes.pdf \
  -V geometry:margin=2.5cm -V fontsize=11pt --pdf-engine=xelatex
```

## Slides

```bash
pandoc slides.md -t beamer -o slides.pdf     # LaTeX beamer
pandoc slides.md -t revealjs -s -o slides.html  # reveal.js
```

`#` headings start new slides; `---` forces a slide break.

## Markdown Extensions

Pandoc markdown supports tables, footnotes `[^1]`, definition lists, fenced divs `::: {.class}`, citations `[@key]`, and YAML metadata blocks:

```markdown
---
title: My Doc
author: Pierre
date: 2026-09-10
---
```

Enable/disable per-extension: `-f markdown+emoji-smart`.
