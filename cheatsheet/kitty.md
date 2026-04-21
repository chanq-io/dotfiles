# Kitty

GPU-accelerated terminal emulator.

## Key Shortcuts

### Tabs

| Shortcut | Action |
|---|---|
| `Ctrl+Shift+T` | New tab |
| `Ctrl+Shift+Q` | Close tab |
| `Ctrl+Shift+Right` | Next tab |
| `Ctrl+Shift+Left` | Previous tab |
| `Ctrl+Shift+.` | Move tab forward |
| `Ctrl+Shift+,` | Move tab backward |
| `Ctrl+Shift+Alt+T` | Set tab title |

### Windows (splits)

| Shortcut | Action |
|---|---|
| `Ctrl+Shift+Enter` | New window (split) |
| `Ctrl+Shift+W` | Close window |
| `Ctrl+Shift+]` | Next window |
| `Ctrl+Shift+[` | Previous window |
| `Ctrl+Shift+F7` | Focus visible window |
| `Ctrl+Shift+F8` | Swap with another window |
| `Ctrl+Shift+R` | Resize window mode |

### Layouts

| Shortcut | Action |
|---|---|
| `Ctrl+Shift+L` | Next layout |

### Scrolling

| Shortcut | Action |
|---|---|
| `Ctrl+Shift+Up` | Scroll up |
| `Ctrl+Shift+Down` | Scroll down |
| `Ctrl+Shift+Page_Up` | Scroll page up |
| `Ctrl+Shift+Page_Down` | Scroll page down |
| `Ctrl+Shift+Home` | Scroll to top |
| `Ctrl+Shift+End` | Scroll to bottom |
| `Ctrl+Shift+H` | Browse scrollback in pager |
| `Ctrl+Shift+G` | Browse last command output |

### Font Size

| Shortcut | Action |
|---|---|
| `Ctrl+Shift+Equal` | Increase font size |
| `Ctrl+Shift+Minus` | Decrease font size |
| `Ctrl+Shift+Backspace` | Reset font size |

### Other

| Shortcut | Action |
|---|---|
| `Ctrl+Shift+F5` | Reload config |
| `Ctrl+Shift+F6` | Debug config |
| `Ctrl+Shift+F2` | Edit config in editor |
| `Ctrl+Shift+E` | Open URL hints |
| `Ctrl+Shift+U` | Unicode input |
| `Ctrl+Shift+C` | Copy to clipboard |
| `Ctrl+Shift+V` | Paste from clipboard |
| `Ctrl+Shift+S` | Paste from selection |
| `Ctrl+Shift+F11` | Toggle fullscreen |
| `Ctrl+Shift+Delete` | Reset terminal |

## Kitten Commands

Kittens are small programs that extend kitty's functionality.

```bash
kitty +kitten icat image.png        # Display image in terminal
kitty +kitten diff file1 file2      # Side-by-side diff
kitty +kitten themes                 # Browse and apply themes
kitty +kitten ssh user@host          # SSH with full kitty features
kitty +kitten clipboard              # Advanced clipboard operations
kitty +kitten unicode_input          # Unicode character picker
kitty +kitten hints                  # Select URLs/paths/etc from screen
kitty +kitten transfer file.txt      # Transfer files over SSH
kitty +kitten hyperlinked_grep       # Grep with clickable results
kitty +kitten broadcast              # Type in all windows simultaneously
```

## Config Options

Config file: `~/.config/kitty/kitty.conf`

### Font

```
font_family      JetBrains Mono
bold_font        auto
italic_font      auto
font_size        12.0
```

### Cursor

```
cursor_shape          block        # block, beam, underline
cursor_blink_interval 0.5
cursor_stop_blinking_after 15.0
shell_integration     enabled
```

### Scrollback

```
scrollback_lines         10000
scrollback_pager         less --chop-long-lines --RAW-CONTROL-CHARS +INPUT_LINE_NUMBER
scrollback_pager_history_size 0    # MB, 0 = disabled
```

### Window

```
window_padding_width  5
window_margin_width   0
single_window_margin_width -1
placement_strategy    center
hide_window_decorations yes
confirm_os_window_close 0
enabled_layouts       splits,tall,stack
background_opacity    0.95
```

### Tab Bar

```
tab_bar_edge         bottom
tab_bar_style        powerline    # fade, slant, separator, powerline, custom
tab_powerline_style  slanted
tab_title_template   "{index}: {title}"
active_tab_font_style bold
```

### URLs & Selection

```
url_style         curly
open_url_with     default
detect_urls       yes
copy_on_select    no
```

## Remote Control

Enable in config:

```
allow_remote_control yes
listen_on            unix:/tmp/kitty
```

Then use:

```bash
kitty @ ls                          # List all windows/tabs
kitty @ send-text --match "title:dev" "ls\n"   # Send text to window
kitty @ set-colors background=#1e1e2e           # Change colors
kitty @ launch --type=tab          # Open new tab
kitty @ focus-window --match "title:main"       # Focus window
kitty @ close-window               # Close current window
kitty @ set-font-size 14           # Change font size
kitty @ set-tab-title "Build"      # Set tab title
kitty @ create-marker --match "title:logs" text 1 red ERROR  # Highlight text
```

## Launch Flags

```bash
kitty --title "dev"                 # Set window title
kitty --directory ~/projects        # Set working directory
kitty --session session.conf        # Load session file
kitty -e htop                       # Run command
kitty -o font_size=14               # Override config option
kitty --class floating              # Set window class (for window rules)
```
