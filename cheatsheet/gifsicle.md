# gifsicle

Command-line tool for creating, editing, and optimizing GIF animations.

---

## Key Flags

| Flag | Action |
|------|--------|
| `-O1` | Basic optimization |
| `-O2` | Better optimization |
| `-O3` | Best optimization (slowest) |
| `--resize WxH` | Resize to exact dimensions |
| `--resize-width W` | Resize to width, maintain aspect |
| `--resize-height H` | Resize to height, maintain aspect |
| `--scale FACTOR` | Scale by factor (e.g., `0.5`) |
| `--crop X,Y+WxH` | Crop region |
| `--delay N` | Frame delay in centiseconds (100 = 1s) |
| `--colors N` | Limit color palette (2–256) |
| `--loopcount=N` | Loop count (0 = infinite) |
| `--no-loopcount` | Play once |
| `-o FILE` | Output file |
| `--batch` | Modify files in place |
| `-i` | Ignore errors |
| `--lossy=N` | Lossy compression (higher = smaller) |

## Common Recipes

```bash
# Optimize a GIF
gifsicle -O3 in.gif -o out.gif

# Optimize with lossy compression
gifsicle -O3 --lossy=80 in.gif -o out.gif

# Resize
gifsicle --resize 320x240 in.gif -o out.gif
gifsicle --scale 0.5 in.gif -o out.gif

# Change speed (delay in centiseconds)
gifsicle --delay 5 in.gif -o out.gif     # faster
gifsicle --delay 20 in.gif -o out.gif    # slower

# Reduce colors
gifsicle --colors 64 in.gif -o out.gif

# Crop
gifsicle --crop 10,10+200x150 in.gif -o out.gif

# Extract specific frames
gifsicle in.gif '#0-9' -o first10.gif

# Merge GIFs
gifsicle a.gif b.gif -o combined.gif

# Explode into individual frames
gifsicle --explode in.gif    # creates in.gif.000, .001, etc.

# Reverse
gifsicle in.gif '#-1-0' -o reversed.gif

# Modify in place
gifsicle --batch -O3 *.gif
```
