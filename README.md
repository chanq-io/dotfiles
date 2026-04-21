# dotfiles

Personal dotfiles and system configuration for macOS and NixOS.

- **macOS** is set up imperatively: a zsh installer (`macos/install.zsh`) installs Homebrew packages and symlinks tracked configs into place. Currently the only working setup.
- **NixOS** (host: `shrike`) will be set up declaratively via a Nix flake under `nixos/`, with [home-manager](https://github.com/nix-community/home-manager) handling user-level configuration. **Not yet implemented** — see the [TODO](#todo) section.
- Shared dotfiles (`shell/`, `nvim/`, `lib/`) live at the repo root so both hosts can consume them.

The long-term goal is to migrate the macOS host to [nix-darwin](https://github.com/LnL7/nix-darwin) so both machines share the same flake and home-manager modules.

> **[Cheatsheets](CHEATSHEET.md)** — quick-reference guides for every tool in the stack.

---

## Repository layout

```
~/.dotfiles/
├── macos/                     # macOS-specific installer + configs
│   ├── install.zsh            # entry point: brew + symlinks + plugins
│   ├── update.zsh
│   ├── ghostty/               # ghostty terminal config
│   └── cargo/                 # cargo config
├── nixos/                     # NixOS flake (under construction)
│   ├── flake.nix
│   ├── flake.lock
│   ├── hosts/
│   │   └── shrike/
│   │       ├── default.nix
│   │       └── hardware-configuration.nix
│   └── modules/
│       ├── nixos/             # system-level NixOS modules
│       └── home/              # home-manager modules (portable to nix-darwin)
├── shell/                     # shared zsh config (zshrc, aliases, variables, starship)
├── nvim/                      # shared Neovim config (lazy.nvim-managed)
└── lib/
    └── theme.nix              # shared Base16 palette
```

---

## Hosts

| Host     | OS         | Hardware                                       | Status      |
| -------- | ---------- | ---------------------------------------------- | ----------- |
| (laptop) | macOS      | MacBook                                        | Live        |
| `shrike` | NixOS 25.11 | TUXEDO PRO XL AMD Gen2, Ryzen 9000, AMD GPU, 64GB RAM, dual-boot with Windows | Pre-flake (basic config running) |

---

## macOS setup

Fresh machine:

```sh
git clone git@github.com:chanq-io/dotfiles.git ~/.dotfiles
cd ~/.dotfiles/macos
./install.zsh
```

`install.zsh` is idempotent. It will:

- Install Homebrew if missing.
- Install the formulae and casks listed in the script (skips anything already installed).
- Install zsh plugins via [antidote](https://github.com/mattmc3/antidote).
- Install Rust (rustup), Node (nvm), Starship prompt, and `uv` Python venv for Neovim.
- Symlink configs into `$HOME` (zshrc, ghostty, cargo, nvim).

To re-run after pulling updates: `install-deps` (alias) or `./install.zsh` directly.

---

## NixOS setup

After the flake is in place:

```sh
git clone git@github.com:chanq-io/dotfiles.git ~/.dotfiles
sudo nixos-rebuild switch --flake ~/.dotfiles/nixos#shrike
```

To update inputs (nixpkgs, home-manager, etc.) and rebuild:

```sh
nix flake update ~/.dotfiles/nixos
sudo nixos-rebuild switch --flake ~/.dotfiles/nixos#shrike
```

Pinning strategy: inputs follow the `nixos-25.11` channel; `flake.lock` provides exact reproducibility. Bump release branches manually when ready.

---

## Tooling reference

This is the full inventory both hosts will end up with (modulo macOS not getting the Hyprland/Wayland-specific bits).

### Shell & prompt

| Tool | What | Example |
|------|------|---------|
| `zsh` | Shell | — |
| `starship` | Cross-shell prompt with git/lang awareness | `starship init zsh` |
| `antidote` | Fast zsh plugin manager (macOS only — NixOS uses home-manager modules) | `antidote install zsh-users/zsh-autosuggestions` |
| `direnv` + `nix-direnv` | Per-project env auto-loading | `echo "use flake" > .envrc && direnv allow` |

### Files, search, navigation

| Tool | What | Example |
|------|------|---------|
| `eza` | Modern `ls`, tree mode, git status integration | `eza -la --git --tree --level=2` |
| `bat` | `cat` with syntax highlighting + paging | `bat README.md` |
| `fd` | Modern `find` | `fd -e rs main` |
| `ripgrep` (`rg`) | Fast recursive grep | `rg "TODO" --type rust` |
| `fzf` | Fuzzy finder | `vim $(fzf)` |
| `zoxide` | Smart `cd` that learns your most-used dirs | `z dotfi` jumps to `~/.dotfiles` |
| `yazi` | TUI file manager (Rust) | `yazi` |
| `tldr` | Practical command examples | `tldr tar` |
| `ag` (silver searcher) | Legacy grep alternative — kept for muscle memory | `ag "pattern"` |

### Editors

| Tool | What | Example |
|------|------|---------|
| `neovim` | Editor — config in `nvim/`, plugins managed by lazy.nvim | `nvim file.rs` |
| `glow` | TUI markdown renderer | `glow README.md` |

### Languages & runtimes

| Tool | What | Example |
|------|------|---------|
| `rustup` (macOS) / `rustc` + `cargo` (NixOS via overlay) | Rust toolchain | `cargo new myapp` |
| `fnm` (NixOS) / `nvm` (macOS) | Node version manager | `fnm use 20` |
| `pnpm` | Fast npm-compatible package manager | `pnpm install` |
| `deno` | JS/TS runtime, secure-by-default | `deno run main.ts` |
| `uv` | Fast Python package + venv manager | `uv venv && uv pip install ruff` |
| `cmake` | Cross-platform build system | `cmake -B build && cmake --build build` |
| `llvm` | LLVM toolchain (clang, lld, etc.) | `clang main.c` |
| `protobuf` | Protocol buffer compiler | `protoc --rust_out=. schema.proto` |
| `tree-sitter` | Parser generator (also nvim treesitter dep) | `tree-sitter generate` |

### Build & task

| Tool | What | Example |
|------|------|---------|
| `just` | Command runner (Makefile alternative) | `just build` |
| `gcc` / `llvm` | Compilers (also needed for nvim treesitter parsers) | — |

### Git & code review

| Tool | What | Example |
|------|------|---------|
| `git` + `git-extras` | VCS with extra subcommands | `git ignore-io rust > .gitignore` |
| `gh` | GitHub CLI | `gh pr create --fill` |
| `lazygit` | TUI git client | `lazygit` |
| `delta` | Syntax-highlighted git diff pager | (set as `core.pager`) |

### Containers & orchestration

| Tool | What | Example |
|------|------|---------|
| `docker` | Container runtime (system service on NixOS) | `docker run -it ubuntu` |
| `docker-compose` | Multi-container apps | `docker compose up` |
| `lazydocker` | TUI for docker (containers, images, logs) | `lazydocker` |
| `kubectl` | Kubernetes CLI | `kubectl get pods` |
| `k9s` | TUI for Kubernetes | `k9s` |

### HTTP, APIs, network

| Tool | What | Example |
|------|------|---------|
| `httpie` | Human-friendly HTTP CLI | `http GET api.example.com/users` |
| `xh` | Rust rewrite of httpie, fast startup | `xh GET api.example.com/users` |
| `slumber` | TUI HTTP client, YAML-driven (Postman alt.) | `slumber` |
| `wget` | Classic file downloader | `wget https://...` |
| `bandwhich` | Real-time per-process network bandwidth | `sudo bandwhich` |

### Cloud & infrastructure

| Tool | What | Example |
|------|------|---------|
| `awscli` | AWS CLI | `aws s3 ls` |
| `terraform` | Infrastructure as code | `terraform apply` |
| `supabase` | Supabase project CLI | `supabase start` |
| `vercel-cli` | Vercel deployments | `vercel deploy` |

### Databases

| Tool | What | Example |
|------|------|---------|
| `psql` | PostgreSQL client | `psql -h localhost -U postgres` |
| `redis` (provides `redis-cli`) | Redis client | `redis-cli ping` |

### System monitoring

| Tool | What | Example |
|------|------|---------|
| `btop` | TUI system monitor (CPU/mem/disk/network) | `btop` |
| `procs` | Modern `ps` (coloured, tree view) | `procs --tree` |
| `dust` | Visual disk usage tree | `dust ~/Downloads` |
| `duf` | Modern `df` with coloured tables | `duf` |
| `radeontop` (NixOS, AMD GPU) | AMD GPU usage monitor | `radeontop` |

### Audio & media

| Tool | What | Example |
|------|------|---------|
| `ffmpeg` | Media swiss-army knife | `ffmpeg -i in.mov -c:v libx264 out.mp4` |
| `sox` | Audio processing | `sox in.wav -r 16000 out.wav` |
| `fdk-aac` | High-quality AAC encoder for ffmpeg | (used by ffmpeg) |
| `gifsicle` | GIF optimisation | `gifsicle -O3 in.gif -o out.gif` |
| `p7zip` | 7-Zip archive support | `7z x archive.7z` |
| `qpwgraph` (NixOS) | PipeWire patchbay (route audio between apps) | `qpwgraph` |
| `spotify-player` | TUI Spotify client | `spotify_player` |

### Image / TUI

| Tool | What | Example |
|------|------|---------|
| `chafa` | Render images as terminal graphics | `chafa image.png` |
| `viu` | Image viewer for the terminal (Rust) | `viu image.png` |
| `ueberzugpp` | Inline images for terminals (used by yazi) | (called by yazi/nvim) |
| `graphviz` | Graph rendering (`dot`, `neato`) | `dot -Tpng graph.gv -o graph.png` |
| `utftex` | LaTeX → unicode for terminals | `utftex "\sum_{i=0}^n i^2"` |

### Misc CLI

| Tool | What | Example |
|------|------|---------|
| `jq` | JSON processor | `cat data.json \| jq '.users[].name'` |
| `watch` | Re-run a command at intervals | `watch -n1 nvidia-smi` |
| `telnet` | Network testing | `telnet host 443` |
| `1password-cli` (`op`) | 1Password CLI (used to inject secrets into env) | `op read op://Personal/X/credential` |
| `claude-code` | Claude Code CLI | `claude` |

### Desktop (NixOS / Wayland only)

| Tool | What | Example / Keybind |
|------|------|---------|
| `hyprland` | Wayland tiling compositor | `Super+Return` (kitty), `Super+D` (wofi) |
| `waybar` | Status bar | (auto-started) |
| `wofi` | Application launcher / dmenu replacement | `Super+D` |
| `mako` | Notification daemon | (auto-started) |
| `hyprlock` | Lock screen | `Super+L` |
| `hypridle` | Idle daemon (lock + DPMS) | (auto-started) |
| `swww` | Wallpaper daemon with animations | `swww img wallpaper.jpg` |
| `hyprshot` | Screenshot wrapper (region/window/output) | `Super+S` |
| `cliphist` | Clipboard history | `Super+V` |
| `playerctl` | Media key bindings (MPRIS) | (bound to media keys) |
| `gammastep` | Blue-light filter for Wayland | (auto-started, location-based) |
| `grim` + `slurp` | Wayland screenshot primitives (used by hyprshot) | — |
| `wl-clipboard` | Wayland clipboard CLI | `wl-copy < file.txt` |
| `kitty` | GPU-accelerated terminal | `Super+Return` |

### GUI apps (NixOS)

| App | Purpose |
|-----|---------|
| Zen Browser | Daily-driver browser; messaging happens here in pinned tabs (Slack, WhatsApp, Lark) |
| ungoogled-chromium | Cross-browser testing |
| 1Password | Password manager |
| Claude desktop | Chat client |
| Betterbird | Email + calendar (Thunderbird fork) |
| Spotify | Music (`spotify-player` TUI also available) |
| Steam | Games (system-level module) |
| Dropbox (via `maestral`) | File sync |

---

## Theming

**Base16 Black Metal (Bathory)** applied across kitty, waybar, wofi, mako, hyprlock, and Neovim. Palette lives in `lib/theme.nix` as a single attrset; every module that needs colours imports from there.

Roadmap: a future iteration may swap the static palette for a runtime-generated one (via [wallust](https://codeberg.org/explosion-mental/wallust) or [matugen](https://github.com/InioX/matugen)) so the system theme follows the wallpaper.

---

## Roadmap

- **nix-darwin migration**: once `shrike` is comfortable for daily use, migrate the macOS host to [nix-darwin](https://github.com/LnL7/nix-darwin) and consolidate both hosts under a single root-level flake. The home-manager modules under `nixos/modules/home/` are written to be portable.
- **Dynamic theming**: replace the static Base16 palette with a wallust/matugen pipeline that regenerates colours from the current wallpaper and reloads live-reloadable services (Hyprland, kitty, mako).
- **CLI mail / calendar**: explore `aerc` + `khal` + `vdirsyncer` + `mbsync` as a TUI replacement for Betterbird. Provider-dependent: trivial for plain IMAP/CalDAV, fiddly for Gmail/O365 due to OAuth.
- **tmux / zellij**: add if local sessions need to survive terminal close, or once SSH workflows pick up.
- **Secrets management**: currently out-of-band (generate on first install, back up `~/.ssh/` to 1Password). Migrate to [agenix](https://github.com/ryantm/agenix) if/when a second machine joins, to enable repo-tracked encrypted secrets.

---

## TODO

Build-out checklist for the NixOS flake. Will be removed once the system is up and running.

### Foundation
- [ ] Promote `nvim/` from `macos/nvim/` to repo root
- [ ] Promote `shell/` from `macos/shell/` to repo root, split aliases into `aliases.zsh` (portable) + `aliases.macos.zsh` + `aliases.nixos.zsh`
- [ ] Update `macos/install.zsh` to symlink from new root locations
- [ ] Create `lib/theme.nix` with Base16 Black Metal Bathory palette
- [ ] Scaffold `nixos/flake.nix` with nixpkgs (nixos-25.11) and home-manager (release-25.11) inputs
- [ ] Scaffold `nixos/hosts/shrike/{default.nix,hardware-configuration.nix}`

### System modules (`nixos/modules/nixos/`)
- [ ] `boot.nix` — GRUB + sleek-grub-theme + latest kernel
- [ ] `hardware.nix` — PipeWire (with JACK API), AMD graphics, hardware.graphics
- [ ] `networking.nix` — hostname, NetworkManager, firewall
- [ ] `locale.nix` — Europe/London, en_GB.UTF-8, US keyboard
- [ ] `services.nix` — openssh, docker, greetd + tuigreet
- [ ] `desktop.nix` — `programs.hyprland.enable`, XDG portals
- [ ] `fonts.nix` — Fira Mono Nerd Font, Noto Sans, Noto Color Emoji
- [ ] `users.nix` — cardamom user, groups (wheel, networkmanager, video, docker, audio)
- [ ] `nix.nix` — flakes, allowUnfree, auto-optimise, weekly GC
- [ ] `steam.nix` — `programs.steam.enable`

### Home modules (`nixos/modules/home/`)
- [ ] `default.nix` — entry point, imports
- [ ] `shell.nix` — zsh + antidote-equivalent plugins + starship + alias/variable file inlining
- [ ] `cli.nix` — files/search/system tools (eza, bat, fd, rg, fzf, zoxide, yazi, jq, tldr, dust, duf, procs, bandwhich, glow, etc.)
- [ ] `dev.nix` — languages + build (rust, fnm, pnpm, deno, uv, cmake, llvm, protobuf, just, tree-sitter, terraform, awscli, supabase, vercel, k9s, kubectl, etc.)
- [ ] `git.nix` — git config + delta + lazygit + gh
- [ ] `neovim.nix` — halfway-house: install neovim + LSP/formatter/runtime deps, symlink `~/.dotfiles/nvim` → `~/.config/nvim`
- [ ] `direnv.nix` — direnv + nix-direnv
- [ ] `terminal.nix` — kitty (Base16 theme, JetBrains Mono / Fira Mono Nerd, opacity 0.9, beam cursor)
- [ ] `hyprland.nix` — monitor (HDMI-A-3, 3840x2160@30, scale 1.5), keybinds, gaps, animations, exec-once
- [ ] `waybar.nix` — bottom position, workspaces left, time centre, cpu/ram/net/vol right
- [ ] `wofi.nix` — themed, 500x400, overlay
- [ ] `mako.nix` — themed, JetBrains Mono 10, rounded corners, urgency colours
- [ ] `hyprlock.nix` — blurred wallpaper, time, password input
- [ ] `hypridle.nix` — lock after 5min, DPMS off after 10min
- [ ] `wallpaper.nix` — swww + wallpaper symlink
- [ ] `screenshot.nix` (or merge into hyprland) — hyprshot + grim/slurp + keybinds
- [ ] `cliphist.nix` — clipboard history daemon + Super+V binding
- [ ] `gammastep.nix` — blue-light filter
- [ ] `qpwgraph.nix` — PipeWire patchbay
- [ ] `media.nix` — playerctl, spotify-player, ffmpeg/sox/etc.
- [ ] `gui-apps.nix` — Zen, ungoogled-chromium, 1Password, claude-desktop, Betterbird, Spotify, maestral, claude-code (CLI)

### Bringup
- [ ] Copy current `/etc/nixos/hardware-configuration.nix` from `shrike` into `hosts/shrike/`
- [ ] Initial `nixos-rebuild switch --flake ~/.dotfiles/nixos#shrike` from `shrike`
- [ ] Verify Hyprland starts, theme applied across all components
- [ ] SCP wallpaper(s) into `~/wallpapers/`
- [ ] Test container runtime (`docker run hello-world`)
- [ ] Test JACK-aware audio app
- [ ] Confirm Steam launches, AMD GPU drivers loaded
- [ ] Verify SSH still accessible at `192.168.1.223`
- [ ] Push commits to remote once stable
