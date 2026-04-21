# Watch

Execute a program periodically and display the output full-screen.

## Syntax

```bash
watch [options] <command>
```

## Key Flags

| Flag | Description |
|---|---|
| `-n <sec>` / `--interval <sec>` | Update interval in seconds (default 2, supports decimals) |
| `-d` / `--differences` | Highlight differences between updates |
| `-d=permanent` | Highlight all changes since start (cumulative) |
| `-t` / `--no-title` | Hide the header line |
| `-c` / `--color` | Interpret ANSI color sequences |
| `-e` / `--errexit` | Exit on non-zero return code |
| `-g` / `--chgexit` | Exit when output changes |
| `-p` / `--precise` | Attempt to run at precise intervals |
| `-b` / `--beep` | Beep on non-zero return code |
| `-w` / `--no-wrap` | Disable line wrapping |
| `-x` / `--exec` | Pass command to exec instead of sh -c |

## Examples

```bash
# Monitor disk usage every 5 seconds
watch -n 5 df -h

# Watch a directory with color
watch -c ls -la --color=always /tmp

# Highlight what changes
watch -d free -h

# Exit when a file appears
watch -g ls /tmp/expected_file

# Monitor pod status
watch -n 1 kubectl get pods

# Watch network connections
watch -n 1 ss -tuln

# Monitor system load with precise timing
watch -n 1 -p uptime

# Watch log file tail (use color flag)
watch -c -n 2 'tail -20 /var/log/syslog'

# Monitor git status
watch -n 3 -c git -c color.status=always status -sb

# Exit when command fails
watch -e -n 1 curl -sf http://localhost:8080/health

# No header, 0.5 second interval
watch -t -n 0.5 date +%T

# Watch with cumulative highlighting
watch -d=permanent -n 1 'netstat -an | grep ESTABLISHED | wc -l'

# Monitor Docker containers
watch -n 2 docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}'
```

## Tips

- Quote commands with pipes or special characters: `watch 'cmd1 | cmd2'`.
- Use `--exec` (`-x`) for commands with special characters that cause shell interpretation issues.
- Decimal intervals work: `watch -n 0.5 <cmd>` updates every half second.
- Combine `-g` with a script to trigger actions when output changes.
- `watch` uses `sh -c` by default, so shell features like pipes and redirects work in the quoted command.
