# watchexec

Run a command whenever files change. The file-watching counterpart to `just`/`watch`.

---

## Usage

```bash
watchexec cargo test                    # rerun on any change in cwd
watchexec -e rs,toml cargo check        # only .rs / .toml changes
watchexec -w src -w tests cargo test    # watch specific paths
watchexec -r cargo run                  # restart long-running process on change
watchexec -c clear cargo test          # clear screen before each run
watchexec -- ls -la                     # use -- when the command has flags
watchexec 'make build && make test'     # shell string for pipelines/chains
```

## Common Flags

| Flag | Effect |
|------|--------|
| `-e <exts>` | Filter by extensions (comma-separated, no dots needed) |
| `-w <path>` | Watch path (repeatable; default: cwd) |
| `-r` / `--restart` | Kill and restart the command if still running |
| `-c` / `--clear` | Clear screen before each run (`-c reset` for full reset) |
| `-i <glob>` / `--ignore` | Ignore glob (repeatable) |
| `-f <glob>` / `--filter` | Only trigger on matching glob |
| `--no-vcs-ignore` | Don't honor .gitignore |
| `-d <ms>` / `--debounce` | Debounce window (default 50ms) |
| `-p` / `--postpone` | Wait for first change before first run |
| `--stop-signal <sig>` | Signal used with `-r` (e.g. `SIGKILL`) |
| `-v` | Show what triggered |

## Notes

- Respects `.gitignore`/`.ignore` by default (like ripgrep/fd).
- Changed paths are exported to the command as `$WATCHEXEC_*` env vars (e.g. `$WATCHEXEC_WRITTEN_PATH`).
- For cargo projects, `-e rs` + `-r` on `cargo run` gives a poor-man's hot reload.
