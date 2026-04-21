# eza — Modern ls Replacement

A modern, maintained replacement for `ls` with sensible defaults, colors, and Git integration.

## Basic Usage

```bash
eza                     # list files (current dir)
eza /path/to/dir        # list files in specific dir
eza file1 file2         # list specific files
```

## Key Flags

| Flag | Short | Description |
|------|-------|-------------|
| `--long` | `-l` | Long format (permissions, size, date, etc.) |
| `--all` | `-a` | Show hidden (dot) files |
| `--almost-all` | `-A` | Show hidden files, but not `.` and `..` |
| `--tree` | `-T` | Recurse into directories as a tree |
| `--level=N` | `-L N` | Limit tree/recursion depth to N levels |
| `--recurse` | `-R` | Recurse into directories (flat listing) |
| `--oneline` | `-1` | One file per line |
| `--grid` | `-G` | Display as grid (default) |
| `--across` | `-x` | Sort grid across rather than downward |
| `--classify` | `-F` | Append indicator (/, *, @) to entries |
| `--icons` | | Show file/dir icons (requires Nerd Font) |
| `--no-icons` | | Disable icons |
| `--color=WHEN` | | `always`, `auto`, `never` |
| `--colour=WHEN` | | Alias for `--color` |
| `-d` | | List directories themselves, not contents |

## Display & Columns

| Flag | Description |
|------|-------------|
| `--header` / `-h` | Show column headers in long view |
| `--no-permissions` | Hide permissions column |
| `--no-filesize` | Hide file size column |
| `--no-user` | Hide user column |
| `--no-time` | Hide timestamp column |
| `--octal-permissions` | Show octal permissions (e.g., 0644) |
| `--binary` | Show sizes in binary units (KiB, MiB) |
| `--bytes` / `-B` | Show exact size in bytes |
| `--blocksize` | Show allocated block size |
| `--inode` / `-i` | Show inode number |
| `--links` | Show hard link count |
| `--group` / `-g` | Show owning group |
| `--numeric` | Show numeric UIDs/GIDs |
| `--time-style=STYLE` | `default`, `iso`, `long-iso`, `full-iso`, `relative` |
| `--total-size` | Show directory sizes (recursive calculation) |

## Sorting

| Flag | Description |
|------|-------------|
| `--sort=FIELD` / `-s FIELD` | Sort by field (see below) |
| `--reverse` / `-r` | Reverse sort order |
| `--group-directories-first` | Directories before files |

**Sort fields:** `name`, `Name` (case-sensitive), `size`, `extension` / `ext`, `modified`, `accessed`, `created`, `inode`, `type`, `none`

```bash
eza -l --sort=size               # sort by size
eza -l --sort=modified --reverse  # oldest first
eza -l -s ext                    # sort by extension
```

## Git Integration

| Flag | Description |
|------|-------------|
| `--git` | Show Git status for each file (long view) |
| `--git-repos` | Show Git repo status for directories |
| `--git-ignore` | Respect `.gitignore` rules |
| `--no-git` | Suppress Git integration |

Git status indicators: `N` new, `M` modified, `D` deleted, `R` renamed, `T` type change, `-` unmodified, `I` ignored

## Filtering

| Flag | Description |
|------|-------------|
| `--only-dirs` / `-D` | List only directories |
| `--only-files` / `-f` | List only files |
| `--git-ignore` | Hide gitignored files |
| `-I GLOB` / `--ignore-glob=GLOB` | Ignore files matching glob pattern |

## Timestamps

| Flag | Description |
|------|-------------|
| `--modified` / `-m` | Use modified time (default) |
| `--accessed` / `-u` | Use accessed time |
| `--created` / `-U` | Use created/birth time |
| `--changed` | Use changed (ctime) time |

## Common Combos

```bash
# Full-featured listing
eza -la --icons --git --header --group-directories-first

# Tree view, 3 levels deep
eza -T -L 3 --icons --group-directories-first

# Long listing sorted by modification time, newest last
eza -l --sort=modified --icons

# Find large files
eza -l --sort=size --reverse --no-permissions --no-user --no-time

# Directories only, with git status
eza -lD --git --icons

# Compact: one per line, no metadata
eza -1a

# Recursive listing with total directory sizes
eza -l --total-size --no-time

# Compact long view
eza -la --no-permissions --no-user

# Relative timestamps
eza -la --time-style=relative
```

## Aliases (suggested)

```bash
alias ls='eza'
alias ll='eza -l --icons --git --header --group-directories-first'
alias la='eza -la --icons --git --header --group-directories-first'
alias lt='eza -T -L 3 --icons --group-directories-first'
alias l='eza -1a'
```
