# Zathura

Vim-keybound PDF/DjVu/PS viewer. Heavily themed in `nixos/modules/home/zathura.nix`: dark recolor on by default, chrome hidden, fit-to-width on open, SyncTeX wired for vimtex.

---

## Navigation

| Key | Action |
|-----|--------|
| `h/j/k/l` | Scroll left / down / up / right |
| `J` / `K` | Next / previous page |
| `gg` / `G` | First / last page |
| `{n}G` | Go to page n |
| `Ctrl+D` / `Ctrl+U` | Half-page down / up |
| `Ctrl+F` / `Ctrl+B` | Page down / up |
| `H` / `L` | Top / bottom of current page |
| `Ctrl+O` / `Ctrl+I` | Jumplist back / forward |
| `m{a-z}` / `'{a-z}` | Set / jump to mark |
| `Tab` | Show index (TOC) — navigate with j/k, expand with l, open with Enter |
| `F` | Show link labels; type number to follow link |

## View

| Key | Action |
|-----|--------|
| `+` / `-` / `=` | Zoom in / out / reset |
| `a` | Fit page to window |
| `s` | Fit width |
| `d` | Toggle dual-page mode |
| `r` | Rotate 90° |
| `Ctrl+R` | **Toggle recolor (dark mode)** — on by default here |
| `i` | Invert colors (alternative binding for recolor) |
| `F5` | Presentation mode |
| `F11` | Fullscreen |
| `q` | Quit |

Menubar/statusbar are hidden (`guioptions = ""`); toggle statusbar back with `:set guioptions s`.

## Search & Selection

| Key | Action |
|-----|--------|
| `/{pat}` / `?{pat}` | Search forward / backward (incremental) |
| `n` / `N` | Next / previous match |
| Mouse drag | Select text — **copies to system clipboard** (`selection-clipboard = clipboard`) |

Search highlight persists after `Esc` (`abort-clear-search = false`).

## Commands

| Command | Action |
|---------|--------|
| `:open <file>` / `o` | Open file |
| `:print` | Print |
| `:export <n> <file>` | Export attachment/image |
| `:exec <cmd>` | Run shell command |
| `:set <opt> <val>` | Change option at runtime |
| `:info` | Document info |
| `R` | Reload document (auto-reloads on change anyway) |

## SyncTeX (with vimtex)

- `synctex = true` is set; `\lv` in neovim forward-searches to the PDF position.
- `Ctrl+Click` in zathura jumps back to the source line in neovim (vimtex passes `--synctex-editor-command` when launching the viewer).
