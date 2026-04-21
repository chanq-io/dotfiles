# yazi

Blazing-fast TUI file manager written in Rust.

---

## Navigation

| Key | Action |
|-----|--------|
| `h` / `Left` | Parent directory |
| `l` / `Right` / `Enter` | Open file / enter directory |
| `j` / `k` | Down / Up |
| `J` / `K` | Scroll preview down / up |
| `g g` | Go to top |
| `G` | Go to bottom |
| `~` | Go to home |
| `/` | Go to root |
| `Ctrl+U` / `Ctrl+D` | Half-page up / down |
| `z` | Jump with zoxide |
| `Z` | Jump with fzf |

## File Operations

| Key | Action |
|-----|--------|
| `y` | Yank (copy) selected |
| `x` | Cut selected |
| `p` | Paste |
| `P` | Paste (overwrite) |
| `d` | Trash selected |
| `D` | Permanently delete |
| `a` | Create file/dir (trailing `/` = dir) |
| `r` | Rename |
| `c` | Bulk rename with `$EDITOR` |
| `.` | Toggle hidden files |

## Selection

| Key | Action |
|-----|--------|
| `Space` | Toggle select current |
| `v` | Visual mode (select range) |
| `V` | Select all / deselect all |
| `Esc` | Cancel selection |

## Tabs

| Key | Action |
|-----|--------|
| `t` | New tab |
| `1`–`9` | Switch to tab N |
| `[` / `]` | Previous / next tab |
| `Ctrl+C` | Close tab |

## Marks

| Key | Action |
|-----|--------|
| `m` then key | Set mark |
| `'` then key | Jump to mark |

## Search & Filter

| Key | Action |
|-----|--------|
| `f` | Filter (fuzzy) |
| `s` | Search files (fd) |
| `S` | Search content (rg) |
| `n` / `N` | Next / previous search result |

## Sorting

| Key | Action |
|-----|--------|
| `,m` | Sort by modified |
| `,M` | Sort by modified (reverse) |
| `,n` | Sort by name |
| `,s` | Sort by size |
| `,e` | Sort by extension |

## Shell & Tasks

| Key | Action |
|-----|--------|
| `:` | Open shell command prompt |
| `;` | Run shell command (block) |
| `w` | Show running tasks |

## Config Files

| File | Purpose |
|------|---------|
| `~/.config/yazi/yazi.toml` | General settings |
| `~/.config/yazi/keymap.toml` | Key bindings |
| `~/.config/yazi/theme.toml` | Colors and icons |
| `~/.config/yazi/init.lua` | Custom plugins/logic |
