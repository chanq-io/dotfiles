# Hypridle

Idle management daemon for Hyprland.

## Config Location

`~/.config/hypr/hypridle.conf`

## Config Structure

The config has a `general` block and one or more `listener` blocks.

### general

```
general {
    lock_cmd = pidof hyprlock || hyprlock    # Command to run on lock
    unlock_cmd = notify-send "Welcome back"  # Command to run on unlock
    before_sleep_cmd = loginctl lock-session  # Lock before sleep
    after_sleep_cmd = hyprctl dispatch dpms on  # Turn on screen after sleep
    ignore_dbus_inhibit = false              # Respect app inhibit requests
    ignore_systemd_inhibit = false           # Respect systemd inhibit
}
```

### listener

Each listener triggers after a timeout of inactivity.

```
listener {
    timeout = <seconds>         # Inactivity timeout
    on-timeout = <command>      # Command to run when timeout reached
    on-resume = <command>       # Command to run when activity resumes
}
```

## Key Options

| Option | Block | Description |
|---|---|---|
| `lock_cmd` | general | Runs when `loginctl lock-session` is called |
| `unlock_cmd` | general | Runs on session unlock |
| `before_sleep_cmd` | general | Runs before system sleep |
| `after_sleep_cmd` | general | Runs after system wakes |
| `ignore_dbus_inhibit` | general | Ignore app idle inhibitors |
| `timeout` | listener | Seconds of inactivity before triggering |
| `on-timeout` | listener | Command when idle timeout is reached |
| `on-resume` | listener | Command when user becomes active again |

## Full Example

```
general {
    lock_cmd = pidof hyprlock || hyprlock
    before_sleep_cmd = loginctl lock-session
    after_sleep_cmd = hyprctl dispatch dpms on
}

# Dim screen after 2.5 minutes
listener {
    timeout = 150
    on-timeout = brightnessctl -s set 10%
    on-resume = brightnessctl -r
}

# Lock screen after 5 minutes
listener {
    timeout = 300
    on-timeout = loginctl lock-session
}

# Turn off display after 5.5 minutes
listener {
    timeout = 330
    on-timeout = hyprctl dispatch dpms off
    on-resume = hyprctl dispatch dpms on
}

# Suspend after 30 minutes
listener {
    timeout = 1800
    on-timeout = systemctl suspend
}
```

## Usage

```bash
hypridle                        # Start the daemon (typically via exec-once)

# In hyprland.conf:
exec-once = hypridle
```

## Tips

- Use `pidof hyprlock || hyprlock` in `lock_cmd` to avoid spawning multiple instances.
- `before_sleep_cmd = loginctl lock-session` ensures screen is locked before laptop lid close.
- Order listeners from shortest to longest timeout for clarity.
- `brightnessctl -s` saves current brightness; `brightnessctl -r` restores it.
