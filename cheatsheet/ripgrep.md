# ripgrep (rg) — Fast Recursive Search

A line-oriented search tool that recursively searches directories for a regex pattern. Extremely fast, respects `.gitignore` by default.

## Basic Syntax

```bash
rg PATTERN                # search current directory
rg PATTERN path/          # search specific path
rg PATTERN file.txt       # search specific file
rg -e pat1 -e pat2        # multiple patterns (OR)
```

## Core Flags

| Flag | Short | Description |
|------|-------|-------------|
| `--ignore-case` | `-i` | Case-insensitive search |
| `--case-sensitive` | `-s` | Force case-sensitive |
| `--smart-case` | `-S` | Case-insensitive unless pattern has uppercase |
| `--word-regexp` | `-w` | Match whole words only |
| `--line-regexp` | `-x` | Match whole lines only |
| `--fixed-strings` | `-F` | Treat pattern as literal (not regex) |
| `--line-number` | `-n` | Show line numbers (default) |
| `--no-line-number` | `-N` | Suppress line numbers |
| `--count` | `-c` | Show count of matching lines per file |
| `--count-matches` | | Count individual matches (not lines) |
| `--files-with-matches` | `-l` | List only filenames with matches |
| `--files-without-match` | `-L` | List files without matches |
| `--max-count` | `-m N` | Stop after N matches per file |
| `--quiet` | `-q` | Suppress output; exit 0 if match found |
| `--invert-match` | `-v` | Show non-matching lines |

## Context

| Flag | Short | Description |
|------|-------|-------------|
| `--context` | `-C N` | Show N lines before and after match |
| `--before-context` | `-B N` | Show N lines before match |
| `--after-context` | `-A N` | Show N lines after match |
| `--passthru` | | Show all lines, highlighting matches |
| `--context-separator=STR` | | String between context blocks |

## File Selection

| Flag | Short | Description |
|------|-------|-------------|
| `--type` | `-t TYPE` | Search only files of TYPE (e.g., `-t py`) |
| `--type-not` | `-T TYPE` | Exclude files of TYPE |
| `--type-list` | | List all known file types |
| `--type-add` | | Add custom file type |
| `--glob` | `-g GLOB` | Include/exclude files matching glob |
| `--iglob` | | Case-insensitive glob |
| `--hidden` | `-.` | Search hidden files/dirs |
| `--no-ignore` | | Don't respect ignore files |
| `--no-ignore-vcs` | | Don't respect `.gitignore` |
| `--unrestricted` | `-u` | `-u` hidden, `-uu` +no-ignore, `-uuu` +binary |
| `--follow` | `-L` | Follow symlinks |
| `--max-depth` | `-d N` | Maximum directory depth |
| `--one-file-system` | | Don't cross filesystem boundaries |
| `--binary` | | Search binary files |
| `--max-filesize` | | Skip files larger than SIZE (e.g., `1M`) |

### Common file types

`rust`, `py`, `js`, `ts`, `go`, `java`, `c`, `cpp`, `html`, `css`, `json`, `yaml`, `toml`, `md`, `sh`, `nix`

```bash
rg --type-list                        # list all known types
rg -t py 'import'                     # search only Python files
rg -T js 'console'                    # exclude JavaScript files
rg -g '*.toml' 'version'              # only .toml files
rg -g '!test/**' 'fn main'            # exclude test/ directory
rg -g '!vendor/' TODO                 # TODOs excluding vendor
rg --type-add 'web:*.{html,css,js}' -t web 'class'  # custom type
```

## Output Formatting

| Flag | Description |
|------|-------------|
| `--color WHEN` | `always`, `auto`, `never` |
| `--colors SPEC` | Customize colors (e.g., `--colors 'match:fg:red'`) |
| `--heading` | Group matches by file (default for terminal) |
| `--no-heading` | Don't group by file |
| `--with-filename` / `-H` | Show filename (default for multi-file) |
| `--no-filename` | Suppress filename |
| `--column` | Show column number of match |
| `--byte-offset` / `-b` | Show byte offset |
| `--trim` | Strip leading whitespace |
| `--sort=CRITERION` | Sort by `path`, `modified`, `accessed`, `created` |
| `--sortr=CRITERION` | Reverse sort |
| `--vimgrep` | Output in vim-compatible format |
| `--json` | Output in JSON Lines format |
| `--only-matching` / `-o` | Print only the matched text |
| `--replace` / `-r` | Replace matches in output |
| `--null-data` | Use null byte as line terminator |

## Regex

ripgrep uses Rust's regex engine (fast, no backtracking).

```bash
rg '\bfn\s+\w+'                      # word boundary, whitespace, word chars
rg '(TODO|FIXME|HACK):'              # alternation
rg 'error\[E\d{4}\]'                 # escape brackets, digit repetition
rg '(?:pub\s+)?fn\s+(\w+)'           # non-capturing group
```

## Multiline Search

```bash
rg -U 'struct \w+\s*\{[^}]*\}'       # match across lines
rg -U '(?s)BEGIN.*?END'               # dotall mode (. matches \n)
rg --multiline --multiline-dotall 'start.*?end'
```

## Replace (Output Only)

`-r` replaces in **output only** -- it does NOT modify files.

```bash
rg 'foo' -r 'bar'                    # show lines with foo replaced by bar
rg '(\w+)@(\w+)' -r '$1 AT $2'      # capture group substitution
rg -o 'fn (\w+)' -r '$1'            # extract just function names
```

## JSON Output

```bash
rg --json 'pattern' | jq 'select(.type == "match")'
rg --json pattern | jq .             # structured output
```

## Advanced

| Flag | Description |
|------|-------------|
| `-z` / `--search-zip` | Search compressed files |
| `--stats` | Print statistics summary |
| `--engine=PCRE2` | Use PCRE2 engine (lookaround support) |
| `--pre CMD` | Preprocess files before searching |
| `--pre-glob GLOB` | Only preprocess files matching glob |

## Common Examples

```bash
# Case-insensitive literal search
rg -Fi 'todo' src/

# List files containing pattern
rg -l 'deprecated'

# Count matches per file, sorted
rg -c 'import' --sort path
rg -c TODO | sort -t: -k2 -rn        # files by TODO count

# Search with context
rg -C 3 'panic' src/

# Search hidden files, ignore .gitignore
rg -uu 'SECRET_KEY'

# Find all TODO/FIXME comments
rg '(TODO|FIXME|HACK|XXX)\b' -t py

# Show only matched text (extract IPs)
rg -o '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}'

# Search and replace (preview)
rg 'oldName' -r 'newName'

# Pipe-friendly: no color, no line numbers
rg -N --color never 'pattern'

# Multi-pattern search (OR)
rg -e 'error' -e 'warn' -e 'fatal'

# Files matching multiple patterns (AND logic)
rg -l 'import' | xargs rg -l 'export'

# Multiline struct search
rg -U 'struct \w+\s*\{[^}]*\}' -t rust

# Stats summary
rg 'pattern' --stats

# Search in hidden, skip .git
rg 'password' --hidden -g '!.git'

# TS files importing React
rg -l 'import.*React' -t ts
```

## Configuration

Config file: set `$RIPGREP_CONFIG_PATH` to the file path.

```bash
# Example ~/.ripgreprc
--smart-case
--hidden
--glob=!.git
--colors=line:fg:yellow
--colors=match:fg:red
--colors=match:style:bold
```

```bash
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
```

## Ignore Files

Respected in order (later overrides earlier):

| File | Scope |
|------|-------|
| `.gitignore` | Per-directory (Git repos) |
| `.ignore` | Per-directory (shared with fd) |
| `.rgignore` | Per-directory (rg-specific) |
| Global gitignore | `core.excludesFile` in git config |

## Aliases (suggested)

```bash
alias rgi='rg -i'
alias rgl='rg -l'
alias rgf='rg -F'
```
