# Atuin

SQLite-backed shell history with context-aware fuzzy search. Enabled via home-manager with zsh integration — **it owns `Ctrl+R` and `Up`** in this setup.

---

## Interactive Search (TUI)

| Key | Action |
|-----|--------|
| `Ctrl+R` | Open history search (repeat to cycle filter modes) |
| `Up` | Open search scoped to current context |
| `Type` | Fuzzy filter |
| `Up` / `Down` / `Ctrl+P` / `Ctrl+N` | Move selection |
| `Enter` | Run selected command |
| `Tab` | Insert selected command into prompt (edit before running) |
| `Alt+1`–`Alt+9` | Select numbered result directly |
| `Ctrl+O` | Open inspector on selected entry (stats, delete) |
| `Ctrl+D` | Delete selected history entry (in inspector) |
| `Esc` / `Ctrl+C` | Close without running |

### Filter modes (cycle with `Ctrl+R` inside the TUI)

| Mode | Scope |
|------|-------|
| `global` | All history, all hosts |
| `host` | This machine only |
| `session` | This shell session only |
| `directory` | Commands run in the current directory |
| `workspace` | Commands run in the current git repo |

## CLI

```bash
atuin search <query>            # non-interactive search
atuin search --exit 0 <query>   # only successful commands
atuin search --cwd .            # commands run in this directory
atuin search --before "1 day ago" --after "1 week ago" <query>

atuin stats                     # most-used commands overall
atuin stats day                 # stats for today
atuin history list              # dump history
atuin history last              # last recorded command

atuin import auto               # import existing shell history (zsh/bash/…)
```

## Sync (optional, off by default)

```bash
atuin register -u <user> -e <email>   # create sync account
atuin login -u <user>                 # login on another machine
atuin sync                            # manual sync (also runs automatically)
atuin key                             # show encryption key (needed on new machines)
```

History is end-to-end encrypted; the server never sees plaintext.

## Config

`~/.config/atuin/config.toml` — useful options:

| Option | Effect |
|--------|--------|
| `search_mode` | `fuzzy` (default) / `prefix` / `fulltext` |
| `filter_mode` | Default filter mode on open |
| `filter_mode_shell_up_key_binding` | Filter mode for the `Up` binding |
| `style` | `auto` / `full` / `compact` |
| `inline_height` | Rows for inline (non-fullscreen) TUI |
| `history_filter` | Regex list of commands to never record |
| `secrets_filter` | Skip recording likely secrets (default true) |

## This setup

- Enabled in `nixos/modules/home/shell.nix` (`programs.atuin.enable` + `enableZshIntegration`).
- Replaces zsh's reverse-i-search on `Ctrl+R`; plain `!!`/`!$` history expansion still works.
