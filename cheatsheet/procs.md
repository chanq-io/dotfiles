# procs Cheatsheet

Modern replacement for `ps` written in Rust. Colored output, keyword search, tree view, and customizable columns.

## Basic Usage

```bash
procs                             # List all processes (like ps aux, but better)
procs keyword                     # Search processes by keyword
procs "my app"                    # Search with spaces
procs 1234                        # Show process with PID 1234
procs --tree                      # Show process tree
procs --watch                     # Continuous update (like top)
procs --watch 5                   # Update every 5 seconds
```

## Key Flags

| Flag                         | Description                                    |
|------------------------------|------------------------------------------------|
| `--tree`/`-t`               | Show process tree (parent-child hierarchy)     |
| `--watch`/`-w [SECS]`      | Watch mode, optional interval (default 1s)     |
| `--sortd COLUMN`/`-s`      | Sort descending by column                      |
| `--sorta COLUMN`            | Sort ascending by column                       |
| `--insert COLUMN`/`-i`     | Insert additional column(s) into output        |
| `--pager`/`-p`             | Pipe output through pager                      |
| `--color=always`            | Force color (useful for piping)                |
| `--thread`                  | Show threads                                   |
| `--and`                     | AND logic for multiple keywords (default: OR)  |
| `--or`                      | OR logic for multiple keywords                 |
| `--nand`                    | NAND logic                                     |
| `--nor`                     | NOR logic                                      |
| `--gen N`                   | Show processes and N generations of descendants|
| `--list`                    | List available columns                         |

## Keyword Search

```bash
procs firefox                     # Find processes matching "firefox"
procs python node                 # Match "python" OR "node" (default OR)
procs --and python flask          # Match processes with both keywords
procs --nor zombie                # Exclude matching processes
```

The search checks against command name, full command line, and user.

## Sorting

```bash
procs --sortd cpu                 # Sort by CPU usage descending
procs --sorta mem                 # Sort by memory ascending
procs --sortd read                # Sort by disk read
procs --sortd pid                 # Sort by PID descending
```

## Column Selection

```bash
procs --insert state              # Add state column to output
procs --insert ppid,uid,state     # Add multiple columns
procs --list                      # Show all available columns
```

### Available Columns (common ones)

| Column      | Description                        |
|-------------|------------------------------------|
| `pid`       | Process ID                         |
| `ppid`      | Parent process ID                  |
| `user`      | Username                           |
| `state`     | Process state                      |
| `cpu`       | CPU usage %                        |
| `mem`       | Memory usage %                     |
| `rss`       | Resident set size                  |
| `vsz`       | Virtual memory size                |
| `read`      | Disk read bytes                    |
| `write`     | Disk write bytes                   |
| `tty`       | Controlling terminal               |
| `threads`   | Thread count                       |
| `command`   | Command name                       |
| `start`     | Start time                         |
| `elapsed`   | Elapsed time                       |
| `nice`      | Nice value                         |
| `priority`  | Priority                           |
| `tcp`       | TCP port                           |
| `udp`       | UDP port                           |
| `slot`      | Docker/container name              |
| `pgid`      | Process group ID                   |
| `sid`       | Session ID                         |

## Configuration

Config file: `~/.config/procs/config.toml`

```toml
# Default columns to show
[[columns]]
kind = "Pid"
style = "BrightYellow"
numeric_search = true
nonnumeric_search = false

[[columns]]
kind = "User"
style = "BrightGreen"

[[columns]]
kind = "Cpu"
style = "BrightRed"

[[columns]]
kind = "Mem"
style = "BrightCyan"

[[columns]]
kind = "Command"
style = "BrightWhite"

# Sort default
[sort]
column = 3          # Column index (0-based)
order = "Descending"

# Display
[display]
show_self = false
cut_to_terminal = true
cut_to_pager = false
color_mode = "Auto"

# Docker integration
[docker]
path = "/run/docker.sock"

# Pager
[pager]
mode = "Auto"       # Auto, Always, Disable
command = "less"
```

## Examples

```bash
# Find what's using the most CPU
procs --sortd cpu

# Watch memory-heavy processes
procs --watch --sortd mem

# Process tree for a specific app
procs --tree firefox

# See which process is listening on a port
procs --insert tcp,udp

# Show process states
procs --insert state --sortd cpu

# Generate default config
procs --config
```
