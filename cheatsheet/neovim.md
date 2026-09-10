# Neovim

Hyperextensible terminal editor. Config in `~/.dotfiles/nvim/`, plugins via lazy.nvim.

- **Leader**: `Space` &nbsp;·&nbsp; **Localleader**: `\`
- Treesitter parsers come from Nix/brew (no nvim-treesitter plugin); LSP binaries from Nix (plus `:Mason` on macOS)
- Colorscheme: petrolnoir, transparent background; inactive windows dimmed (tint.nvim)
- Statusline (lualine) shows live CPU + memory usage; startup dashboard (mini.starter) has a "Open Zettelkasten Index" shortcut

---

## Custom Leader Keymaps

### Telescope / navigation

| Key | Action |
|-----|--------|
| `<leader>f` | Find files |
| `<leader>s` | Live grep |
| `<leader>b` | Buffers |
| `<leader>C` | Command picker |
| `<leader>l` | LSP pickers (leaves `:Telescope builtin.lsp_` open to complete) |
| `Ctrl+N` | File browser (telescope-file-browser, replaces netrw) |
| `<leader>?` | Searchable keymap list (keymaps.nvim, `:Keymaps`) |
| `,b` | Opens `:buffer *` prompt for wildmenu buffer switch |

### Utilities

| Key | Action |
|-----|--------|
| `<leader>j` | Format buffer as JSON (`%!jq .`) |
| `<leader>-` | Opens `:resize` prompt |
| `<leader>=` | Opens `:vertical resize` prompt |

## Custom Commands (split-terminal runners)

All open a split terminal; `{args}` appended unless noted.

| Command | Runs |
|---------|------|
| `:Run {cmd}` | Any shell command (file completion) |
| `:Node {args}` | `node` |
| `:CargoBuild` / `:CargoRun` | `cargo build` / `cargo run` |
| `:CargoTestAll` | `cargo make test-all` |
| `:CargoTestUnit` | `cargo make test-unit` |
| `:CargoTestUnitExact {ENV=v}` | `{args} cargo make --no-workspace test-unit-exact` (args prefix, e.g. env vars) |
| `:CargoTestIntegrationExact {ENV=v}` | `{args} cargo make --no-workspace test-integration-exact` (args prefix) |
| `:CargoTestCrate {ENV=v}` | `{args} cargo make --no-workspace test-crate` (args prefix) |
| `:CargoTestCrateUnit {ENV=v}` | `{args} cargo make --no-workspace test-crate-unit` (args prefix) |
| `:CppFastBuild` | `cd build && make -j10` |
| `:CppTest {target}` | `cd build && make -j12` |
| `:CppTestAll` | `cd build && make -j12 md_test` |
| `:CppCleanBuild` | full rm/cmake preset/make rebuild |

### Function keys

| Key | Action |
|-----|--------|
| `F5` | SuperCollider hard stop (sclang) |
| `F7` / `F8` | `:CargoTestCrate` / `:CargoTestCrateUnit` (prompt open for args) |
| `F9` / `F10` | `:CargoTestIntegrationExact` / `:CargoTestUnitExact` (prompt open for args) |
| `F11` / `F12` | `:CargoTestUnit --workspace` / `:CargoTestAll --workspace` |
| `Cmd+U` / `Cmd+Y` / `Cmd+O` | `:CppFastBuild` / `:CppCleanBuild` / `:CppTest` (GUI only) |

## Just (just.nvim)

Runs justfile tasks async with fidget progress; quickfix opens on failure (and on `run`), autoscrolls.

| Command | Action |
|---------|--------|
| `:Just {task}` | Run task (no arg = default) |
| `:JustSelect` | Task picker |
| `:JustStop` | Stop current task |
| `:JustCreateTemplate` | Create justfile template |

## AI — CodeCompanion + MCPHub

Default chat adapter is **claude_code** (ACP via the `claude` CLI, model from `~/.claude/settings.json`); also configured: **codex** (ACP, ChatGPT auth) and **copilot** (HTTP, gpt-5.4). System prompt is read from `~/Code/personal/GLOBAL_AGENTS.md`.

| Key / Command | Action |
|---------------|--------|
| `<leader>c` | Open CodeCompanion chat |
| `:CodeCompanionChat [adapter]` | Open chat (optionally with adapter) |
| `:CodeCompanion {prompt}` | Inline assistant |
| `:CodeCompanionActions` | Action palette |
| `:CodeCompanionHistory` | Saved chats (telescope picker) |
| `Ctrl+F` (chat, insert) | `/file` slash command |
| `Ctrl+B` (chat, insert) | `/buffer` slash command |
| `:MCPHub` | MCP server hub UI (tools + slash commands are exposed in chat) |

Note: `Ctrl+C` close is **disabled** in the chat buffer — use `:q`.

## Zettelkasten (telekasten.nvim)

Notes live in `~/Code/personal/zettelkasten` (templates for new/daily/weekly notes).

| Key | Action |
|-----|--------|
| `<leader>z` | Telekasten command panel |
| `<leader>zf` | Find notes |
| `<leader>zg` | Search (grep) notes |
| `<leader>zd` | Go to today's daily note |
| `<leader>zz` | Follow link under cursor |
| `<leader>zn` | New note |
| `<leader>zc` | Show calendar (calendar-vim) |
| `<leader>zb` | Show backlinks |
| `<leader>zI` | Insert image link |
| `[[` (insert) | Insert link via picker |

## LSP & Diagnostics

Servers enabled: clangd, ts_ls, html, cssls, bashls, yamlls, taplo, pyright (+ rust-analyzer via rustaceanvim). Diagnostics float auto-opens on cursor hold; fidget shows LSP progress.

| Key | Action |
|-----|--------|
| `gd` / `Ctrl+]` | Go to definition |
| `gD` | Go to implementation |
| `1gD` | Go to type definition |
| `gr` | References |
| `g0` | Document symbols |
| `gW` | Workspace symbols |
| `K` | Hover |
| `Ctrl+K` | Signature help |
| `ga` | Code action |
| `<leader>r` | Rename |
| `g[` / `g]` | Previous / next diagnostic |

## Completion (nvim-cmp)

Sources: LSP, vsnip, path, buffer.

| Key | Action |
|-----|--------|
| `Tab` / `S-Tab` | Next / previous item |
| `Ctrl+N` / `Ctrl+P` | Next / previous item |
| `Ctrl+Space` | Trigger completion |
| `Enter` | Confirm |
| `Ctrl+E` | Close menu |
| `Ctrl+D` / `Ctrl+F` | Scroll docs up / down |

## Rust (rustaceanvim)

rustfmt runs on save (`BufWritePre` LSP format for `*.rs`).

| Key / Command | Action |
|---------------|--------|
| `<leader>a` (rust buffers) | Code action with rust-analyzer grouping |
| `K` (rust buffers) | Hover actions |
| `:RustLsp {cmd}` | runnables, debuggables, expandMacro, openCargo, … |

## SuperCollider (scnvim)

`SCNvimStart` runs automatically for supercollider files; postwin is floating; docs render via pandoc. 2-space indent ftplugin override.

| Key | Action |
|-----|--------|
| `Alt+E` | Send current line (insert/normal) |
| `Ctrl+E` | Send block (insert/normal) / send selection (visual) |
| `Enter` | Toggle post window |
| `Alt+Enter` | Toggle post window (insert) |
| `Alt+L` | Clear post window |
| `Ctrl+K` | Show signature |
| `F5` | Hard stop |
| `<leader>1` / `<leader>2` | Start / recompile sclang |
| `<leader>9` / `<leader>0` | `s.boot` / `s.meter` |
| `<leader>5` | Search SC docs (`:Telescope scdoc`) |
| `K` (sc buffers) | `:SCNvimHelp` for word under cursor |

## Multiple Cursors (multiple-cursors.nvim)

| Key | Action |
|-----|--------|
| `Ctrl+J` / `Ctrl+K` | Add cursor and move down / up |
| `Ctrl+Down` / `Ctrl+Up` | Add cursor and move down / up (also insert mode) |
| `Ctrl+LeftMouse` | Add / remove cursor at click |
| `<leader>m` (visual) | Add cursors to each line of selection |
| `<leader>a` | Add cursors to all matches of word under cursor |
| `<leader>A` | Same, within previous visual area |
| `<leader>d` | Add cursor and jump to next match |
| `<leader>D` | Jump to next match (no new cursor) |
| `<leader>l` | Lock virtual cursors |

Note: in rust buffers `<leader>a` is overridden by the buffer-local code-action map.

## Markdown

render-markdown.nvim renders markdown + telekasten buffers in place; spell check on; text width 80.

| Key / Command | Action |
|---------------|--------|
| `<leader>x` | Toggle checkbox (markdown-toggle) |
| `Shift+Space` | Cycle checkbox states (normal) / toggle (visual) |
| `:RenderMarkdown toggle` | Toggle in-buffer rendering |

## Editing Plugins

| Key | Action |
|-----|--------|
| `gcc` / `gc{motion}` / `gc` (visual) | Toggle line comment (Comment.nvim) |
| `gbc` / `gb{motion}` | Toggle block comment |
| `gco` / `gcO` / `gcA` | Comment below / above / end of line |
| `ys{motion}{char}` / `yss{char}` | Add surround (nvim-surround) |
| `cs{old}{new}` / `ds{char}` | Change / delete surround |
| `S{char}` (visual) | Surround selection |
| `gS` | Toggle split/join args & lists (mini.splitjoin) |
| `:Git {args}` | Git via mini.git |
| `:TodoTelescope` / `:TodoQuickFix` | Browse TODO/FIXME/HACK comments |
| `:FzfLua` | fzf-lua pickers (alternative to telescope) |

## Folding (nvim-origami)

LSP folds with treesitter fallback; comments & imports auto-fold on open; folds pause while searching; fold text shows line count + diagnostics.

| Key | Action |
|-----|--------|
| `h` (at fold) | Close fold |
| `l` (at fold) | Open fold |
| `za` / `zR` / `zM` | Toggle / open all / close all |

## LaTeX (vimtex)

Compiler latexmk, viewer Zathura (SyncTeX both ways). Mappings under `\l` (localleader prefix):

| Key | Action |
|-----|--------|
| `\ll` | Compile (toggle continuous) |
| `\lv` | Forward search / view PDF |
| `\le` | Show errors |
| `\lc` | Clean aux files |
| `\lt` | Table of contents |
| `\lk` | Stop compiler |

## Practice Cycles (daily-cycle, local plugin)

Each command inserts today's rotating practice item at the cursor:

`:PracticeKey` · `:PracticeScale` · `:PianoTwoHandTechEx` · `:PianoLHHandTechEx` · `:PianoRHHandTechEx` · `:BassTechEx`

## Terminal

Terminal buffers auto-enter insert mode.

| Key | Action |
|-----|--------|
| `Ctrl+W h/j/k/l` | Navigate out of terminal split |
| `:Run {cmd}` | Run command in split terminal |

## Stale Mappings (plugins removed, bindings remain)

| Key | Intended action | Status |
|-----|-----------------|--------|
| `F2` / `F3` | `:ZettelNew` / `:ZettelOpen` (vim-zettel) | Plugin not installed — use telekasten (`<leader>zn` / `<leader>zf`) |
| `<leader>L/R/A/E/B/N/U/O` | vimspector debugger (launch/reset/watch/eval/breakpoint/step) | Plugin not installed (nvim-dap present but unconfigured) |

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
| `"+y` / `"+p` | System clipboard yank / paste (default register is system clipboard here) |
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
| `:Mason` | LSP server installer (macOS) |
| `:checkhealth` | Health check |
