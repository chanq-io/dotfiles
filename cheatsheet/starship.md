# Starship

Cross-shell prompt with git, language, and environment awareness.

---

## Config

Config file: `~/.config/starship.toml`

```bash
# Create default config
starship preset no-nerd-font -o ~/.config/starship.toml

# Print default config
starship print-config

# Explain current prompt (debug)
starship explain

# Time the prompt
starship timings

# List presets
starship preset --list
```

## Key Config Sections

```toml
# Prompt format (order of modules)
format = "$directory$git_branch$git_status$character"

# Right-side prompt
right_format = "$cmd_duration$time"

# Newline between prompts
add_newline = true

# Timeout for commands (ms)
command_timeout = 500

[character]
success_symbol = "[➜](bold green)"
error_symbol = "[✗](bold red)"

[directory]
truncation_length = 3
truncate_to_repo = true
style = "bold cyan"

[git_branch]
symbol = " "
style = "bold purple"

[git_status]
conflicted = "⚔️ "
ahead = "⇡${count} "
behind = "⇣${count} "
modified = "!${count} "
untracked = "?${count} "
staged = "+${count} "

[cmd_duration]
min_time = 2000          # Show if > 2s
format = "took [$duration]($style) "

[time]
disabled = false
format = "[$time]($style) "
time_format = "%H:%M"

[nodejs]
detect_files = ["package.json", ".node-version"]
format = "[$symbol($version)]($style) "

[rust]
format = "[$symbol($version)]($style) "

[python]
format = "[$symbol($version)( $virtualenv)]($style) "

[nix_shell]
format = "[$symbol$state( $name)]($style) "
symbol = "❄️ "
```

## Module Toggle

```toml
# Disable a module
[aws]
disabled = true

# Show only specific modules
format = "$directory$git_branch$character"
```

## Environment Variables

| Variable | Effect |
|----------|--------|
| `STARSHIP_CONFIG` | Custom config path |
| `STARSHIP_CACHE` | Custom cache dir |
| `STARSHIP_LOG` | Log level (`trace`, `debug`, `info`, `warn`, `error`) |
| `STARSHIP_SESSION_KEY` | Unique session identifier |

## Useful Presets

```bash
starship preset nerd-font-symbols -o ~/.config/starship.toml
starship preset plain-text-symbols -o ~/.config/starship.toml
starship preset bracketed-segments -o ~/.config/starship.toml
starship preset tokyo-night -o ~/.config/starship.toml
```
