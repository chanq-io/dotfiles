# Lazydocker Cheatsheet

Terminal UI for Docker -- view and manage containers, images, volumes, and networks without memorizing commands.

---

## Launch

```bash
lazydocker                # Start TUI
DOCKER_HOST=ssh://user@host lazydocker  # Connect to remote Docker
```

## Panels

Lazydocker has a sidebar (left) and main content area (right). The sidebar lists:

| Panel | Description |
|---|---|
| **Containers** | Running and stopped containers from compose or standalone |
| **Images** | Local Docker images |
| **Volumes** | Docker volumes |
| **Networks** | Docker networks (if enabled in config) |

## Global Navigation

| Key | Action |
|---|---|
| `Tab` / `Shift+Tab` | Cycle between panels |
| `[` / `]` | Cycle through tabs in main view |
| `j` / `k` or arrows | Move up/down in lists |
| `h` / `l` or arrows | Switch sidebar/main panel |
| `Enter` | Select / confirm |
| `/` | Filter current list |
| `q` / `Ctrl+c` | Quit lazydocker |
| `x` | Open command menu for selected item |
| `?` | Show help / keybindings |
| `+` | Show/expand all (bulk view) |
| `m` | View main logs (compose project) |

## Container Panel

### Tabs (cycle with `[` / `]`)

| Tab | Shows |
|---|---|
| **Logs** | Container log output (streaming) |
| **Stats** | CPU, memory, network I/O graphs |
| **Config** | Container configuration / environment |
| **Top** | Running processes inside the container |

### Container Actions

| Key | Action |
|---|---|
| `d` | Stop container |
| `s` | Stop container |
| `r` | Restart container |
| `u` | Start (up) container |
| `a` | Attach to container (view live output) |
| `D` | Remove container |
| `S` | Stop all containers (compose project) |
| `U` | Start all containers (compose project) |
| `R` | Rebuild and restart (compose) |
| `e` | Exec shell into container (opens `/bin/sh`) |
| `E` | Exec shell with custom command |
| `b` | View bulk commands |
| `c` | Run custom command |
| `Enter` | Focus on container details |

## Image Panel

| Key | Action |
|---|---|
| `d` / `D` | Remove image |
| `Enter` | View image details |
| `x` | Open command menu |

## Volume Panel

| Key | Action |
|---|---|
| `d` / `D` | Remove volume |
| `Enter` | View volume details |
| `x` | Open command menu |

## Log Viewing

| Key | Action |
|---|---|
| `j` / `k` | Scroll down/up |
| `G` | Jump to bottom |
| `g` | Jump to top |
| `f` | Follow mode (auto-scroll) |
| `/` | Search in logs |
| `n` | Next search match |
| `N` | Previous search match |
| `w` | Toggle line wrapping |

## Filtering

- Press `/` in any panel to type a filter string.
- Filters match container/image/volume names.
- Press `Esc` to clear the filter.

## Configuration

Config file location: `~/.config/lazydocker/config.yml`

```yaml
# Example config
gui:
  showAllContainers: true    # Show stopped containers
  scrollHeight: 2
  theme:
    activeBorderColor:
      - green
      - bold
commandTemplates:
  # Add custom commands
  dockerCompose: "docker compose"
  # Custom shell command for 'e' key
  shell: "bash"
logs:
  timestamps: true
  since: "60m"               # Default log time range
```

## Tips

- Press `x` on any item to see all available commands for that resource.
- Use `e` on a container to quickly get a shell -- much faster than typing `docker exec`.
- The stats tab gives you a live `docker stats` view with graphs.
- Lazydocker respects `COMPOSE_FILE` and `COMPOSE_PROJECT_NAME` env vars.
- Run `lazydocker --help` to see CLI flags.
