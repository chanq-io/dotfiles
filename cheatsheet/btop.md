# btop Cheatsheet

Resource monitor TUI showing CPU, memory, disks, network, and processes. Written in C++, successor to bpytop/bashtop.

## Launch

```bash
btop                              # Start with default settings
btop -t                           # Start in TTY mode (simpler graphics)
btop --utf-force                  # Force UTF-8 output
btop -lc                          # Low color mode (for limited terminals)
btop -p <preset>                  # Start with a specific preset (0-9)
```

## Panels Overview

| Panel     | Shows                                                           |
|-----------|-----------------------------------------------------------------|
| CPU       | Per-core usage graphs, frequency, temperature, uptime, load avg |
| Memory    | RAM and swap usage bars, used/available/cached/free             |
| Disks     | Per-mount usage bars, read/write activity                       |
| Network   | Upload/download graphs per interface, total transferred         |
| Processes | Process list with PID, user, CPU%, MEM%, command                |

## Global Key Bindings

| Key       | Action                                     |
|-----------|--------------------------------------------|
| `Esc`     | Back / close menu / cancel                 |
| `q`       | Quit                                       |
| `m`       | Open menu                                  |
| `h`       | Toggle help                                |
| `1`       | Toggle CPU panel                           |
| `2`       | Toggle memory panel                        |
| `3`       | Toggle network panel                       |
| `4`       | Toggle process panel                       |
| `5`       | Toggle disk panel                          |
| `p`/`P`  | Cycle preset layouts (0-9)                 |
| `+`/`-`  | Increase/decrease update rate              |
| `z`       | Toggle net sync between upload/download    |
| `a`       | Toggle auto net scaling                    |
| `b`       | Toggle network bandwidth graph             |
| `n`       | Cycle network interfaces                   |
| `d`       | Cycle disk mount points                    |

## Process Panel Key Bindings

| Key          | Action                                  |
|--------------|-----------------------------------------|
| `Up`/`Down`  | Select process                         |
| `Enter`      | Show detailed info for selected process |
| `t`          | Toggle tree view                        |
| `r`          | Reverse sort order                      |
| `e`          | Toggle per-core / total CPU for process |
| `c`          | Toggle cumulative CPU time              |
| `i`          | Toggle IO mode (show disk read/write)   |
| `s`          | Cycle sort column                       |
| `f`/`/`     | Open filter input                       |
| `Delete`     | Clear filter                            |
| `Space`      | Tag/untag process                       |
| `k`          | Kill selected/tagged process(es)        |
| `K`          | Send specific signal to process         |
| `u`          | Filter by user                          |

## Process Sorting

Press `s` to cycle through or select:

| Sort Column | Description                  |
|-------------|------------------------------|
| PID         | Process ID                   |
| Program     | Program name                 |
| Arguments   | Full command line             |
| Threads     | Thread count                 |
| User        | Owner                        |
| Memory      | Memory usage                 |
| CPU Direct  | Direct CPU usage             |
| CPU Lazy    | Averaged CPU usage           |

## Filtering

1. Press `f` or `/` to open the filter bar.
2. Type a string to filter processes by name/command.
3. Press `Enter` to apply.
4. Press `Delete` or clear the filter to show all.

## Presets

Press `p` to cycle through layout presets 0-9. Each preset is a different arrangement and sizing of panels. Configure custom presets in the config file.

## Configuration

Config file location: `~/.config/btop/btop.conf`

Key settings:

```
color_theme = "Default"
theme_background = True
truecolor = True
shown_boxes = "cpu mem net proc"     # Which panels to show
update_ms = 2000                      # Update interval (ms)
proc_sorting = "cpu lazy"             # Default sort
proc_tree = False                     # Tree view by default
proc_per_core = False                 # Per-core CPU for processes
cpu_graph_upper = "total"             # Upper CPU graph content
cpu_graph_lower = "total"             # Lower CPU graph content
cpu_sensor = "Auto"                   # Temp sensor
show_disks = True
net_iface = ""                        # Auto or specific interface
log_level = "WARNING"
```

Custom themes go in `~/.config/btop/themes/`.

## Tips

- Use tree view (`t`) to see parent-child process relationships.
- Use IO mode (`i`) to find which processes are hammering disk.
- Tag multiple processes with `Space`, then kill them all with `k`.
- Adjust update rate with `+`/`-` to reduce CPU usage of btop itself.
