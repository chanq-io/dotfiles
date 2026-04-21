# Grim + Slurp

Grim: Wayland screenshot tool. Slurp: region selection tool. Used together for flexible screenshots.

## Grim

### Usage

```bash
grim                            # Screenshot all outputs to file
grim screenshot.png             # Screenshot to specific file
grim -g "<geometry>"            # Screenshot a specific region
grim -o <output>                # Screenshot a specific output
```

### Flags

| Flag | Description |
|---|---|
| `-g <geometry>` | Capture region (format: `X,Y WxH`) |
| `-o <output>` | Capture specific output (e.g., `DP-1`, `eDP-1`) |
| `-t <type>` | Image type: `png` (default), `jpeg`, `ppm` |
| `-s <scale>` | Output scale factor |
| `-q <quality>` | JPEG quality (0-100, default 80) |
| `-l <level>` | PNG compression level (0-9) |
| `-c` | Include cursor in screenshot |
| `-` | Write to stdout |

## Slurp

### Usage

```bash
slurp                           # Select a region interactively
slurp -o                        # Select an entire output
slurp -p                        # Select a single pixel (prints color)
```

### Flags

| Flag | Description |
|---|---|
| `-d` | Show dimensions of selection |
| `-b <color>` | Background color (format: `#rrggbbaa`) |
| `-c <color>` | Border color |
| `-s <color>` | Selection color |
| `-B <color>` | Background color outside selection |
| `-w <px>` | Border width |
| `-f <fmt>` | Custom output format |
| `-o` | Select output instead of region |
| `-p` | Select single point |
| `-r` | Require selection (no zero-size) |
| `-a <ratio>` | Force aspect ratio (e.g., `16:9`) |

## Combined Usage

```bash
# Screenshot a selected region
grim -g "$(slurp)" screenshot.png

# Region screenshot to clipboard
grim -g "$(slurp)" - | wl-copy

# Full monitor to clipboard
grim -o DP-1 - | wl-copy

# Screenshot active window (Hyprland)
grim -g "$(hyprctl activewindow -j | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')"

# Screenshot with cursor
grim -c screenshot.png

# Region screenshot with dimensions shown during selection
grim -g "$(slurp -d)" screenshot.png

# Screenshot and open in editor
grim -g "$(slurp)" - | swappy -f -

# Pick a color from screen
slurp -p | grim -g - -t ppm - | convert - -format '%[pixel:p{0,0}]' info:

# Select region with custom appearance
grim -g "$(slurp -b '#00000080' -c '#89b4fa' -w 2 -d)"
```

## Slurp Format Strings

```bash
# Default output format: X,Y WxH
slurp -f "%x %y %w %h"         # Space-separated values
slurp -f "%x,%y %wx%h"         # Default format
slurp -f "%o"                   # Output name under selection
```

## Hyprland Keybind Examples

```
bind = , Print, exec, grim ~/Pictures/Screenshots/$(date +%Y%m%d_%H%M%S).png
bind = SUPER, Print, exec, grim -g "$(slurp)" ~/Pictures/Screenshots/$(date +%Y%m%d_%H%M%S).png
bind = SUPER SHIFT, S, exec, grim -g "$(slurp)" - | wl-copy
bind = SUPER SHIFT, Print, exec, grim -g "$(slurp -d)" - | swappy -f -
```
