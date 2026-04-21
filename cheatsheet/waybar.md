# Waybar

Highly customizable Wayland bar for Sway and Hyprland.

## Config Location

- Config: `~/.config/waybar/config` or `config.jsonc`
- Style: `~/.config/waybar/style.css`

## Config Structure

```jsonc
{
    "layer": "top",
    "position": "top",            // top, bottom, left, right
    "height": 30,
    "spacing": 4,
    "modules-left": ["hyprland/workspaces", "hyprland/window"],
    "modules-center": ["clock"],
    "modules-right": ["cpu", "memory", "pulseaudio", "battery", "tray"],

    // Module configs below
    "hyprland/workspaces": { ... },
    "clock": { ... }
}
```

## Key Modules

### hyprland/workspaces

```jsonc
"hyprland/workspaces": {
    "format": "{icon}",
    "format-icons": {
        "1": "",
        "2": "",
        "active": "",
        "default": ""
    },
    "on-click": "activate",
    "sort-by-number": true,
    "all-outputs": false
}
```

### clock

```jsonc
"clock": {
    "format": "{:%H:%M}",
    "format-alt": "{:%Y-%m-%d %H:%M:%S}",
    "tooltip-format": "<tt>{calendar}</tt>",
    "interval": 1
}
```

### cpu / memory

```jsonc
"cpu": {
    "format": " {usage}%",
    "interval": 5,
    "on-click": "kitty -e htop"
}
"memory": {
    "format": " {}%",
    "interval": 5
}
```

### network

```jsonc
"network": {
    "format-wifi": " {signalStrength}%",
    "format-ethernet": " {ipaddr}",
    "format-disconnected": "Disconnected",
    "tooltip-format": "{ifname}: {ipaddr}/{cidr}",
    "on-click": "nm-connection-editor"
}
```

### pulseaudio

```jsonc
"pulseaudio": {
    "format": "{icon} {volume}%",
    "format-muted": " muted",
    "format-icons": {
        "default": ["", "", ""]
    },
    "on-click": "pavucontrol",
    "on-scroll-up": "wpctl set-volume @DEFAULT_SINK@ 5%+",
    "on-scroll-down": "wpctl set-volume @DEFAULT_SINK@ 5%-"
}
```

### battery

```jsonc
"battery": {
    "states": { "warning": 30, "critical": 15 },
    "format": "{icon} {capacity}%",
    "format-charging": " {capacity}%",
    "format-icons": ["", "", "", "", ""]
}
```

### tray

```jsonc
"tray": {
    "icon-size": 16,
    "spacing": 10
}
```

### custom module

```jsonc
"custom/media": {
    "format": "{}",
    "exec": "playerctl metadata --format '{{artist}} - {{title}}'",
    "interval": 5,
    "on-click": "playerctl play-pause",
    "return-type": "json",     // For structured output
    "escape": true
}
```

## Styling (style.css)

```css
* {
    font-family: "JetBrains Mono", "Font Awesome 6 Free";
    font-size: 13px;
}

window#waybar {
    background-color: rgba(30, 30, 46, 0.9);
    color: #cdd6f4;
}

#workspaces button {
    padding: 0 5px;
    color: #cdd6f4;
}

#workspaces button.active {
    background: #45475a;
    color: #89b4fa;
}

#clock, #cpu, #memory, #battery, #pulseaudio, #network, #tray {
    padding: 0 10px;
    margin: 3px 0;
}

#battery.warning { color: #f9e2af; }
#battery.critical { color: #f38ba8; }
```

## Signals & Reload

```bash
# Reload waybar config and style
killall -SIGUSR2 waybar

# Restart waybar
killall waybar && waybar &

# Send signal to custom module (update immediately)
# In config: "signal": 8
pkill -SIGRTMIN+8 waybar
```
