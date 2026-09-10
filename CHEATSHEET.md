# Cheatsheets

Quick-reference guides for the tools in this setup — NixOS `shrike` and macOS (Homebrew). Each links to a standalone markdown file in [`cheatsheet/`](cheatsheet/). Most tools are on both platforms; the Hyprland/Wayland section is NixOS-only, [ghostty](cheatsheet/ghostty.md) is macOS-only.

Search interactively with the `cheatsheet` command (`bin/cheatsheet`): it fuzzy-searches every entry of every sheet as `sheet › section › content` (space-separated terms, e.g. `nvim checkbox`), previewing the matched section rendered with glow; pass an initial query as arguments. `cheatsheet -l` browses sheets by name with a rendered preview.

---

## Nix Tooling

- [nix](cheatsheet/nix.md) — Nix CLI, flakes, NixOS rebuild, language reference, store & GC
- [home-manager](cheatsheet/home-manager.md) — User-level config modules, programs, services

## Shell & Prompt

- [zsh](cheatsheet/zsh.md) — Shell builtins, globbing, history, line editing (vi-mode here)
- [atuin](cheatsheet/atuin.md) — Shell history search (owns `Ctrl+R`)
- [starship](cheatsheet/starship.md) — Cross-shell prompt config & modules
- [direnv](cheatsheet/direnv.md) — Per-directory env auto-loading + nix-direnv

## Files, Search & Navigation

- [eza](cheatsheet/eza.md) — Modern `ls` with git & tree support
- [bat](cheatsheet/bat.md) — `cat` with syntax highlighting
- [fd](cheatsheet/fd.md) — Modern `find`
- [ripgrep](cheatsheet/ripgrep.md) — Fast recursive grep
- [sd](cheatsheet/sd.md) — Intuitive find-and-replace (`sed` alternative)
- [fzf](cheatsheet/fzf.md) — Fuzzy finder
- [zoxide](cheatsheet/zoxide.md) — Smart `cd` (frecency-based)
- [yazi](cheatsheet/yazi.md) — TUI file manager
- [tldr](cheatsheet/tldr.md) — Simplified man pages

## Editors

- [neovim](cheatsheet/neovim.md) — Motions, LSP, plugin keymaps & custom commands
- [glow](cheatsheet/glow.md) — TUI markdown renderer
- [zathura](cheatsheet/zathura.md) — Vim-keybound PDF viewer (SyncTeX with vimtex)

## Languages & Runtimes

- [cargo](cheatsheet/cargo.md) — Rust toolchain (cargo + rustup)
- [fnm](cheatsheet/fnm.md) — Fast Node Manager
- [pnpm](cheatsheet/pnpm.md) — Fast npm-compatible package manager
- [deno](cheatsheet/deno.md) — Secure JS/TS runtime
- [uv](cheatsheet/uv.md) — Fast Python package & venv manager
- [cmake](cheatsheet/cmake.md) — Cross-platform build system
- [protobuf](cheatsheet/protobuf.md) — Protocol buffer compiler
- [tree-sitter](cheatsheet/tree-sitter.md) — Parser generator CLI

## Build & Task

- [just](cheatsheet/just.md) — Command runner (Makefile alternative)
- [watchexec](cheatsheet/watchexec.md) — Run commands on file change
- [hyperfine](cheatsheet/hyperfine.md) — CLI benchmarking
- [tokei](cheatsheet/tokei.md) — Lines-of-code counter

## Git & Code Review

- [git](cheatsheet/git.md) — Git + git-extras
- [gh](cheatsheet/gh.md) — GitHub CLI
- [lazygit](cheatsheet/lazygit.md) — TUI git client
- [delta](cheatsheet/delta.md) — Syntax-highlighted diff pager
- [difftastic](cheatsheet/difftastic.md) — Structural diff (`git dft` / `git dlog`)

## Containers & Orchestration

- [docker](cheatsheet/docker.md) — Container runtime + Compose
- [lazydocker](cheatsheet/lazydocker.md) — TUI for Docker
- [kubectl](cheatsheet/kubectl.md) — Kubernetes CLI
- [k9s](cheatsheet/k9s.md) — TUI for Kubernetes

## HTTP, APIs & Network

- [httpie](cheatsheet/httpie.md) — Human-friendly HTTP client
- [xh](cheatsheet/xh.md) — Fast httpie alternative (Rust)
- [slumber](cheatsheet/slumber.md) — TUI HTTP client (YAML-driven)
- [bandwhich](cheatsheet/bandwhich.md) — Per-process bandwidth monitor

## Cloud & Infrastructure

- [awscli](cheatsheet/awscli.md) — AWS CLI
- [terraform](cheatsheet/terraform.md) — Infrastructure as code
- [supabase](cheatsheet/supabase.md) — Supabase project CLI
- [vercel](cheatsheet/vercel.md) — Vercel deployments

## Databases

- [psql](cheatsheet/psql.md) — PostgreSQL client
- [redis-cli](cheatsheet/redis-cli.md) — Redis client

## System Monitoring

- [btop](cheatsheet/btop.md) — TUI system monitor
- [procs](cheatsheet/procs.md) — Modern `ps`
- [dust](cheatsheet/dust.md) — Visual disk usage
- [duf](cheatsheet/duf.md) — Modern `df`

## Audio & Media

- [ffmpeg](cheatsheet/ffmpeg.md) — Media conversion & processing
- [sox](cheatsheet/sox.md) — Audio processing
- [gifsicle](cheatsheet/gifsicle.md) — GIF optimization
- [p7zip](cheatsheet/p7zip.md) — 7-Zip archiver
- [qpwgraph](cheatsheet/qpwgraph.md) — PipeWire patchbay
- [spotify-player](cheatsheet/spotify-player.md) — TUI Spotify client

## Image & TUI Graphics

- [chafa](cheatsheet/chafa.md) — Terminal image renderer
- [viu](cheatsheet/viu.md) — Terminal image viewer
- [graphviz](cheatsheet/graphviz.md) — Graph rendering (DOT language)

## Misc CLI

- [jq](cheatsheet/jq.md) — JSON processor
- [yq](cheatsheet/yq.md) — YAML/TOML/XML processor (jq-style)
- [pandoc](cheatsheet/pandoc.md) — Universal document converter
- [watch](cheatsheet/watch.md) — Re-run commands at intervals
- [op](cheatsheet/op.md) — 1Password CLI
- [claude-code](cheatsheet/claude-code.md) — Claude Code CLI
- [codex](cheatsheet/codex.md) — OpenAI Codex agentic coding CLI

## Desktop (Hyprland / Wayland)

- [hyprland](cheatsheet/hyprland.md) — Tiling Wayland compositor
- [kitty](cheatsheet/kitty.md) — GPU-accelerated terminal
- [ghostty](cheatsheet/ghostty.md) — Terminal on macOS
- [waybar](cheatsheet/waybar.md) — Status bar
- [wofi](cheatsheet/wofi.md) — Application launcher
- [mako](cheatsheet/mako.md) — Notification daemon
- [hyprlock](cheatsheet/hyprlock.md) — Lock screen
- [hypridle](cheatsheet/hypridle.md) — Idle daemon
- [swww](cheatsheet/swww.md) — Wallpaper daemon
- [hyprshot](cheatsheet/hyprshot.md) — Screenshot tool
- [cliphist](cheatsheet/cliphist.md) — Clipboard history
- [playerctl](cheatsheet/playerctl.md) — Media key bindings
- [gammastep](cheatsheet/gammastep.md) — Blue-light filter
- [grim](cheatsheet/grim.md) — Screenshot primitives (grim + slurp)
- [wl-clipboard](cheatsheet/wl-clipboard.md) — Wayland clipboard CLI
