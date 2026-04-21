# Hyprshot

Screenshot utility for Hyprland.

## Flags

| Flag | Description |
|---|---|
| `-m <mode>` | Capture mode: `window`, `region`, `output` |
| `-o <dir>` | Output directory for saved screenshots |
| `-f <name>` | Custom filename |
| `--clipboard-only` | Copy to clipboard, do not save to file |
| `-s` / `--silent` | Suppress notifications |
| `-r` / `--raw` | Output raw image data to stdout |
| `-z` | Freeze screen during selection |
| `--now` | Skip selection, capture immediately |

## Modes

| Mode | Description |
|---|---|
| `window` | Click to select a window |
| `region` | Click and drag to select a region |
| `output` | Select an entire monitor |
| `active` | Capture active window (no interaction) |

## Usage Examples

```bash
# Screenshot a window (saves to ~/Pictures/Screenshots by default)
hyprshot -m window

# Screenshot a region
hyprshot -m region

# Screenshot entire monitor
hyprshot -m output

# Region screenshot to clipboard only
hyprshot -m region --clipboard-only

# Save to specific directory with custom name
hyprshot -m window -o ~/screenshots -f myshot.png

# Silent capture (no notification)
hyprshot -m region -s

# Freeze screen during region selection
hyprshot -m region -z

# Pipe raw output
hyprshot -m region -r | swappy -f -
```

## Hyprland Keybind Examples

```
# In hyprland.conf
bind = , Print, exec, hyprshot -m output          # Full monitor
bind = SUPER, Print, exec, hyprshot -m window      # Select window
bind = SUPER SHIFT, Print, exec, hyprshot -m region # Select region
bind = SUPER SHIFT, S, exec, hyprshot -m region     # Common alternative

# Clipboard-only variants
bind = CTRL, Print, exec, hyprshot -m output --clipboard-only
bind = SUPER CTRL, Print, exec, hyprshot -m region --clipboard-only
```

## Default Save Location

Screenshots are saved to `~/Pictures/Screenshots/` by default, or the `XDG_SCREENSHOTS_DIR` if set. The default filename format includes a timestamp.
