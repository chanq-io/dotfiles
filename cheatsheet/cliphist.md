# Cliphist

Wayland clipboard history manager. Stores text and image clipboard entries.

## Setup

Start watching clipboard (typically in hyprland.conf `exec-once`):

```bash
wl-paste --type text --watch cliphist store     # Store text
wl-paste --type image --watch cliphist store    # Store images
```

## Commands

```bash
cliphist list                   # List all stored entries
cliphist decode                 # Decode an entry from stdin (restore content)
cliphist delete                 # Delete an entry (reads from stdin)
cliphist delete-query <str>     # Delete entries matching string
cliphist wipe                   # Delete all stored entries
```

## Key Flags

| Flag | Description |
|---|---|
| `-max-dedupe-search <n>` | Dedup search depth (default 20) |
| `-max-items <n>` | Max number of items to store (default 750) |
| `-preview-width <n>` | Max characters for list preview |

## Integration with Wofi

```bash
# Select and paste from clipboard history
cliphist list | wofi --show dmenu | cliphist decode | wl-copy

# Hyprland keybind
bind = SUPER, C, exec, cliphist list | wofi --show dmenu | cliphist decode | wl-copy
```

## Integration with Rofi

```bash
cliphist list | rofi -dmenu | cliphist decode | wl-copy
```

## Integration with Fuzzel

```bash
cliphist list | fuzzel --dmenu | cliphist decode | wl-copy
```

## Delete an Entry

```bash
# Interactive delete via wofi
cliphist list | wofi --show dmenu | cliphist delete

# Delete entries containing a string
cliphist delete-query "sensitive text"
```

## Storage Location

Data is stored in `~/.cache/cliphist/db`.

## Startup Config (hyprland.conf)

```
exec-once = wl-paste --type text --watch cliphist store
exec-once = wl-paste --type image --watch cliphist store
```

## Tips

- Images are stored as binary blobs and shown as `[[ binary data ]]` in the list.
- Use `cliphist list | head -20` to see recent entries in the terminal.
- Pipe to `wl-copy` after `cliphist decode` to re-copy the selected item.
- `cliphist wipe` is useful for clearing sensitive data from history.
