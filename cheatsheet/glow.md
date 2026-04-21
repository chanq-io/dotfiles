# glow

TUI markdown renderer. Renders markdown beautifully in the terminal.

---

## Usage

```bash
glow file.md                   # render file
glow                           # browse current directory
glow -p file.md                # render with pager
glow -                         # read from stdin
cat file.md | glow             # pipe mode
```

## Key Flags

| Flag | Action |
|------|--------|
| `-p` / `--pager` | Use pager |
| `-s STYLE` / `--style=STYLE` | Style (`dark`, `light`, `notty`, `auto`) |
| `-w N` / `--width=N` | Word wrap at width |
| `-a` | Open stash (saved markdowns) |

## TUI Key Bindings (Browse Mode)

| Key | Action |
|-----|--------|
| `Enter` | Open file |
| `/` | Filter |
| `q` / `Esc` | Quit |
| `j` / `k` | Navigate |
| `?` | Help |
