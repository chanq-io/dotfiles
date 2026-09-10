# Difftastic

Structural diff tool (`difft`) that compares files by syntax tree, not lines — renames, reflows, and moved arguments show up as what they are. Installed on both NixOS (home-manager) and macOS (brew).

---

## Git Integration (this setup)

Wired as a git *difftool* (not the default pager — plain `git diff` stays on delta):

| Alias | Action |
|-------|--------|
| `git dft` | Structural diff of working tree (`git difftool` → difftastic) |
| `git dft <commit>` | Structural diff against a commit |
| `git dft <a>..<b>` | Structural diff between commits |
| `git dlog` | `git log -p` with difftastic diffs (`GIT_EXTERNAL_DIFF=difft`) |

Config lives in `nixos/modules/home/git.nix` and `macos/git/gitconfig` (kept in sync).

## Direct Usage

```bash
difft file1.rs file2.rs         # diff two files
difft dir1/ dir2/               # diff two directories
difft --list-languages          # supported languages (~50)

# one-off structural diff for any git command
GIT_EXTERNAL_DIFF=difft git diff
GIT_EXTERNAL_DIFF=difft git show <commit> --ext-diff
```

## Useful Flags

| Flag | Effect |
|------|--------|
| `--display side-by-side` | Two-column view (default when wide enough) |
| `--display inline` | Unified single-column view |
| `--context <n>` | Lines of context around changes |
| `--ignore-comments` | Skip comment-only changes |
| `--tab-width <n>` | Tab render width |
| `--override '*.foo:json'` | Force a parser for a glob |
| `--skip-unchanged` | Don't print unchanged files (directory mode) |
| `--check-only` | Exit status only — 1 if changes found |

Flags can also be set via env vars: `DFT_DISPLAY`, `DFT_CONTEXT`, `DFT_TAB_WIDTH`, etc.

## When It Falls Back

Unsupported languages and very large files fall back to a conventional line-based diff (noted in the output header). Difftastic shows *what* changed, not byte-exact whitespace — use `git diff` (delta) when whitespace matters or when generating patches; difftastic output is not applyable.
