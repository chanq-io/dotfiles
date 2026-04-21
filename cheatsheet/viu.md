# viu

Fast image viewer for the terminal, written in Rust.

---

## Usage

```bash
viu image.png                  # display image
viu *.jpg                      # display multiple
viu -                          # read from stdin
cat image.png | viu -          # pipe mode
```

## Key Flags

| Flag | Action |
|------|--------|
| `-w N` | Width (in terminal columns) |
| `-h N` | Height (in terminal rows) |
| `-t` | Transparent background |
| `-b` | Use block characters (fallback mode) |
| `-n` | Print filename |
| `-r` | Recursive (view all images in dirs) |
| `-1` | Show one image, wait for keypress |
| `-s` | Use sixel protocol |
| `-k` | Use kitty protocol |
| `--static` | Don't animate GIFs |

## Supported Formats

JPEG, PNG, GIF (animated), WebP, BMP, TIFF, ICO, PNM

## Protocol Support

| Protocol | Flag | Terminal |
|----------|------|----------|
| Kitty | `-k` | kitty |
| Sixel | `-s` | xterm, foot |
| Block chars | `-b` | Universal fallback |
| iTerm | (auto) | iTerm2, WezTerm |

```bash
# Kitty protocol (best quality in kitty terminal)
viu -k image.png

# Force block mode
viu -b image.png

# Resize to fit
viu -w 80 -h 24 image.png
```
