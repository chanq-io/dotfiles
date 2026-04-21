# bandwhich Cheatsheet

Terminal bandwidth utilization tool. Shows per-process, per-connection, and per-remote-host network usage in real time.

## Basic Usage

```bash
sudo bandwhich                    # Must run as root (needs packet capture)
sudo bandwhich -i eth0            # Monitor specific interface
sudo bandwhich -i wlan0           # Monitor Wi-Fi interface
```

Requires root/sudo because it uses raw packet capture.

## Key Flags

| Flag                        | Description                                      |
|-----------------------------|--------------------------------------------------|
| `-i`/`--interface=IFACE`   | Monitor specific network interface               |
| `-r`/`--raw`               | Machine-readable output (no TUI)                 |
| `-n`/`--no-resolve`        | Don't resolve hostnames (show raw IPs)           |
| `-s`/`--show-dns`          | Show DNS queries                                 |
| `-d`/`--dns-server=IP`     | Use custom DNS server for resolution             |
| `-t`/`--total-utilization` | Show only total bandwidth (no per-process split) |
| `--log-to=FILE`            | Log raw data to file                             |

## TUI Display Panels

bandwhich shows three panels, each offering a different view of bandwidth usage:

### Processes Panel (default view)

Shows bandwidth per process:

```
Process               Upload       Download
firefox               1.2 MB/s     5.8 MB/s
syncthing             500 KB/s     200 KB/s
ssh                   10 KB/s      15 KB/s
```

### Connections Panel

Shows bandwidth per individual socket/connection:

```
Connection                              Upload       Download
192.168.1.10:54321 -> 93.184.216.34:443  1.0 MB/s    4.2 MB/s
192.168.1.10:38742 -> 10.0.0.5:22        10 KB/s     15 KB/s
```

### Remote Hosts Panel

Shows bandwidth aggregated by remote host:

```
Remote Address              Upload       Download
cdn.example.com (93.x.x.x)  1.0 MB/s    4.2 MB/s
sync.example.com             500 KB/s    200 KB/s
```

## TUI Navigation

| Key     | Action                                |
|---------|---------------------------------------|
| `Tab`   | Switch between panels (processes / connections / remote hosts) |
| `j`/`k` | Scroll down / up in current panel    |
| `Up`/`Down` | Scroll down / up                 |
| `q`     | Quit                                  |
| `Esc`   | Quit                                  |

## Raw Output Mode

```bash
sudo bandwhich --raw                   # Machine-parseable output to stdout
sudo bandwhich --raw > bandwidth.log   # Log to file for later analysis
```

Raw mode outputs structured data suitable for piping to other tools. The TUI is disabled.

## Common Usage Patterns

```bash
# Quick check what's eating bandwidth
sudo bandwhich

# Monitor without DNS lookups (faster, less noise)
sudo bandwhich --no-resolve

# Log bandwidth data for analysis
sudo bandwhich --raw --log-to=/tmp/bw.log

# Monitor specific interface without hostname resolution
sudo bandwhich -i eth0 -n
```

## Notes

- Bandwidth figures are shown per second and update in real time.
- Both upload and download are tracked separately.
- Process identification uses `/proc` on Linux to match packets to PIDs.
- If a process exits, its traffic may briefly show as `<unknown>`.
