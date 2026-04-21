# chafa

Render images as terminal graphics (sixel, kitty, iterm2, symbols).

---

## Basic Usage

```bash
chafa image.png                # auto-detect best method
chafa -s 80x24 image.png      # fit to size (columns x rows)
chafa *.jpg                    # view multiple images
```

## Key Flags

| Flag | Action |
|------|--------|
| `-s WxH` | Size in columns x rows (e.g., `80x40`) |
| `--format=FMT` | Output format (`symbols`, `sixels`, `kitty`, `iterm`) |
| `--animate=BOOL` | Enable/disable animation |
| `--duration=SEC` | Animation duration |
| `-w N` | Work factor (1–9, higher = better quality, slower) |
| `--polite=BOOL` | Don't move cursor (for embedding) |
| `--stretch` | Stretch to fill size |
| `--symbols=SET` | Symbol set (`all`, `block`, `braille`, `ascii`) |
| `--fill=SET` | Fill symbol set |
| `--colors=N` | Max colors (2, 16, 256, `full`) |
| `--color-space=SPACE` | `rgb` or `din99d` |
| `--dither=MODE` | `none`, `ordered`, `diffusion` |
| `--font-ratio=W/H` | Font aspect ratio (e.g., `1/2`) |
| `-c MODE` | Color mode (`full`, `256`, `16`, `2`, `none`) |
| `--bg=COLOR` | Background color |
| `--fg=COLOR` | Foreground color |

## Output Formats

| Format | Terminal Support |
|--------|-----------------|
| `symbols` | Universal (default) |
| `sixels` | xterm, foot, mlterm |
| `kitty` | kitty |
| `iterm` | iTerm2, WezTerm |

```bash
chafa --format=sixels image.png
chafa --format=kitty image.png
```

## Examples

```bash
# High-quality render
chafa -w 9 -s 120x40 photo.jpg

# Braille art
chafa --symbols=braille photo.jpg

# ASCII art
chafa --symbols=ascii -c none photo.jpg

# Fit to terminal width
chafa -s "$(tput cols)x" photo.jpg

# Animated GIF
chafa --animate on animation.gif
```
