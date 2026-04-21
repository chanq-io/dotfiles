# Playerctl

MPRIS media player controller for the command line.

## Commands

```bash
playerctl play                  # Start playback
playerctl pause                 # Pause playback
playerctl play-pause            # Toggle play/pause
playerctl next                  # Next track
playerctl previous              # Previous track
playerctl stop                  # Stop playback
playerctl status                # Print playing/paused/stopped
playerctl volume                # Print current volume (0.0-1.0)
playerctl volume 0.7            # Set volume to 70%
playerctl volume 0.1+           # Increase volume by 10%
playerctl volume 0.1-           # Decrease volume by 10%
playerctl position              # Print position in seconds
playerctl position 30           # Seek to 30 seconds
playerctl position 10+          # Seek forward 10 seconds
playerctl position 10-          # Seek backward 10 seconds
playerctl metadata              # Print all metadata
playerctl shuffle               # Print shuffle status
playerctl shuffle on            # Enable shuffle
playerctl shuffle off           # Disable shuffle
playerctl loop                  # Print loop status
playerctl loop Track            # Loop current track
playerctl loop Playlist         # Loop playlist
playerctl loop None             # Disable looping
playerctl open <uri>            # Open a URI in the player
```

## Key Flags

| Flag | Description |
|---|---|
| `-p <name>` / `--player <name>` | Target a specific player (e.g., `spotify`, `firefox`) |
| `-a` / `--all-players` | Send command to all players |
| `-i <name>` / `--ignore-player <name>` | Ignore specific player |
| `-f <fmt>` / `--format <fmt>` | Custom output format |
| `-F` / `--follow` | Continuously print on change |
| `-l` / `--list-all` | List available player names |
| `-s` / `--no-messages` | Suppress error messages |

## Format Strings

```bash
playerctl metadata --format '{{artist}} - {{title}}'
playerctl metadata --format '{{playerName}}: {{status}}'
playerctl metadata --format '{{duration(position)}} / {{duration(mpris:length)}}'
playerctl metadata --format '{{markup_escape(title)}}'
```

### Available Format Variables

| Variable | Description |
|---|---|
| `{{artist}}` | Track artist |
| `{{album}}` | Album name |
| `{{title}}` | Track title |
| `{{playerName}}` | Player name |
| `{{status}}` | Playing/Paused/Stopped |
| `{{position}}` | Position in microseconds |
| `{{mpris:length}}` | Track length in microseconds |
| `{{volume}}` | Player volume |
| `{{mpris:artUrl}}` | Album art URL |
| `{{xesam:url}}` | Track URL |
| `{{shuffle}}` | Shuffle on/off |
| `{{loop}}` | Loop status |
| `{{duration(var)}}` | Format microseconds as H:MM:SS |
| `{{markup_escape(var)}}` | Escape pango markup |
| `{{emoji(status)}}` | Status as emoji |

## Player Priority

```bash
# Target specific player
playerctl -p spotify play-pause

# Comma-separated priority list (first available wins)
playerctl -p spotify,firefox,chromium play-pause

# All players at once
playerctl -a pause

# List available players
playerctl -l
```

## Follow Mode

```bash
# Continuously print now-playing info
playerctl metadata --format '{{artist}} - {{title}}' -F

# Useful for waybar custom module or status bar
```

## Hyprland Keybind Examples

```
bind = , XF86AudioPlay, exec, playerctl play-pause
bind = , XF86AudioNext, exec, playerctl next
bind = , XF86AudioPrev, exec, playerctl previous
bind = , XF86AudioStop, exec, playerctl stop
```

## playerctld

The daemon tracks the most recently active player and makes it the default target.

```bash
playerctld daemon                # Start the daemon
playerctl --player playerctld   # Use last-active player
```
