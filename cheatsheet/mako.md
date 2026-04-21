# Mako

Lightweight Wayland notification daemon.

## Config Location

`~/.config/mako/config`

## Config Options

### Appearance

| Option | Description | Example |
|---|---|---|
| `font` | Font family and size | `JetBrains Mono 11` |
| `background-color` | Background RGBA | `#1e1e2eEE` |
| `text-color` | Text color | `#cdd6f4` |
| `border-size` | Border width in px | `2` |
| `border-color` | Border color | `#89b4fa` |
| `border-radius` | Corner rounding in px | `10` |
| `width` | Notification width in px | `350` |
| `height` | Max notification height | `200` |
| `margin` | Outer margin | `10` |
| `padding` | Inner padding | `15` |
| `icons` | Show icons | `1` |
| `icon-path` | Icon search path | `/usr/share/icons/Papirus` |
| `max-icon-size` | Max icon size in px | `48` |

### Behavior

| Option | Description | Example |
|---|---|---|
| `default-timeout` | Auto-dismiss time in ms (0=persistent) | `5000` |
| `anchor` | Screen position | `top-right` |
| `group-by` | Group notifications by field | `app-name` |
| `max-visible` | Max visible notifications | `5` |
| `sort` | Sort order | `-time` (newest first) |
| `layer` | Render layer | `overlay` |
| `on-button-left` | Left click action | `dismiss` |
| `on-button-right` | Right click action | `dismiss-all` |
| `on-button-middle` | Middle click action | `invoke-default-action` |
| `on-touch` | Touch action | `dismiss` |
| `ignore-timeout` | Ignore app-set timeout | `0` |
| `max-history` | Max stored notifications | `5` |
| `output` | Show on specific output | `DP-1` |

### Anchor Values

`top-left`, `top-center`, `top-right`, `center`, `bottom-left`, `bottom-center`, `bottom-right`

### Example Config

```ini
# ~/.config/mako/config
font=JetBrains Mono 11
background-color=#1e1e2eEE
text-color=#cdd6f4
border-size=2
border-color=#89b4fa
border-radius=10
default-timeout=5000
width=350
height=200
margin=10
padding=15
anchor=top-right
group-by=app-name
max-visible=5
icons=1
max-icon-size=48

[urgency=critical]
border-color=#f38ba8
default-timeout=0
ignore-timeout=1

[app-name=Spotify]
default-timeout=3000
group-by=summary
```

## makoctl Commands

```bash
makoctl dismiss               # Dismiss the top notification
makoctl dismiss --all         # Dismiss all notifications
makoctl invoke                # Invoke default action on top notification
makoctl restore               # Restore last dismissed notification
makoctl list                  # List current notifications (JSON)
makoctl reload                # Reload config file
makoctl mode                  # Show current mode
makoctl mode -a do-not-disturb  # Enable DND mode
makoctl mode -r do-not-disturb  # Disable DND mode
```

## Testing

```bash
notify-send "Title" "Body text"
notify-send -u critical "Alert" "Something broke"
notify-send -t 10000 "Sticky" "Stays for 10 seconds"
notify-send -i firefox "Firefox" "Download complete"
```
