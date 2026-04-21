# Hyprlock

GPU-accelerated screen lock for Hyprland.

## Config Location

`~/.config/hypr/hyprlock.conf`

## Config Structure

The config consists of widget blocks: `background`, `input-field`, and `label`.

### background

```
background {
    monitor =                   # Empty = all monitors
    path = /path/to/image.png   # Path to wallpaper (or screenshot)
    path = screenshot            # Use screenshot of current screen
    color = rgba(30, 30, 46, 1.0)

    # Blur (applied to path image)
    blur_passes = 3             # 0 to disable
    blur_size = 8

    # Noise/brightness/contrast/vibrancy
    noise = 0.0117
    brightness = 0.8
    contrast = 0.9
    vibrancy = 0.17
    vibrancy_darkness = 0.0
}
```

### input-field

```
input-field {
    monitor =
    size = 200, 50              # width, height
    position = 0, -20           # x, y from anchor
    halign = center             # left, center, right
    valign = center             # top, center, bottom

    outline_thickness = 3
    dots_size = 0.33            # Relative to input height
    dots_spacing = 0.15
    dots_center = false
    dots_rounding = -1          # -1 = circle

    outer_color = rgb(89, 180, 250)
    inner_color = rgb(30, 30, 46)
    font_color = rgb(205, 214, 244)
    fade_on_empty = true
    fade_timeout = 1000         # ms before fade

    placeholder_text = <i>Password...</i>  # Supports pango markup
    hide_input = false
    rounding = -1               # -1 = follow general rounding

    check_color = rgb(250, 179, 135)    # Color while checking
    fail_color = rgb(243, 139, 168)     # Color on failure
    fail_text = <i>$FAIL</i>            # Text on failure
    fail_transition = 300

    capslock_color = rgb(249, 226, 175) # Color when capslock on
    numlock_color = -1
    bothlock_color = -1
}
```

### label

```
label {
    monitor =
    text = Hi, $USER            # Supports $USER, $TIME, $FAIL, cmd[interval]
    text = cmd[1000] date +"%H:%M:%S"  # Command updated every 1000ms

    color = rgba(205, 214, 244, 1.0)
    font_size = 25
    font_family = JetBrains Mono

    position = 0, 80
    halign = center
    valign = center

    shadow_passes = 1
    shadow_size = 3
    shadow_boost = 1.2
}
```

## Variables in Labels

| Variable | Description |
|---|---|
| `$USER` | Current username |
| `$TIME` | Current time (HH:MM) |
| `$FAIL` | Failure message |
| `$ATTEMPTS` | Number of attempts |
| `cmd[interval] <cmd>` | Run command every interval ms |

## Full Example

```
background {
    path = screenshot
    blur_passes = 3
    blur_size = 8
}

input-field {
    size = 250, 50
    position = 0, -20
    halign = center
    valign = center
    outline_thickness = 2
    outer_color = rgb(89, 180, 250)
    inner_color = rgb(30, 30, 46)
    font_color = rgb(205, 214, 244)
    fade_on_empty = true
    placeholder_text = <i>Enter password...</i>
}

label {
    text = $TIME
    color = rgba(205, 214, 244, 1.0)
    font_size = 64
    font_family = JetBrains Mono
    position = 0, 150
    halign = center
    valign = center
}

label {
    text = Hi, $USER
    color = rgba(205, 214, 244, 0.8)
    font_size = 20
    font_family = JetBrains Mono
    position = 0, 70
    halign = center
    valign = center
}
```

## Usage

```bash
hyprlock                        # Lock the screen
# Typically triggered via hypridle or keybind:
# bind = SUPER, L, exec, hyprlock
```
