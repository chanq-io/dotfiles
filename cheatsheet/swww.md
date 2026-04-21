# swww

Solution to Wayland Wallpapers. Efficient animated wallpaper daemon for Wayland.

## Commands

```bash
swww init                       # Start the daemon (required first)
swww kill                       # Stop the daemon
swww img <path>                 # Set wallpaper
swww query                      # Show current wallpaper info per output
swww clear <color>              # Set solid color (hex: rrggbb)
```

## swww img Options

| Flag | Description | Default |
|---|---|---|
| `--transition-type <type>` | Transition animation type | `simple` |
| `--transition-fps <n>` | Transition framerate | `30` |
| `--transition-duration <n>` | Transition duration in seconds | `3` |
| `--transition-pos <pos>` | Transition start position | `center` |
| `--transition-step <n>` | Frame step size (1-255) | `90` |
| `--transition-angle <deg>` | Angle for directional transitions | `45` |
| `--transition-bezier <p1,p2,p3,p4>` | Custom easing curve | `.54,0,.34,.99` |
| `--resize <mode>` | Image resize strategy | `crop` |
| `--fill-color <rrggbb>` | Color for uncovered areas | `000000` |
| `--outputs <name>` | Target specific output(s) | all |
| `--no-resize` | Do not resize image | |
| `--invert-y` | Invert y axis for transitions | |

## Transition Types

| Type | Description |
|---|---|
| `simple` | No transition, instant change |
| `fade` | Crossfade between old and new |
| `wipe` | Wipe from one side (use --transition-angle) |
| `wave` | Wavy wipe effect (use --transition-angle) |
| `grow` | Circle grows from --transition-pos |
| `outer` | Circle shrinks to --transition-pos |
| `random` | Random transition each time |
| `any` | Alias for random |
| `left` | Wipe from left |
| `right` | Wipe from right |
| `top` | Wipe from top |
| `bottom` | Wipe from bottom |
| `center` | Grow from center |

## Resize Modes

| Mode | Description |
|---|---|
| `crop` | Fill screen, crop excess (default) |
| `fit` | Fit within screen, may show fill-color |
| `no` | No resizing |

## Transition Position Values

```
--transition-pos center         # Center of screen
--transition-pos top            # Top center
--transition-pos bottom-right   # Bottom right corner
--transition-pos 0.5,0.5        # Normalized coordinates
--transition-pos 960,540        # Pixel coordinates
```

## Examples

```bash
# Simple wallpaper set
swww img ~/wallpapers/mountain.jpg

# Smooth fade transition
swww img ~/wallpapers/sunset.png \
    --transition-type fade \
    --transition-duration 2 \
    --transition-fps 60

# Grow from center
swww img ~/wallpapers/forest.png \
    --transition-type grow \
    --transition-pos center \
    --transition-duration 1.5 \
    --transition-fps 60

# Wipe from left with custom angle
swww img ~/wallpapers/city.jpg \
    --transition-type wipe \
    --transition-angle 30 \
    --transition-fps 60

# Set on specific monitor
swww img ~/wallpapers/wide.png --outputs DP-1

# Random wallpaper from directory
swww img "$(find ~/wallpapers -type f | shuf -n 1)" \
    --transition-type random \
    --transition-fps 60

# Solid color
swww clear 1e1e2e
```

## Startup

```bash
# In hyprland.conf
exec-once = swww init
exec-once = swww img ~/wallpapers/default.png
```
