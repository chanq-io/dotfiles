# fd — Modern find Replacement

A simple, fast, and user-friendly alternative to `find`. Respects `.gitignore` by default.

## Basic Syntax

```bash
fd [FLAGS] [PATTERN] [PATH...]
```

The pattern is a **regex** by default (not a glob).

```bash
fd                        # list all files recursively
fd readme                 # find files matching "readme" (case-insensitive)
fd 'read.*me'             # regex pattern
fd -g '*.py'              # glob pattern instead of regex
fd '^main\.go$'           # exact filename via regex anchoring
```

## Key Flags

| Flag | Short | Description |
|------|-------|-------------|
| `--extension` | `-e` | Filter by file extension (repeatable) |
| `--type` | `-t` | Filter by type (see below) |
| `--max-depth` | `-d` | Maximum search depth |
| `--min-depth` | | Minimum search depth |
| `--hidden` | `-H` | Include hidden files/dirs |
| `--no-ignore` | `-I` | Don't respect `.gitignore` / `.ignore` |
| `--no-ignore-vcs` | | Don't respect `.gitignore` (but respect `.ignore`) |
| `--unrestricted` | `-u` | `-u` = hidden, `-uu` = hidden + no-ignore |
| `--follow` | `-L` | Follow symlinks |
| `--full-path` | `-p` | Match pattern against full path (not just filename) |
| `--glob` | `-g` | Use glob pattern instead of regex |
| `--fixed-strings` | `-F` | Treat pattern as literal string |
| `--case-sensitive` | `-s` | Force case-sensitive search |
| `--ignore-case` | `-i` | Force case-insensitive search |
| `--absolute-path` | `-a` | Show absolute paths |
| `--list-details` | `-l` | Long listing format (like `ls -l`) |
| `--color` | | `always`, `auto`, `never` |
| `--print0` | `-0` | Separate results with null byte |
| `--max-results` | | Limit number of results |
| `-1` | | Limit to a single result |
| `--quiet` | `-q` | Exit with 0 if match found, 1 if not (no output) |
| `--show-errors` | | Show filesystem errors |
| `--strip-cwd-prefix` | | Remove `./` prefix from results |
| `--one-file-system` | | Don't cross filesystem boundaries |
| `--prune` | | Don't descend into matched directories |
| `--base-directory` | | Change base directory for relative paths |
| `--exclude` | `-E` | Exclude entries matching glob pattern |
| `--ignore-file` | | Add custom ignore file |
| `--size` | | Filter by size (e.g., `+1m`, `-500k`) |
| `--changed-within` | | Modified within duration |
| `--changed-before` | | Modified before duration |
| `--owner` | `-o` | Filter by owner `USER:GROUP` |

## Type Filters (`-t`)

| Value | Alias | Description |
|-------|-------|-------------|
| `f` | `file` | Regular files |
| `d` | `directory` | Directories |
| `l` | `symlink` | Symbolic links |
| `b` | `block-device` | Block devices |
| `c` | `char-device` | Character devices |
| `s` | `socket` | Sockets |
| `p` | `pipe` | Named pipes (FIFOs) |
| `x` | `executable` | Executable files |
| `e` | `empty` | Empty files or directories |

```bash
fd -t d                  # directories only
fd -t f -t l             # files and symlinks
fd -t e                  # empty files/dirs
fd -t x                  # executables
```

## Size Syntax

Prefix with `+` (greater than) or `-` (less than).

| Suffix | Meaning |
|--------|---------|
| `b` | Bytes |
| `k` / `kb` | Kilobytes |
| `m` / `mb` | Megabytes |
| `g` / `gb` | Gigabytes |
| `t` / `tb` | Terabytes |

## Duration Syntax

`10s`, `5min`, `1h`, `3d`, `2weeks`, `1month`, or a date like `2024-01-15`.

```bash
fd --changed-within 1d                # modified in last day
fd --changed-within '2024-01-15'      # modified since date
fd --changed-before 2weeks            # older than 2 weeks
fd --size +10m                        # files larger than 10 MB
fd --size -1k                         # files smaller than 1 KB
```

## Execution

| Flag | Description |
|------|-------------|
| `--exec CMD` / `-x CMD` | Run command for each result (parallel) |
| `--exec-batch CMD` / `-X CMD` | Run command once with all results as args |

Placeholders for `-x` and `-X`:

| Placeholder | Description |
|-------------|-------------|
| `{}` | Full path |
| `{/}` | Basename |
| `{//}` | Parent directory |
| `{.}` | Path without extension |
| `{/.}` | Basename without extension |

```bash
fd -e jpg -x convert {} {.}.png       # convert each jpg to png
fd -e py -X wc -l                     # count lines across all .py files
fd -e bak -x rm {}                    # delete all .bak files
fd -e rs -x chmod +x {}               # make all .rs files executable
fd -t f -e log -X tar czf logs.tar.gz # tar all log files
fd -e tmp -x rm                       # delete all .tmp files
```

## Common Examples

```bash
# Find Python files
fd -e py

# Multiple extensions
fd -e rs -e toml

# Find files in specific directory
fd -e js src/

# Find directories named "test"
fd -t d test

# Find hidden files (dotfiles)
fd -H '^\.'

# Search ignoring gitignore rules
fd -I pattern

# Both hidden and no-ignore
fd -uu pattern

# Find and delete empty directories
fd -t e -t d -x rmdir

# Find files, exclude node_modules and .git
fd -H --exclude node_modules --exclude .git

# Find by full path
fd -p 'src/.*test.*\.py$'

# Find Dockerfiles
fd -g 'Dockerfile*'

# Find large log files modified recently
fd -e log --size +100m --changed-within 1week

# Clean old logs
fd -t f -e log --changed-before 30d -x rm

# Count files by extension
fd -e rs | wc -l

# Feed results to fzf
fd --type f | fzf

# List details (long format)
fd -e py -l
```

## Configuration

Ignore patterns can be placed in:

| File | Scope |
|------|-------|
| `.fdignore` | Per-directory (fd-specific) |
| `.ignore` | Per-directory (shared with rg) |
| `.gitignore` | Per-directory (if in a Git repo) |
| `~/.config/fd/ignore` | Global ignore file |

## Aliases (suggested)

```bash
alias f='fd'
alias ff='fd -t f'
alias fdir='fd -t d'
```
