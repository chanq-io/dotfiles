# zoxide

Smart `cd` that learns your most-used directories.

---

## Commands

| Command | Action |
|---------|--------|
| `z dirname` | Jump to best-matching directory |
| `z foo bar` | Match directory containing both words |
| `zi` | Interactive selection with fzf |
| `z -` | Jump to previous directory |
| `z ~` | Jump to home |

## Database Management

| Command | Action |
|---------|--------|
| `zoxide add PATH` | Add a directory manually |
| `zoxide remove PATH` | Remove a directory |
| `zoxide edit` | Open database in `$EDITOR` |
| `zoxide query` | List all entries |
| `zoxide query foo` | Show best match for `foo` |
| `zoxide query -l` | List all entries with scores |
| `zoxide query -ls foo` | List matches with scores |
| `zoxide query -i` | Interactive query |

## How Scoring Works

- Each visit increases a directory's score (frecency = frequency + recency)
- Directories visited more recently and more often rank higher
- Entries age out if not visited

## Environment Variables

| Variable | Default | Effect |
|----------|---------|--------|
| `_ZO_DATA_DIR` | `~/.local/share/zoxide` | Database location |
| `_ZO_ECHO` | `0` | Print matched dir before cd |
| `_ZO_EXCLUDE_DIRS` | — | Colon-separated dirs to exclude |
| `_ZO_FZF_OPTS` | — | Custom fzf options for `zi` |
| `_ZO_MAXAGE` | `10000` | Max total score before aging |
| `_ZO_RESOLVE_SYMLINKS` | `0` | Resolve symlinks |

## Shell Init

```bash
eval "$(zoxide init zsh)"
eval "$(zoxide init zsh --cmd cd)"   # replaces cd with zoxide
```
