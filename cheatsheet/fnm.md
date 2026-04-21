# fnm Cheatsheet

Fast Node Manager -- a fast, cross-platform Node.js version manager built in Rust.

---

## Setup

Add to shell profile:

```bash
# bash/zsh
eval "$(fnm env)"

# with options
eval "$(fnm env --use-on-cd --shell zsh)"

# fish
fnm env --use-on-cd --shell fish | source
```

## Core Commands

| Command | Description |
|---------|-------------|
| `fnm install VERSION` | Install a Node version |
| `fnm use VERSION` | Switch to a version (current shell) |
| `fnm default VERSION` | Set default version |
| `fnm current` | Show currently active version |
| `fnm list` | List locally installed versions |
| `fnm list-remote` | List all available versions |
| `fnm uninstall VERSION` | Remove an installed version |
| `fnm alias NAME VERSION` | Create a named alias for a version |
| `fnm unalias NAME` | Remove an alias |
| `fnm exec` | Run a command with a specific version |
| `fnm env` | Print environment variables for shell setup |

## Install Examples

```bash
fnm install 22               # latest v22.x
fnm install 20.11.0          # specific version
fnm install --lts            # latest LTS
fnm install node             # latest current
fnm install --latest         # alias for latest current
```

## Use Examples

```bash
fnm use 22                   # switch to latest installed v22.x
fnm use 20.11.0              # switch to exact version
fnm use default              # switch to default version
fnm use system               # switch to system-installed node
fnm use --install-if-missing 22   # install and switch
```

## Listing Versions

```bash
fnm list                     # installed versions
fnm list-remote              # all available versions
fnm list-remote --lts        # only LTS versions
fnm list-remote | grep v22   # filter remote versions
```

## Aliases

```bash
fnm alias default 22         # set default to v22
fnm alias my-project 20.11.0 # custom alias
fnm use my-project           # use aliased version
fnm unalias my-project       # remove alias
```

## Running Commands with Specific Versions

```bash
fnm exec --using=20 -- node -v     # run with specific version
fnm exec --using=22 -- npm test    # run npm with specific version
```

## Automatic Version Switching

When `--use-on-cd` is enabled, fnm reads version files when you `cd` into a directory.

Supported version files (in priority order):

1. `.node-version`
2. `.nvmrc`
3. `package.json` `engines.node` field (with `--resolve-engines`)

```bash
echo "22" > .node-version    # pin version for a project
echo "lts/*" > .nvmrc        # use latest LTS
```

## Environment / Config Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `FNM_DIR` | Directory for fnm data (versions, aliases) | `~/.local/share/fnm` |
| `FNM_NODE_DIST_MIRROR` | Mirror URL for downloading Node | `https://nodejs.org/dist` |
| `FNM_MULTISHELL_PATH` | Path for multishell support | auto |
| `FNM_LOGLEVEL` | Log level: `quiet`, `error`, `info` | `info` |
| `FNM_ARCH` | Override architecture | auto |
| `FNM_VERSION_FILE_STRATEGY` | `local` (current dir only) or `recursive` (walk up) | `local` |
| `FNM_COREPACK_ENABLED` | Enable corepack when installing Node | `false` |
| `FNM_RESOLVE_ENGINES` | Resolve `engines.node` from package.json | `false` |

## fnm env Flags

| Flag | Description |
|------|-------------|
| `--use-on-cd` | Auto-switch Node on directory change |
| `--shell SHELL` | Target shell: `bash`, `zsh`, `fish`, `powershell` |
| `--log-level LEVEL` | Set log level |
| `--version-file-strategy` | `local` or `recursive` |
| `--corepack-enabled` | Enable corepack |
| `--resolve-engines` | Use package.json engines field |

## Completions

```bash
fnm completions --shell zsh > _fnm    # generate completions
fnm completions --shell bash          # bash completions
fnm completions --shell fish          # fish completions
```

## Comparison with nvm

| Feature | fnm | nvm |
|---------|-----|-----|
| Speed | Very fast (Rust) | Slow (shell script) |
| `.nvmrc` support | Yes | Yes |
| `.node-version` | Yes | No |
| Cross-platform | Yes | Unix only |
| Shell startup impact | Minimal | Noticeable |
