# spotify_player

TUI Spotify client with Vim-like keybindings.

---

## Setup

```bash
spotify_player authenticate     # first-time auth (opens browser)
spotify_player                  # launch TUI
```

Config: `~/.config/spotify-player/`

## Navigation

| Key | Action |
|-----|--------|
| `j` / `k` | Down / Up |
| `h` / `l` | Left panel / Right panel |
| `g g` | Go to top |
| `G` | Go to bottom |
| `Enter` | Select / Play |
| `Esc` / `q` | Back / Quit |
| `Tab` | Switch focus |

## Playback

| Key | Action |
|-----|--------|
| `Space` | Play / Pause |
| `n` | Next track |
| `p` | Previous track |
| `>` / `<` | Seek forward / backward |
| `+` / `-` | Volume up / down |
| `s` | Toggle shuffle |
| `r` | Cycle repeat (off → track → context) |
| `m` | Mute / unmute |

## Browsing

| Key | Action |
|-----|--------|
| `/` | Search |
| `B` | Browse library |
| `P` | Playlists |
| `A` | Albums |
| `T` | Tracks (liked) |
| `a` | Artists |

## Queue & Actions

| Key | Action |
|-----|--------|
| `Q` | View queue |
| `Ctrl+A` | Add to queue |
| `Ctrl+S` | Save to library |
| `d` | Open device list |
| `?` | Help / keybindings |

## Command Mode

| Key | Action |
|-----|--------|
| `:` | Open command prompt |
| `:q` | Quit |
| `:search QUERY` | Search |
| `:theme THEME` | Switch theme |
