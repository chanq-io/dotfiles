# sd

Intuitive find-and-replace (a friendlier `sed s///`). Regex by default, sane escaping, in-place edits when given files.

---

## Usage

```bash
sd 'before' 'after' file.txt            # replace in file (in place)
sd 'before' 'after' file1 file2         # multiple files
cat file | sd 'before' 'after'          # stdin → stdout
fd -e rs | xargs sd 'old_fn' 'new_fn'   # combine with fd for project-wide rename
```

## Flags

| Flag | Effect |
|------|--------|
| `-p` / `--preview` | Show what would change, don't write |
| `-s` / `--string-mode` | Treat pattern as literal string (no regex) |
| `-f i` | Case-insensitive matching |
| `-f m` | Multi-line: `^`/`$` match line boundaries |
| `-f s` | `.` also matches newline |
| `-n <count>` | Replace at most `<count>` matches per line |

## Regex & Capture Groups

Rust regex syntax; capture groups referenced as `$1` or `${name}`:

```bash
sd '(\w+)@(\w+)' '$2 at $1' file          # numbered groups
sd '(?P<key>\w+)=(?P<val>\w+)' '${val}:${key}' file   # named groups
sd '\s+$' '' file                          # strip trailing whitespace
sd '^' '> ' file                           # prefix every line
```

Braces disambiguate: `${1}0` means group 1 followed by literal `0` (plain `$10` would mean group 10).

## vs sed

| Task | sed | sd |
|------|-----|-----|
| Basic replace | `sed 's/old/new/g' f` | `sd old new f` |
| In place | `sed -i '' 's/a/b/g' f` (BSD) / `sed -i 's/a/b/g' f` (GNU) | `sd a b f` (portable) |
| Literal `/` in pattern | escape or change delimiter | just type it |
| Literal string mode | none | `-s` |

sd replaces globally by default (no `g` flag needed) and behaves identically on macOS and Linux.
