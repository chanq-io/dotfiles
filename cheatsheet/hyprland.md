# Hyprland

Tiling Wayland compositor with dynamic tiling, animations, and extensive customization.

## Default Keybinds

### Window Management

| Keybind | Action |
|---|---|
| `Super + Return` | Open terminal |
| `Super + Q` | Close active window |
| `Super + D` | Open application launcher |
| `Super + F` | Toggle fullscreen |
| `Super + V` | Toggle floating |
| `Super + P` | Toggle pseudo-tiling |
| `Super + J` | Toggle split (dwindle) |

### Focus & Movement

| Keybind | Action |
|---|---|
| `Super + Arrow` | Move focus in direction |
| `Super + Shift + Arrow` | Move window in direction |
| `Super + Mouse LMB` | Move window (drag) |
| `Super + Mouse RMB` | Resize window (drag) |

### Workspaces

| Keybind | Action |
|---|---|
| `Super + 1-9` | Switch to workspace 1-9 |
| `Super + Shift + 1-9` | Move active window to workspace 1-9 |
| `Super + S` | Toggle special workspace (scratchpad) |
| `Super + Shift + S` | Move window to special workspace |
| `Super + Mouse Scroll` | Cycle through workspaces |

## hyprctl Commands

```bash
hyprctl dispatch <dispatcher> <args>   # Execute a dispatcher (keybind action)
hyprctl keyword <keyword> <value>      # Set a config keyword at runtime
hyprctl monitors                       # List monitors and their properties
hyprctl clients                        # List all windows/clients
hyprctl activewindow                   # Info about the focused window
hyprctl layers                         # List all layers
hyprctl devices                        # List input devices
hyprctl reload                         # Reload the config file
hyprctl version                        # Show Hyprland version
hyprctl splash                         # Show current splash text
hyprctl kill                           # Enter kill mode (click to close)
hyprctl switchxkblayout <device> next  # Switch keyboard layout
```

### Common Dispatchers

```bash
hyprctl dispatch exec <command>
hyprctl dispatch killactive
hyprctl dispatch workspace <id>
hyprctl dispatch movetoworkspace <id>
hyprctl dispatch togglefloating
hyprctl dispatch fullscreen <0|1|2>     # 0=full, 1=maximize, 2=no-gaps
hyprctl dispatch movefocus <l|r|u|d>
hyprctl dispatch movewindow <l|r|u|d>
hyprctl dispatch resizeactive <x> <y>
hyprctl dispatch pin                    # Pin floating window to all workspaces
```

## Config Keywords

Config file: `~/.config/hypr/hyprland.conf`

### Monitor

```
monitor = name, resolution@rate, position, scale
monitor = , preferred, auto, 1          # Fallback for all monitors
monitor = DP-1, 2560x1440@144, 0x0, 1
monitor = eDP-1, 1920x1080, auto, 1
```

### Exec

```
exec-once = waybar                      # Run once at startup
exec-once = mako                        # Notification daemon
exec = <command>                        # Run on every reload
```

### Keybinds

```
bind = SUPER, Return, exec, kitty
bind = SUPER, Q, killactive
bind = SUPER, D, exec, wofi --show drun
bind = SUPER, 1, workspace, 1
bind = SUPER SHIFT, 1, movetoworkspace, 1
bindm = SUPER, mouse:272, movewindow   # Mouse bind (move)
bindm = SUPER, mouse:273, resizewindow # Mouse bind (resize)
binde = SUPER CTRL, right, resizeactive, 10 0  # Repeatable bind
bindl = , XF86AudioMute, exec, wpctl set-mute @DEFAULT_SINK@ toggle  # Locked bind
```

### Input

```
input {
    kb_layout = us
    follow_mouse = 1
    sensitivity = 0
    touchpad {
        natural_scroll = true
    }
}
```

### General

```
general {
    gaps_in = 5
    gaps_out = 10
    border_size = 2
    col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
    col.inactive_border = rgba(595959aa)
    layout = dwindle
}
```

### Decoration & Animations

```
decoration {
    rounding = 10
    blur {
        enabled = true
        size = 3
        passes = 1
    }
    drop_shadow = true
    shadow_range = 4
}

animations {
    enabled = true
    bezier = myBezier, 0.05, 0.9, 0.1, 1.05
    animation = windows, 1, 7, myBezier
    animation = windowsOut, 1, 7, default, popin 80%
    animation = fade, 1, 7, default
    animation = workspaces, 1, 6, default
}
```

### Window Rules

```
windowrule = float, ^(pavucontrol)$
windowrule = size 800 600, ^(pavucontrol)$
windowrulev2 = opacity 0.9, class:^(kitty)$
windowrulev2 = workspace 2, class:^(firefox)$
```
