# direnv + nix-direnv

Per-directory environment auto-loading. Activates when you `cd` into a directory with an `.envrc`.

---

## Commands

| Command | Action |
|---------|--------|
| `direnv allow` | Trust the current `.envrc` |
| `direnv deny` | Block the current `.envrc` |
| `direnv reload` | Force reload |
| `direnv status` | Show current state |
| `direnv edit .` | Open `.envrc` in `$EDITOR` and allow on save |
| `direnv prune` | Remove expired allowed entries |
| `direnv fetchurl url hash` | Download and cache a URL |
| `direnv stdlib` | Print available stdlib functions |

## .envrc Recipes

```bash
# Load a Nix flake devshell (nix-direnv)
use flake

# Load a specific flake output
use flake .#myshell

# Load a flake from a subdirectory
use flake ./subdir

# Classic Nix shell (shell.nix / default.nix)
use nix

# Set env vars
export DATABASE_URL="postgres://localhost/mydb"
export DEBUG=1

# Add to PATH
PATH_add bin
PATH_add node_modules/.bin

# Source another env file
dotenv                          # loads .env
dotenv .env.local               # loads specific file

# Python virtualenv
layout python                   # python2
layout python3                  # python3
layout pyenv 3.11.0             # specific version

# Ruby
layout ruby

# Node
layout node

# Watch extra files for changes
watch_file shell.nix
watch_file flake.nix
watch_file flake.lock

# Load if file exists
source_env_if_exists .envrc.local
```

## nix-direnv Specifics

nix-direnv caches Nix evaluations so reloads are instant after the first build.

```bash
# Cache location
# ~/.cache/direnv/

# Force re-evaluation
nix-direnv-reload

# In .envrc — use flake is the main entry point
use flake
```

## Troubleshooting

```bash
# Check if direnv is hooked into shell
direnv status

# See what direnv would load
direnv exec . env

# Manually trigger reload after editing .envrc
direnv allow

# If nix-direnv cache is stale
nix-direnv-reload

# Verbose logging
export DIRENV_LOG_FORMAT=""    # silence logs
export DIRENV_LOG_FORMAT='direnv: %s'  # default
```
