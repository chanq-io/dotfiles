# fzf

General-purpose fuzzy finder for the terminal.

---

## Shell Key Bindings

| Key | Action |
|-----|--------|
| `Ctrl+T` | Paste selected file path into command line |
| `Ctrl+R` | Search command history |
| `Alt+C` | cd into selected directory |

## Basic Usage

```bash
fzf                            # pick from stdin (finds files)
cmd | fzf                      # pick from piped input
fzf --query "str"              # start with initial query
fzf --filter "str"             # non-interactive filter
fzf --select-1                 # auto-select if single match
fzf --exit-0                   # exit if no match
```

## Key Flags

| Flag | Action |
|------|--------|
| `-m` / `--multi` | Enable multi-select (Tab/Shift-Tab) |
| `-e` / `--exact` | Exact match (not fuzzy) |
| `--no-sort` | Don't sort results |
| `-i` / `+i` | Case insensitive / sensitive |
| `--tac` | Reverse input order |
| `--height=N%` | Use N% of terminal height |
| `--layout=reverse` | Prompt at top |
| `--border` | Draw border |
| `--preview=CMD` | Preview command |
| `--preview-window=OPTS` | Preview position/size |
| `--delimiter=STR` | Field delimiter |
| `--nth=N` | Match only Nth field |
| `--with-nth=N` | Display only Nth field |
| `--header=STR` | Fixed header line |
| `--prompt=STR` | Custom prompt |
| `--ansi` | Process ANSI color codes |
| `--cycle` | Wrap around list |
| `--bind=BINDS` | Custom key bindings |

## fzf Internal Key Bindings

| Key | Action |
|-----|--------|
| `Enter` | Accept selection |
| `Esc` / `Ctrl+C` | Cancel |
| `Tab` | Toggle selection (multi mode) |
| `Shift+Tab` | Deselect (multi mode) |
| `Ctrl+A` | Select all |
| `Ctrl+D` | Deselect all |
| `Up` / `Down` | Navigate |
| `Ctrl+J` / `Ctrl+K` | Navigate (alt) |
| `PgUp` / `PgDn` | Scroll page |
| `Alt+Up` / `Alt+Down` | Scroll preview |

## Preview

```bash
# File preview with bat
fzf --preview 'bat --color=always {}'

# With window options
fzf --preview 'bat --color=always {}' --preview-window=right:60%:wrap

# Toggle preview with ?
fzf --preview 'bat {}' --preview-window=top:hidden --bind '?:toggle-preview'
```

## Search Syntax

| Token | Match Type |
|-------|-----------|
| `foo` | Fuzzy match |
| `'foo` | Exact match |
| `^foo` | Prefix exact |
| `foo$` | Suffix exact |
| `!foo` | Inverse match |
| `!^foo` | Inverse prefix |
| `foo \| bar` | OR |

## Integration Recipes

```bash
# Open file in editor
vim $(fzf)

# Git branch checkout
git branch | fzf | xargs git checkout

# Kill process
kill -9 $(ps aux | fzf | awk '{print $2}')

# cd into directory
cd $(fd -t d | fzf)

# Search with ripgrep + preview
rg --line-number . | fzf --delimiter=: --preview 'bat --color=always {1} -H {2}'

# Git log browser
git log --oneline | fzf --preview 'git show {1}'
```

## Environment Variables

| Variable | Effect |
|----------|--------|
| `FZF_DEFAULT_COMMAND` | Default command (e.g., `fd --type f`) |
| `FZF_DEFAULT_OPTS` | Default options |
| `FZF_CTRL_T_COMMAND` | Command for Ctrl+T |
| `FZF_ALT_C_COMMAND` | Command for Alt+C |
| `FZF_CTRL_R_OPTS` | Extra opts for Ctrl+R |
