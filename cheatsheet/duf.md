# duf Cheatsheet

Disk Usage/Free utility. Modern replacement for `df` with colored output and sorting.

## Basic Usage

```bash
duf                               # Show all mounted filesystems
duf /home /var                    # Show specific mount points
```

## Key Flags

| Flag                       | Description                                       |
|----------------------------|---------------------------------------------------|
| `--all`                    | Show all filesystems including pseudo/duplicate    |
| `--hide TYPES`             | Hide specific filesystem types                    |
| `--only TYPES`             | Show only specific filesystem types               |
| `--hide-fs NAMES`          | Hide specific named filesystems                   |
| `--hide-mp PATHS`          | Hide specific mount points                        |
| `--only-mp PATHS`          | Show only specific mount points                   |
| `--sort COLUMN`            | Sort by column                                    |
| `--output FIELDS`          | Select output columns                             |
| `--theme THEME`            | Color theme (dark, light, ansi)                   |
| `--json`                   | JSON output                                       |
| `--width N`                | Override terminal width                           |
| `--warnings`               | Show only filesystems with warnings               |
| `--inodes`                 | Show inode information                            |
| `--avail-threshold VALS`   | Set thresholds for color coding (e.g., "10G,1G") |
| `--usage-threshold VALS`   | Set usage % thresholds for color (e.g., "0.5,0.9")|
| `--style STYLE`            | Table style (unicode, ascii)                      |

## Filesystem Type Filtering

```bash
duf --only local                   # Only local filesystems
duf --only network                 # Only network mounts (NFS, SMB, etc.)
duf --only fuse                    # Only FUSE filesystems
duf --only special                 # Only special filesystems (tmpfs, devtmpfs)
duf --only loops                   # Only loop devices
duf --only binds                   # Only bind mounts

duf --hide special,loops           # Hide special and loop
duf --hide-fs tmpfs,devtmpfs       # Hide by filesystem name
duf --hide-mp /boot,/boot/efi      # Hide by mount point
```

## Sorting

```bash
duf --sort size                    # Sort by total size
duf --sort used                    # Sort by used space
duf --sort avail                   # Sort by available space
duf --sort usage                   # Sort by usage percentage
duf --sort fs                      # Sort by filesystem name
duf --sort mp                      # Sort by mount point
duf --sort type                    # Sort by filesystem type
duf --sort inodes                  # Sort by inode count
```

## Output Column Selection

```bash
duf --output mountpoint,size,used,avail,usage    # Select columns
duf --output mp,size,usage,type,fs               # Short aliases
```

Available columns:

| Column         | Alias  | Description                |
|----------------|--------|----------------------------|
| `mountpoint`   | `mp`   | Mount point path           |
| `size`         |        | Total size                 |
| `used`         |        | Used space                 |
| `avail`        |        | Available space            |
| `usage`        |        | Usage percentage + bar     |
| `inodes`       |        | Total inodes               |
| `inodes_used`  |        | Used inodes                |
| `inodes_avail` |        | Available inodes           |
| `inodes_usage` |        | Inode usage %              |
| `type`         |        | Filesystem type            |
| `filesystem`   | `fs`   | Filesystem/device name     |

## JSON Output

```bash
duf --json                         # Full JSON output
duf --json | jq '.[].mount_point'  # Extract mount points
duf --json --only local | jq '.[] | {mp: .mount_point, pct: .usage}'
```

## Examples

```bash
# Quick overview of real disks only
duf --only local

# Check NFS mounts
duf --only network

# Find nearly full filesystems
duf --sort usage --only local

# Minimal output for scripts
duf --output mp,usage --only local

# Check inode usage
duf --inodes --only local

# Light terminal theme
duf --theme light

# ASCII style (no unicode box drawing)
duf --style ascii

# Show warnings (near-full, read-only, etc.)
duf --warnings
```

## Output Format

```
╭──────────────────────────────────────────────────────────────────────╮
│ 3 local devices                                                      │
├────────────┬───────┬───────┬───────┬───────────────────────────┬──────┤
│ MOUNTED ON │ SIZE  │ USED  │ AVAIL │ USE%                      │ TYPE │
├────────────┼───────┼───────┼───────┼───────────────────────────┼──────┤
│ /          │ 50.0G │ 32.1G │ 15.3G │ [##########.....] 64.2%  │ ext4 │
│ /home      │ 200G  │ 120G  │ 70.2G │ [######.........]  60.0% │ ext4 │
│ /boot      │ 512M  │ 180M  │ 332M  │ [#####..........]  35.2% │ vfat │
╰────────────┴───────┴───────┴───────┴───────────────────────────┴──────╯
```

Colored output highlights usage: green (low), yellow (moderate), red (high).
