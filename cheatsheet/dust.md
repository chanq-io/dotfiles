# dust Cheatsheet

Modern replacement for `du` written in Rust. Shows disk usage with a visual bar chart in the terminal.

## Basic Usage

```bash
dust                              # Current directory, largest items
dust /var/log                     # Specific directory
dust /home /var                   # Multiple directories
dust file1.txt file2.txt          # Specific files
```

## Key Flags

| Flag                      | Description                                    |
|---------------------------|------------------------------------------------|
| `-n N`                    | Show top N entries (default: terminal height)  |
| `-d N`/`--depth N`       | Max depth to display                           |
| `-r`/`--reverse`         | Reverse order (smallest first)                 |
| `-X PATTERN`/`--ignore-directory PATTERN` | Exclude directories matching pattern |
| `-b`/`--no-percent-bars` | Remove percentage bars                         |
| `-f`/`--filecount`       | Show file count instead of size                |
| `-c`/`--no-colors`       | Disable colors                                 |
| `-p`/`--full-paths`      | Show full absolute paths                       |
| `-s`/`--apparent-size`   | Use apparent size (not disk usage)             |
| `-t`/`--file-types`      | Show by file type/extension                    |
| `-H`/`--si`             | Use SI units (1000) instead of binary (1024)   |
| `-z MIN_SIZE`            | Minimum size to display                        |
| `-e REGEX`               | Filter by regex                                |
| `-v`                     | Print version                                  |
| `-w`/`--terminal-width N`| Override terminal width                        |
| `-D`/`--only-dir`       | Only show directories, not files               |
| `-F`/`--only-file`      | Only show files, not directories               |
| `-j`                     | Output as JSON                                 |
| `-S`/`--skip-total`     | Don't show the total line                      |

## Examples

```bash
# Top 20 largest items in current directory
dust -n 20

# Only 2 levels deep
dust -d 2

# Exclude node_modules and .git
dust -X node_modules -X .git

# Show file counts instead of sizes
dust -f

# Apparent size, reversed, top 10
dust -s -r -n 10

# Breakdown by file type
dust -t

# Full paths, no bars
dust -p -b

# Show only directories
dust -D -d 3

# Only items larger than 1MB
dust -z 1M

# JSON output for scripting
dust -j /var/log

# Compare two directories
dust /home/user/projectA /home/user/projectB
```

## Output Format

```
  5.0G ┌── node_modules         │████████████████████████████████ │  52%
  2.1G ├── .git                 │█████████████                    │  22%
  1.3G ├── dist                 │████████                         │  14%
614.0M ├── data                 │████                             │  06%
312.0M ├── src                  │██                               │  03%
 98.0M ├── docs                 │                                 │  01%
  9.6G   ┌─┤                    │████████████████████████████████ │ 100%
```

- Left column: size (or file count with `-f`)
- Tree structure shows directory hierarchy
- Bar chart shows relative proportion
- Percentage on the right

## Tips

- Default output fits the terminal height. Use `-n` to override.
- Use `-X .git` in repos to skip the git object store.
- Combine `-t` (file types) with a specific directory to find what kind of files eat space.
- Use `-j` for machine-readable JSON output to process with jq.
