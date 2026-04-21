# Zsh

Fast, POSIX-compatible shell with powerful globbing, completion, and scripting.

---

## Line Editing (Emacs Mode)

| Key | Action |
|-----|--------|
| `Ctrl+A` | Beginning of line |
| `Ctrl+E` | End of line |
| `Ctrl+B` / `Ctrl+F` | Back / forward one char |
| `Alt+B` / `Alt+F` | Back / forward one word |
| `Ctrl+U` | Kill line before cursor |
| `Ctrl+K` | Kill line after cursor |
| `Ctrl+W` | Kill word before cursor |
| `Alt+D` | Kill word after cursor |
| `Ctrl+Y` | Yank (paste) killed text |
| `Ctrl+T` | Transpose chars |
| `Alt+T` | Transpose words |
| `Ctrl+L` | Clear screen |
| `Ctrl+D` | Delete char / EOF if empty |
| `Ctrl+_` | Undo |
| `Tab` | Complete |
| `Ctrl+X Ctrl+E` | Edit command in `$EDITOR` |

## History

| Key / Command | Action |
|---------------|--------|
| `Ctrl+R` | Reverse incremental search |
| `Ctrl+S` | Forward incremental search |
| `Ctrl+P` / `Up` | Previous command |
| `Ctrl+N` / `Down` | Next command |
| `!!` | Last command |
| `!$` | Last argument of last command |
| `!^` | First argument of last command |
| `!*` | All arguments of last command |
| `!n` | Command number `n` |
| `!str` | Last command starting with `str` |
| `!?str` | Last command containing `str` |
| `^old^new` | Replace `old` with `new` in last command |
| `history` | Show history |
| `fc -l` | List recent history |
| `fc -e vim` | Edit last command in vim |

## Job Control

| Command | Action |
|---------|--------|
| `Ctrl+Z` | Suspend foreground job |
| `bg` / `bg %n` | Resume job in background |
| `fg` / `fg %n` | Resume job in foreground |
| `jobs` | List jobs |
| `kill %n` | Kill job `n` |
| `disown %n` | Detach job from shell |
| `cmd &` | Run in background |
| `cmd &!` | Run in background + disown |

## Globbing

| Pattern | Matches |
|---------|---------|
| `*` | Any string (not `/`) |
| `**` | Recursive directories |
| `?` | Single character |
| `[abc]` | Any of `a`, `b`, `c` |
| `[a-z]` | Range |
| `[^a]` | Not `a` |
| `(foo\|bar)` | Alternation |
| `*.{js,ts}` | Brace expansion |

### Glob Qualifiers (append inside `(...)`)

| Qualifier | Meaning |
|-----------|---------|
| `.` | Regular files only |
| `/` | Directories only |
| `@` | Symlinks only |
| `*` | Executable files |
| `om` | Order by modification time |
| `on` | Order by name |
| `oL` | Order by size |
| `Om` | Reverse order by mod time |
| `[1,5]` | First 5 matches |
| `L+100k` | Files > 100KB |
| `mh-1` | Modified in last hour |
| `mw-1` | Modified in last week |
| `u:user:` | Owned by user |

```zsh
# Examples
ls **/*.rs          # all .rs files recursively
ls *(.)             # regular files only
ls *(om[1,5])       # 5 most recently modified
rm **/*.log(mw+4)   # logs older than 4 weeks
```

## Parameter Expansion

| Syntax | Result |
|--------|--------|
| `${var:-default}` | Use default if unset/empty |
| `${var:=default}` | Assign default if unset/empty |
| `${var:?error}` | Error if unset/empty |
| `${var:+alt}` | Use alt if set |
| `${#var}` | Length |
| `${var:offset:len}` | Substring |
| `${var#pat}` | Remove shortest prefix match |
| `${var##pat}` | Remove longest prefix match |
| `${var%pat}` | Remove shortest suffix match |
| `${var%%pat}` | Remove longest suffix match |
| `${var/pat/rep}` | Replace first match |
| `${var//pat/rep}` | Replace all matches |
| `${var:u}` | Uppercase |
| `${var:l}` | Lowercase |
| `${(s:,:)var}` | Split on `,` into array |
| `${(j:,:)arr}` | Join array with `,` |
| `${(U)var}` | Uppercase (flag form) |

## Useful Setopt Options

| Option | Effect |
|--------|--------|
| `AUTO_CD` | `dirname` alone does `cd dirname` |
| `EXTENDED_GLOB` | Enable `#`, `~`, `^` in globs |
| `NULL_GLOB` | Non-matching globs expand to nothing |
| `HIST_IGNORE_DUPS` | No consecutive duplicate history |
| `HIST_IGNORE_ALL_DUPS` | Remove older duplicates |
| `SHARE_HISTORY` | Share history between sessions |
| `INC_APPEND_HISTORY` | Append to history immediately |
| `CORRECT` | Offer spelling correction |
| `NO_BEEP` | Silence the bell |
| `INTERACTIVE_COMMENTS` | Allow `#` comments in interactive shell |

## Useful Builtins

| Command | Action |
|---------|--------|
| `source file` / `. file` | Execute file in current shell |
| `alias name=cmd` | Create alias |
| `which cmd` | Show where command resolves |
| `whence -v cmd` | Verbose which |
| `type cmd` | Command type |
| `autoload -Uz fn` | Autoload function |
| `zmodload module` | Load zsh module |
| `typeset -A hash` | Declare associative array |
| `print -P '%~'` | Print with prompt expansion |
| `vared var` | Interactively edit variable |
| `rehash` | Rebuild command hash table |
