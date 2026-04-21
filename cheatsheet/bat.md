# bat — Cat with Syntax Highlighting

A `cat` clone with syntax highlighting, Git integration, and automatic paging.

## Basic Usage

```bash
bat file.py                  # display file with highlighting
bat file1.py file2.py        # display multiple files
bat -                        # read from stdin
echo '{"key":1}' | bat -l json  # highlight stdin as JSON
```

## Key Flags

| Flag | Short | Description |
|------|-------|-------------|
| `--language` | `-l` | Set syntax language (e.g., `-l py`, `-l json`) |
| `--list-languages` | `-L` | List all supported languages |
| `--style` | | Control decorations (see below) |
| `--theme` | | Set color theme |
| `--list-themes` | | List all available themes |
| `--paging` | | `always`, `never`, `auto` (default) |
| `--pager` | | Specify pager command (default: `less`) |
| `--line-range` | `-r` | Show only specific lines (e.g., `-r 10:20`) |
| `--highlight-line` | `-H` | Highlight specific lines (e.g., `-H 5:10`) |
| `--diff` | `-d` | Show only Git diff (modified lines) |
| `--diff-context` | | Lines of context around diff changes (default: 2) |
| `--show-all` | `-A` | Show non-printable characters |
| `--plain` | `-p` | No decorations; `-pp` also disables paging |
| `--number` | `-n` | Show line numbers only (no other decorations) |
| `--color` | | `always`, `never`, `auto` |
| `--wrap` | | `auto`, `never`, `character` |
| `--tabs` | | Set tab width (default: 4) |
| `--terminal-width` | | Set output width |
| `--file-name` | | Override displayed filename |
| `--force-colorization` | `-f` | Force color output (even when piped) |
| `--italic-text` | | Use italic text (`always` / `never`) |
| `--decorations` | | `always`, `never`, `auto` |
| `--strip-ansi` | | `always`, `never`, `auto` -- strip ANSI from input |

## Style Components

Combine with commas: `--style=numbers,changes,header`

| Component | Description |
|-----------|-------------|
| `full` | All components enabled |
| `auto` | Default (full when appropriate) |
| `plain` | No decorations at all |
| `header` | Show file name header |
| `header-filename` | Show filename in header |
| `header-filesize` | Show filesize in header |
| `grid` | Separator lines between sections |
| `rule` | Horizontal rule between files |
| `numbers` | Line numbers |
| `snip` | Snip marker for line range gaps |
| `changes` | Git change markers in margin |

```bash
bat --style=numbers,changes file.py
bat --style=full file.py
bat --style=plain file.py   # same as bat -p
```

## Line Ranges

```bash
bat -r 10:20 file.py      # lines 10 to 20
bat -r :50 file.py         # first 50 lines
bat -r 100: file.py        # from line 100 to end
bat -r 10:20 -r 30:40 f    # multiple ranges
bat -H 15 -r 10:20 file.py # highlight line 15 within range
```

## Themes

```bash
bat --list-themes                     # list all themes
bat --theme=gruvbox-dark file.py      # use specific theme
export BAT_THEME="Catppuccin Mocha"   # set default theme
bat --theme=ansi file.py              # basic 16-color theme
```

## Configuration

Config file location: `~/.config/bat/config` (or `$BAT_CONFIG_PATH`)

```bash
# ~/.config/bat/config
--theme="Catppuccin Mocha"
--style="numbers,changes,header"
--italic-text=always
--map-syntax "*.conf:INI"
--map-syntax ".ignore:Git Ignore"
```

| Env Variable | Description |
|-------------|-------------|
| `BAT_THEME` | Default theme |
| `BAT_STYLE` | Default style |
| `BAT_PAGER` | Default pager command |
| `BAT_CONFIG_PATH` | Custom config file path |
| `BAT_CONFIG_DIR` | Custom config directory |

```bash
bat --config-file              # show config file path
bat --generate-config-file     # create default config
```

## Custom Syntaxes & Themes

```bash
bat cache --build        # rebuild cache after adding syntaxes/themes
bat cache --clear        # clear cached syntaxes/themes
# Place .sublime-syntax files in: ~/.config/bat/syntaxes/
# Place .tmTheme files in:        ~/.config/bat/themes/
```

## Integration with Other Tools

### As a previewer for fzf

```bash
fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'
```

### As a Git diff pager

```bash
# In ~/.gitconfig (though delta is usually preferred)
[core]
    pager = bat --style=changes --paging=always

# Or pipe directly
git diff | bat -l diff
```

### With ripgrep (show matches in context)

```bash
rg --json "pattern" | bat -l json
rg -l "pattern" | xargs bat               # open matching files
batgrep "pattern"                          # if bat-extras installed
```

### With man pages

```bash
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
```

### With tail

```bash
tail -f /var/log/syslog | bat --paging=never -l log
```

## bat-extras (Optional)

If installed, provides additional commands:

| Command | Description |
|---------|-------------|
| `batgrep` | ripgrep with bat output |
| `batman` | man pages with bat |
| `batpipe` | bat as a pipe preprocessor |
| `batwatch` | watch files with bat |
| `batdiff` | diff with bat |
| `prettybat` | format + highlight |

## Common Combos

```bash
# Quick peek at a file's structure
bat -n --line-range=:30 file.py

# Show only modified lines (Git diff)
bat -d file.py

# Plain output for piping (no color, no paging)
bat -pp file.py

# Concatenate files with separator
bat --style=header,rule file1.py file2.py

# Preview non-printable characters
bat -A file.txt
```
