# wl-clipboard

Wayland clipboard utilities: `wl-copy` and `wl-paste`.

## wl-copy

Copy data to the Wayland clipboard.

```bash
echo "text" | wl-copy           # Copy text from stdin
wl-copy "hello world"           # Copy string argument
wl-copy < file.txt              # Copy file contents
cat image.png | wl-copy -t image/png  # Copy image
wl-copy --clear                 # Clear the clipboard
```

### Flags

| Flag | Description |
|---|---|
| `-t <type>` / `--type <type>` | Set MIME type (e.g., `text/plain`, `image/png`) |
| `-o` / `--paste-once` | Serve content once then clear |
| `-n` / `--trim-newline` | Trim trailing newline |
| `--clear` | Clear clipboard contents |
| `-p` / `--primary` | Use primary selection (middle-click) |
| `-s <seat>` | Use specific Wayland seat |
| `-f` / `--foreground` | Stay in foreground (don't fork) |

## wl-paste

Paste data from the Wayland clipboard.

```bash
wl-paste                        # Print clipboard contents
wl-paste > output.txt           # Save clipboard to file
wl-paste -t image/png > img.png # Save clipboard image
wl-paste --list-types           # List available MIME types
```

### Flags

| Flag | Description |
|---|---|
| `-t <type>` / `--type <type>` | Request specific MIME type |
| `-n` / `--no-newline` | Do not append trailing newline |
| `--list-types` | List available content types |
| `-p` / `--primary` | Paste from primary selection |
| `-s <seat>` | Use specific Wayland seat |
| `-w <cmd>` / `--watch <cmd>` | Run command on each clipboard change |

## Piping Recipes

```bash
# Copy command output
ls -la | wl-copy

# Copy file path
wl-copy "$(realpath file.txt)"

# Copy without trailing newline
printf "no newline" | wl-copy
echo "has newline" | wl-copy -n

# Copy image from screenshot
grim -g "$(slurp)" - | wl-copy -t image/png

# Copy from primary selection to clipboard
wl-paste -p | wl-copy

# Copy clipboard as specific type
wl-paste -t text/html | wl-copy -t text/html

# Watch clipboard and log changes
wl-paste --watch echo "clipboard changed"

# Store clipboard history (with cliphist)
wl-paste --type text --watch cliphist store
wl-paste --type image --watch cliphist store

# Pipe clipboard to a command
wl-paste | grep "pattern"
wl-paste | wc -l

# Copy SSH public key
wl-copy < ~/.ssh/id_ed25519.pub

# Copy password from pass
pass show email | head -1 | wl-copy -o   # Clear after single paste

# Swap clipboard and primary selection
tmp=$(wl-paste); wl-paste -p | wl-copy; echo "$tmp" | wl-copy -p
```

## Tips

- `wl-copy -o` (paste-once) is useful for sensitive data like passwords.
- `--watch` keeps the process running and re-executes on every clipboard change.
- Primary selection (`-p`) is the middle-click paste buffer, separate from the main clipboard.
- MIME types can be checked with `wl-paste --list-types` to see what the current clipboard offers.
