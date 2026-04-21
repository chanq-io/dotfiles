# Lazygit Cheatsheet

A terminal UI for git that makes staging, committing, branching, rebasing, and more fast and visual.

---

## Panels & Navigation

Lazygit has 5 main panels. Press the number key or Tab to switch between them.

| Key | Panel |
|-----|-------|
| `1` | Status |
| `2` | Files (working tree) |
| `3` | Branches / Remotes / Tags |
| `4` | Commits (log) |
| `5` | Stash |
| `Tab` | Cycle to next panel |
| `Shift+Tab` | Cycle to previous panel |
| `]` / `[` | Cycle through tabs within a panel |
| `j` / `k` | Move down / up in any list |
| `h` / `l` | Collapse / expand in tree views |
| `PgUp` / `PgDn` | Scroll main view (diff) |
| `Enter` | Focus item / expand |
| `Esc` | Go back / close popup |
| `q` | Quit lazygit |
| `Q` | Quit without confirmation |
| `?` | Show keybindings for current panel |
| `x` | Open global keybindings menu |

---

## Status Panel (1)

| Key | Action |
|-----|--------|
| `e` | Edit config file |
| `o` | Open repo in browser |
| `u` | Check for updates |

---

## Files Panel (2) -- Staging & Unstaging

| Key | Action |
|-----|--------|
| `Space` | Toggle stage / unstage file |
| `a` | Stage / unstage all files |
| `Enter` | Open file to stage individual hunks/lines |
| `d` | Discard changes (checkout file) |
| `D` | Discard options menu (all, unstaged only) |
| `e` | Edit file in editor |
| `o` | Open file in default program |
| `i` | Add to .gitignore |
| `r` | Refresh files |
| `s` | Stash changes (opens menu) |
| `S` | Stash options (all, staged only, keep index, etc.) |
| `c` | Commit staged changes |
| `w` | Commit options (amend, allow empty, etc.) |
| `A` | Amend last commit |
| `C` | Commit using git editor (for longer messages) |
| `f` | Find base commit for fixup |
| `/` | Filter files by path |
| `M` | Open merge/diff tool |

### In Staging View (after pressing Enter on a file)

| Key | Action |
|-----|--------|
| `Space` | Toggle stage/unstage hunk |
| `v` | Toggle select range (line-by-line staging) |
| `a` | Stage/unstage all hunks in file |
| `j` / `k` | Move between lines |
| `Shift+j/k` | Move between hunks |
| `e` | Edit hunk in editor |
| `Esc` | Return to files panel |

---

## Branches Panel (3)

| Key | Action |
|-----|--------|
| `Space` | Checkout branch |
| `n` | New branch from current HEAD |
| `d` | Delete branch |
| `r` | Rebase current branch onto selected |
| `R` | Rename branch |
| `M` | Merge selected into current branch |
| `f` | Fast-forward branch to upstream |
| `u` | Set/unset upstream |
| `c` | Checkout by name (type branch name) |
| `F` | Force checkout |
| `w` | View worktree options |
| `Enter` | View branch commits |

### Remotes Tab (press `]` to switch)

| Key | Action |
|-----|--------|
| `f` | Fetch remote |
| `n` | Add new remote |
| `d` | Remove remote |
| `e` | Edit remote |

### Tags Tab

| Key | Action |
|-----|--------|
| `Space` | Checkout tag |
| `n` | Create new tag |
| `d` | Delete tag |
| `P` | Push tag to remote |

---

## Commits Panel (4)

| Key | Action |
|-----|--------|
| `Enter` | View commit files |
| `Space` | Checkout commit (detached HEAD) |
| `r` | Reword commit message |
| `R` | Reword in editor |
| `d` | Drop commit (in rebase) |
| `e` | Edit commit (pause rebase at this commit) |
| `s` | Squash commit into parent |
| `f` | Fixup commit into parent (discard message) |
| `p` | Pick commit (mark for cherry-pick) |
| `S` | Squash all "fixup!" commits (autosquash) |
| `c` | Copy commit (for cherry-pick) |
| `C` | Copy commit range |
| `v` | Paste (cherry-pick) copied commits |
| `g` | Reset to this commit (opens soft/mixed/hard menu) |
| `t` | Tag commit |
| `T` | Create annotated tag |
| `o` | Open commit in browser |
| `y` | Copy commit SHA to clipboard |
| `A` | Amend commit with staged changes |
| `a` | Set/reset commit author |
| `Ctrl+j` | Move commit down |
| `Ctrl+k` | Move commit up |

### Navigating Commit History

| Key | Action |
|-----|--------|
| `/` | Search commits |
| `<` / `>` | Scroll diff left/right |
| `{` / `}` | Navigate diff hunks |

---

## Stash Panel (5)

| Key | Action |
|-----|--------|
| `Space` | Apply stash |
| `g` | Pop stash (apply + drop) |
| `d` | Drop stash |
| `n` | Create new stash |
| `r` | Rename stash |
| `Enter` | View stash contents |
| `w` | View stash diff |

---

## Rebasing

When a rebase is in progress, the commits panel shows the rebase state:

| Key | Action |
|-----|--------|
| `e` | Edit current commit |
| `s` | Squash commit |
| `f` | Fixup commit |
| `d` | Drop commit |
| `Space` | Mark as pick |
| `Ctrl+c` | Abort rebase |

**Workflow:**
1. In Branches panel, press `r` on the target branch to start rebase
2. In Commits panel, reorder/squash/edit as needed
3. If conflicts arise, resolve in Files panel, stage, then continue

---

## Merge Conflicts

When merge conflicts exist:

| Key | Action |
|-----|--------|
| `Enter` | Open conflicted file |
| `Space` | Pick hunk (ours/theirs) |
| `b` | Pick both hunks |
| `z` | Undo last conflict resolution pick |
| Arrow keys | Navigate between conflict markers |

---

## Cherry-Picking

```
1. Navigate to Commits panel
2. Press 'c' on commits you want to copy
3. Switch to target branch (Branches panel, Space)
4. Press 'v' to paste (cherry-pick) copied commits
```

---

## Filtering

| Key | Location | Action |
|-----|----------|--------|
| `/` | Files panel | Filter files by path |
| `/` | Commits panel | Search commit messages |
| `Ctrl+s` | Any panel | Open filter mode (by path) |

---

## Custom Commands

Custom commands can be defined in `~/.config/lazygit/config.yml`:

```yaml
customCommands:
  - key: "C"
    command: "git cz"
    context: "files"
    loadingText: "Commitizen..."
    subprocess: true
  - key: "P"
    command: "git push --force-with-lease"
    context: "localBranches"
    loadingText: "Force pushing..."
  - key: "<c-p>"
    command: "gh pr create --web"
    context: "global"
    loadingText: "Opening PR..."
```

### Config Options

```yaml
# ~/.config/lazygit/config.yml
gui:
  showIcons: true
  theme:
    selectedLineBgColor:
      - underline
  mouseEvents: true
  sidePanelWidth: 0.3333
git:
  paging:
    colorArg: always
    pager: delta --dark --paging=never
  autoFetch: true
  autoRefresh: true
  branchLogCmd: "git log --graph --oneline --decorate {{branchName}}"
os:
  editCommand: "nvim"
  editCommandTemplate: "{{editor}} {{filename}}"
keybinding:
  universal:
    quit: "q"
```

---

## Useful Global Keys

| Key | Action |
|-----|--------|
| `@` | Open command log panel |
| `+` | Increase diff context size |
| `-` | Decrease diff context size |
| `:` | Execute custom shell command |
| `z` | Undo (via reflog) |
| `Ctrl+z` | Redo (via reflog) |
| `p` | Push |
| `P` | Pull |
| `Ctrl+r` | Switch repos (recent repos) |
| `W` | Open diff menu (compare branches) |
