# Wofi

Wayland-native application launcher and dmenu replacement for wlroots compositors.

## Modes

```bash
wofi --show drun          # Desktop applications (most common)
wofi --show run           # Executable binaries in $PATH
wofi --show dmenu         # Read from stdin (dmenu replacement)
```

## Key Flags

| Flag | Description |
|---|---|
| `--show <mode>` | Launch mode: `drun`, `run`, `dmenu` |
| `--width <px>` | Window width in pixels |
| `--height <px>` | Window height in pixels |
| `--prompt <text>` | Prompt text in search bar |
| `--allow-images` | Show application icons |
| `--insensitive` | Case-insensitive matching |
| `--location <n>` | Window position (0=center, 1-8=edges/corners) |
| `--style <path>` | Path to CSS stylesheet |
| `--color <path>` | Path to color file |
| `--columns <n>` | Number of columns |
| `--lines <n>` | Number of visible lines |
| `--cache-file <path>` | Custom cache file location |
| `--no-actions` | Hide desktop entry actions |
| `--matching <mode>` | `contains`, `multi-contains`, `fuzzy` |
| `--sort-order <order>` | `default`, `alphabetical` |
| `--gtk-dark` | Force dark GTK theme |
| `--define <key=val>` | Override config option |

## Location Values

| Value | Position |
|---|---|
| 0 | Center (default) |
| 1 | Top-left |
| 2 | Top |
| 3 | Top-right |
| 4 | Right |
| 5 | Bottom-right |
| 6 | Bottom |
| 7 | Bottom-left |
| 8 | Left |

## Config Location

- Config: `~/.config/wofi/config`
- Style: `~/.config/wofi/style.css`

### Config File Format

```ini
# ~/.config/wofi/config
show=drun
width=600
height=400
prompt=Search...
allow_images=true
insensitive=true
matching=fuzzy
location=0
columns=1
```

## dmenu Mode Piping

```bash
# Simple selection
echo -e "Option A\nOption B\nOption C" | wofi --show dmenu

# Pipe to command
selected=$(echo -e "shutdown\nreboot\nlogout" | wofi --show dmenu --prompt "Power")

# With cliphist
cliphist list | wofi --show dmenu | cliphist decode | wl-copy

# File picker
find ~/Documents -type f | wofi --show dmenu | xargs xdg-open

# Wifi selector
nmcli -t -f SSID dev wifi | wofi --show dmenu --prompt "WiFi" | xargs nmcli dev wifi connect
```

## Styling (style.css)

```css
/* ~/.config/wofi/style.css */
window {
    margin: 0px;
    border: 2px solid #89b4fa;
    border-radius: 10px;
    background-color: #1e1e2e;
}

#input {
    margin: 5px;
    border: none;
    color: #cdd6f4;
    background-color: #313244;
    border-radius: 5px;
}

#inner-box {
    margin: 5px;
}

#entry:selected {
    background-color: #45475a;
    border-radius: 5px;
}
```
