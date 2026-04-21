# Gammastep

Adjusts display color temperature based on time of day (blue light filter).

## Key Flags

| Flag | Description |
|---|---|
| `-l <lat>:<lon>` | Set latitude and longitude |
| `-t <day>:<night>` | Color temperature day:night in Kelvin (e.g., `6500:3500`) |
| `-m <method>` | Adjustment method: `wayland`, `randr`, `drm`, `vidmode` |
| `-b <day>:<night>` | Brightness day:night (0.1 to 1.0) |
| `-O <temp>` | One-shot mode: set specific temperature and exit |
| `-x` | Reset to default temperature and exit |
| `-P` | Reset (purge) existing gamma ramps before adjusting |
| `-r` | Disable fade between temperature changes (instant) |
| `-o` | One-shot mode: set temp for current time and exit |
| `-v` | Verbose output |
| `-c <file>` | Path to config file |
| `-p` | Print current settings and exit |

## Common Usage

```bash
# Auto-adjust based on location
gammastep -l 40.7:-74.0

# Set specific day/night temperatures
gammastep -l 40.7:-74.0 -t 6500:3500

# With brightness adjustment
gammastep -l 40.7:-74.0 -t 6500:3500 -b 1.0:0.8

# One-shot: set warm temperature now
gammastep -O 3500

# One-shot: set temperature with brightness
gammastep -P -O 3500 -b 0.8

# Reset screen to default
gammastep -x

# Use Wayland protocol explicitly
gammastep -m wayland -l 40.7:-74.0

# Print current state
gammastep -p
```

## Config File

Location: `~/.config/gammastep/config.ini`

```ini
[general]
temp-day=6500
temp-night=3500
brightness-day=1.0
brightness-night=0.8
fade=1
location-provider=manual
adjustment-method=wayland

[manual]
lat=40.7
lon=-74.0
```

## Temperature Reference

| Kelvin | Description |
|---|---|
| `6500` | Neutral daylight (default day) |
| `5500` | Slightly warm |
| `4500` | Warm white |
| `3500` | Warm / comfortable night |
| `3000` | Very warm |
| `2500` | Candlelight / very warm |
| `1900` | Extreme warm (minimum) |

## Startup

```bash
# In hyprland.conf
exec-once = gammastep -l 40.7:-74.0

# Or with config file
exec-once = gammastep
```

## Tips

- Range: 1000K to 25000K (practical range 2500-6500).
- Use `-P` with `-O` to purge any existing adjustments first.
- The Wayland method requires `wlr-gamma-control-unstable-v1` protocol support.
- `gammastep-indicator` provides a system tray icon (if available).
