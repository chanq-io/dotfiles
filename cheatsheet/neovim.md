# Neovim

Hyperextensible terminal editor. Config in `~/.dotfiles/nvim/`, plugins via lazy.nvim.

---

## Modes

| Key | Mode |
|-----|------|
| `i` / `a` | Insert before / after cursor |
| `I` / `A` | Insert at line start / end |
| `o` / `O` | New line below / above |
| `v` / `V` / `Ctrl+V` | Visual / visual line / visual block |
| `R` | Replace mode |
| `:` | Command-line |
| `Esc` | Normal |

## Motions

| Key | Movement |
|-----|----------|
| `h/j/k/l` | Left / down / up / right |
| `w` / `b` / `e` | Next word / previous word / end of word |
| `W` / `B` / `E` | Same for WORD |
| `0` / `^` / `$` | Line start / first char / end |
| `gg` / `G` | File start / end |
| `{` / `}` | Paragraph up / down |
| `%` | Matching bracket |
| `f{c}` / `F{c}` | Find char forward / backward |
| `t{c}` / `T{c}` | Until char forward / backward |
| `;` / `,` | Repeat / reverse f/t |
| `Ctrl+D` / `Ctrl+U` | Half-page down / up |
| `Ctrl+F` / `Ctrl+B` | Full page down / up |
| `H` / `M` / `L` | Screen top / middle / bottom |
| `zz` / `zt` / `zb` | Cursor to center / top / bottom |
| `/{pat}` / `?{pat}` | Search forward / backward |
| `n` / `N` | Next / previous match |
| `*` / `#` | Search word under cursor fwd / bwd |

## Text Objects (use with d, c, y, v)

| Object | Meaning |
|--------|---------|
| `iw` / `aw` | Inner / a word |
| `is` / `as` | Inner / a sentence |
| `ip` / `ap` | Inner / a paragraph |
| `i"` / `a"` | Inside / around double quotes |
| `i'` / `a'` | Inside / around single quotes |
| `i)` / `a)` | Inside / around parentheses |
| `i]` / `a]` | Inside / around brackets |
| `i}` / `a}` | Inside / around braces |
| `it` / `at` | Inside / around HTML tag |

## Operators

| Key | Action |
|-----|--------|
| `d` | Delete |
| `c` | Change (delete + insert) |
| `y` | Yank (copy) |
| `>` / `<` | Indent / dedent |
| `=` | Auto-indent |
| `gU` / `gu` | Uppercase / lowercase |

Double for line: `dd`, `cc`, `yy`, `>>`, `<<`

## Editing

| Key | Action |
|-----|--------|
| `x` | Delete char |
| `s` | Substitute char |
| `C` / `D` | Change / delete to end of line |
| `J` | Join lines |
| `u` / `Ctrl+R` | Undo / redo |
| `.` | Repeat last change |
| `~` | Toggle case |
| `p` / `P` | Paste after / before |
| `"+y` / `"+p` | System clipboard yank / paste |
| `Ctrl+A` / `Ctrl+X` | Increment / decrement number |

## Registers

| Register | Content |
|----------|---------|
| `""` | Default (last d/c/y) |
| `"0` | Last yank |
| `"1`–`"9` | Delete history |
| `"a`–`"z` | Named |
| `"+` | System clipboard |
| `"_` | Black hole |

## Macros

| Key | Action |
|-----|--------|
| `q{a-z}` | Record macro |
| `q` | Stop recording |
| `@{a-z}` | Play macro |
| `@@` | Replay last |
| `5@a` | Play 5 times |

## Marks

| Key | Action |
|-----|--------|
| `m{a-z}` | Set local mark |
| `m{A-Z}` | Set global mark |
| `` `{mark} `` | Jump to mark |
| `` `. `` | Last change position |

## Splits & Windows

| Key | Action |
|-----|--------|
| `Ctrl+W s` / `v` | Horizontal / vertical split |
| `Ctrl+W h/j/k/l` | Navigate splits |
| `Ctrl+W =` | Equal size |
| `Ctrl+W q` | Close window |
| `Ctrl+W o` | Close all others |

## Tabs & Buffers

| Command | Action |
|---------|--------|
| `:tabnew` / `:tabc` | New / close tab |
| `gt` / `gT` | Next / previous tab |
| `:bn` / `:bp` | Next / previous buffer |
| `:bd` | Close buffer |
| `:ls` | List buffers |

## Search & Replace

```vim
:%s/old/new/g                  " replace all in file
:%s/old/new/gc                 " replace all, confirm each
:5,10s/old/new/g               " replace in lines 5-10
:'<,'>s/old/new/g              " replace in visual selection
```

## Folding

| Key | Action |
|-----|--------|
| `za` | Toggle fold |
| `zo` / `zc` | Open / close fold |
| `zR` / `zM` | Open all / close all |

## LSP (Built-in)

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | Go to references |
| `gi` | Go to implementation |
| `K` | Hover documentation |
| `[d` / `]d` | Previous / next diagnostic |

## Useful Ex Commands

| Command | Action |
|---------|--------|
| `:w` / `:q` / `:wq` | Write / quit / both |
| `:q!` | Quit without saving |
| `:e!` | Revert file |
| `:noh` | Clear search highlight |
| `:sort` / `:sort u` | Sort lines / unique |
| `:g/pat/d` | Delete matching lines |
| `:%!cmd` | Filter buffer through command |
| `:Lazy` | Plugin manager |
| `:checkhealth` | Health check |
