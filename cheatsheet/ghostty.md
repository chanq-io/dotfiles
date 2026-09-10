# Ghostty

GPU-accelerated terminal — the macOS counterpart to kitty on NixOS. Config symlinked from `macos/ghostty/config` (Rose Pine theme, FiraMono Nerd Font).

---

## This Setup

| Setting | Effect |
|---------|--------|
| `theme = Rose Pine` | Color scheme |
| `keybind = shift+enter=text:\n` | `Shift+Enter` sends a literal newline (multiline input in REPLs/Claude Code) |
| `macos-option-as-alt = left` | **Left Option is Alt** (meta keybinds work, right Option still types symbols) |

## Keybindings (macOS defaults)

### Tabs & Windows

| Key | Action |
|-----|--------|
| `Cmd+T` / `Cmd+N` | New tab / window |
| `Cmd+W` | Close surface |
| `Cmd+Shift+[` / `Cmd+Shift+]` | Previous / next tab |
| `Cmd+1`–`Cmd+9` | Go to tab n |

### Splits

| Key | Action |
|-----|--------|
| `Cmd+D` | Split right |
| `Cmd+Shift+D` | Split down |
| `Cmd+Alt+Arrow` | Focus split in direction |
| `Cmd+[` / `Cmd+]` | Previous / next split |
| `Cmd+Shift+Enter` | Zoom (maximize) current split |
| `Cmd+Ctrl+Arrow` | Resize split |

### Other

| Key | Action |
|-----|--------|
| `Cmd+Plus` / `Cmd+Minus` / `Cmd+0` | Font size up / down / reset |
| `Cmd+K` | Clear screen + scrollback |
| `Cmd+Shift+,` | Reload config |
| `Cmd+,` | Open config in editor |
| `Cmd+F` | Search scrollback |

## CLI

```bash
ghostty +show-config                 # current config
ghostty +show-config --default --docs  # all options, documented
ghostty +list-themes                 # built-in themes (interactive preview)
ghostty +list-fonts                  # fonts ghostty can see
ghostty +list-keybinds               # active keybindings
ghostty +list-actions                # bindable actions
```

## Config Notes

- File: `~/.config/ghostty/config` (symlink → `~/.dotfiles/macos/ghostty/config`).
- `key = value` lines; `#` comments on their own line only; empty value resets to default.
- Custom keybind syntax: `keybind = trigger=action`, e.g. `keybind = cmd+s=new_split:right`.
- Most changes apply on reload (`Cmd+Shift+,`); some need new windows or restart.
