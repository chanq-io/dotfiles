# Git & Git-Extras Cheatsheet

A comprehensive reference for core git commands, useful flags, git-extras utilities, interactive rebase workflows, and log formats.

---

## Core Commands

### Staging & Committing

| Command | Description |
|---------|-------------|
| `git add <file>` | Stage a specific file |
| `git add -p` | Interactively stage hunks |
| `git add -A` | Stage all changes (tracked + untracked) |
| `git add -u` | Stage modifications/deletions of tracked files only |
| `git commit -m "msg"` | Commit with inline message |
| `git commit -v` | Commit; show diff in editor |
| `git commit --amend` | Amend the last commit (message + contents) |
| `git commit --amend --no-edit` | Amend last commit, keep message |
| `git commit --fixup=<sha>` | Create fixup commit for later autosquash |
| `git commit --allow-empty -m "msg"` | Commit with no changes (CI triggers, etc.) |

### Diff

| Command | Description |
|---------|-------------|
| `git diff` | Unstaged changes vs index |
| `git diff --staged` | Staged changes vs HEAD |
| `git diff HEAD` | All changes (staged + unstaged) vs HEAD |
| `git diff <branch1>..<branch2>` | Diff between two branches |
| `git diff --stat` | Summary of changed files + line counts |
| `git diff --name-only` | List changed filenames only |
| `git diff --word-diff` | Inline word-level diff |
| `git diff --diff-filter=M` | Only show modified files (A=added, D=deleted, R=renamed) |
| `git diff --check` | Warn about whitespace errors |

### Log

| Command | Description |
|---------|-------------|
| `git log --oneline` | Compact one-line-per-commit |
| `git log --graph --oneline --all` | ASCII graph of all branches |
| `git log -n 10` | Last 10 commits |
| `git log -p` | Show patches (full diffs) |
| `git log --stat` | Show file change stats |
| `git log --author="name"` | Filter by author |
| `git log --since="2 weeks ago"` | Filter by date |
| `git log --grep="pattern"` | Search commit messages |
| `git log -S "string"` | Pickaxe: commits that add/remove string |
| `git log -G "regex"` | Commits where diff matches regex |
| `git log --follow -- <file>` | History of a file, following renames |
| `git log --merges` | Only merge commits |
| `git log --no-merges` | Exclude merge commits |
| `git log --first-parent` | Follow only first parent (main line) |

#### Useful Log Formats

```bash
# Concise graph with colors
git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --all

# Short hash + subject + date (ISO)
git log --pretty=format:'%h %s (%ai)'

# Full commit info in one line
git log --pretty=format:'%H %ae %ai %s'

# Changelog-style
git log --pretty=format:'- %s (%an, %ad)' --date=short

# Show GPG signature status
git log --show-signature -1
```

### Branch

| Command | Description |
|---------|-------------|
| `git branch` | List local branches |
| `git branch -a` | List all branches (local + remote) |
| `git branch -v` | Show last commit on each branch |
| `git branch -vv` | Show tracking info for each branch |
| `git branch <name>` | Create branch (don't switch) |
| `git branch -d <name>` | Delete merged branch |
| `git branch -D <name>` | Force delete branch |
| `git branch -m <old> <new>` | Rename branch |
| `git branch --merged` | Branches merged into current |
| `git branch --no-merged` | Branches not yet merged |
| `git branch --contains <sha>` | Branches containing a commit |

### Checkout & Switch

| Command | Description |
|---------|-------------|
| `git checkout <branch>` | Switch branch |
| `git checkout -b <branch>` | Create + switch |
| `git checkout -` | Switch to previous branch |
| `git checkout -- <file>` | Discard unstaged changes to file |
| `git switch <branch>` | Switch branch (modern) |
| `git switch -c <branch>` | Create + switch (modern) |
| `git restore <file>` | Discard unstaged changes (modern) |
| `git restore --staged <file>` | Unstage file (modern) |

### Merge

| Command | Description |
|---------|-------------|
| `git merge <branch>` | Merge branch into current |
| `git merge --no-ff <branch>` | Force merge commit (no fast-forward) |
| `git merge --ff-only <branch>` | Only fast-forward, fail otherwise |
| `git merge --squash <branch>` | Squash all commits into staging area |
| `git merge --abort` | Abort in-progress merge |
| `git mergetool` | Launch configured merge tool |

### Rebase

| Command | Description |
|---------|-------------|
| `git rebase <branch>` | Rebase current branch onto target |
| `git rebase --onto <new> <old> <branch>` | Transplant commits to new base |
| `git rebase --abort` | Abort in-progress rebase |
| `git rebase --continue` | Continue after resolving conflicts |
| `git rebase --skip` | Skip the current conflicting commit |
| `git rebase --autosquash` | Auto-reorder fixup/squash commits |

#### Interactive Rebase Workflow

```bash
# Start interactive rebase for last N commits
git rebase -i HEAD~N

# Or rebase onto a branch
git rebase -i main
```

In the editor, each line is a commit. Change the command prefix:

| Command | Short | Description |
|---------|-------|-------------|
| `pick` | `p` | Keep commit as-is |
| `reword` | `r` | Keep commit, edit message |
| `edit` | `e` | Pause at commit (amend it, split it) |
| `squash` | `s` | Meld into previous commit, combine messages |
| `fixup` | `f` | Meld into previous commit, discard message |
| `drop` | `d` | Remove commit entirely |
| `exec` | `x` | Run a shell command (e.g., `exec make test`) |
| `break` | `b` | Pause rebase here |

**Tip:** Reorder lines to reorder commits. Use `git commit --fixup=<sha>` then `git rebase -i --autosquash` for a smooth workflow.

### Stash

| Command | Description |
|---------|-------------|
| `git stash` | Stash tracked changes |
| `git stash -u` | Stash including untracked files |
| `git stash -a` | Stash including ignored files |
| `git stash push -m "msg"` | Stash with a description |
| `git stash push -- <file>` | Stash specific file(s) |
| `git stash list` | List all stashes |
| `git stash show -p stash@{0}` | Show stash diff |
| `git stash pop` | Apply + remove top stash |
| `git stash apply` | Apply top stash, keep it |
| `git stash drop stash@{N}` | Remove a specific stash |
| `git stash clear` | Remove all stashes |
| `git stash branch <name>` | Create branch from stash |

### Reset

| Command | Description |
|---------|-------------|
| `git reset --soft HEAD~1` | Undo last commit, keep changes staged |
| `git reset --mixed HEAD~1` | Undo last commit, keep changes unstaged (default) |
| `git reset --hard HEAD~1` | Undo last commit, discard changes |
| `git reset HEAD <file>` | Unstage a file |
| `git reset --hard origin/main` | Match remote exactly (destructive) |

### Cherry-Pick

| Command | Description |
|---------|-------------|
| `git cherry-pick <sha>` | Apply a single commit |
| `git cherry-pick <sha1>..<sha2>` | Apply range (exclusive of sha1) |
| `git cherry-pick --no-commit <sha>` | Apply without committing |
| `git cherry-pick --abort` | Abort in-progress cherry-pick |
| `git cherry-pick -x <sha>` | Append "cherry picked from" to message |

### Bisect

```bash
git bisect start
git bisect bad                 # Current commit is bad
git bisect good <sha>          # Known good commit
# Git checks out midpoint; test, then:
git bisect good                # or git bisect bad
# Repeat until culprit is found
git bisect reset               # Return to original HEAD

# Automated bisect with a test script
git bisect start HEAD <good-sha>
git bisect run ./test.sh
```

### Reflog

| Command | Description |
|---------|-------------|
| `git reflog` | Show HEAD movement history |
| `git reflog show <branch>` | Reflog for a specific branch |
| `git reflog --date=relative` | Show with relative timestamps |
| `git checkout HEAD@{N}` | Restore to reflog entry N |

**Tip:** Reflog is your safety net. Even after `reset --hard`, lost commits are in the reflog for ~90 days.

### Worktree

| Command | Description |
|---------|-------------|
| `git worktree add <path> <branch>` | Create linked worktree for branch |
| `git worktree add -b <new> <path> <start>` | Create new branch in worktree |
| `git worktree list` | List all worktrees |
| `git worktree remove <path>` | Remove a worktree |
| `git worktree prune` | Clean up stale worktree metadata |

### Tag

| Command | Description |
|---------|-------------|
| `git tag` | List tags |
| `git tag -l "v1.*"` | List tags matching pattern |
| `git tag v1.0.0` | Lightweight tag |
| `git tag -a v1.0.0 -m "msg"` | Annotated tag |
| `git tag -a v1.0.0 <sha>` | Tag a past commit |
| `git tag -d v1.0.0` | Delete local tag |
| `git push origin v1.0.0` | Push a single tag |
| `git push origin --tags` | Push all tags |
| `git push origin :refs/tags/v1.0.0` | Delete remote tag |

### Remote

| Command | Description |
|---------|-------------|
| `git remote -v` | List remotes with URLs |
| `git remote add <name> <url>` | Add a remote |
| `git remote rename <old> <new>` | Rename remote |
| `git remote remove <name>` | Remove remote |
| `git remote set-url <name> <url>` | Change remote URL |
| `git fetch --all --prune` | Fetch all remotes, prune stale branches |
| `git push -u origin <branch>` | Push + set upstream tracking |
| `git push --force-with-lease` | Safer force push (checks remote state) |

### Submodule

| Command | Description |
|---------|-------------|
| `git submodule add <url> <path>` | Add a submodule |
| `git submodule init` | Initialize submodule config |
| `git submodule update --init --recursive` | Clone/update all submodules |
| `git submodule status` | Show submodule SHAs + status |
| `git submodule foreach 'git pull'` | Run command in each submodule |
| `git submodule deinit <path>` | Unregister a submodule |
| `git submodule sync` | Sync submodule URLs from .gitmodules |

---

## Useful Global Flags

| Flag | Description |
|------|-------------|
| `git -C <path> <cmd>` | Run command in a different directory |
| `git --no-pager <cmd>` | Disable pager for output |
| `GIT_TRACE=1 git <cmd>` | Debug/trace git internals |

---

## Git-Extras Commands

[git-extras](https://github.com/tj/git-extras) provides ~60 additional git utilities.

| Command | Description |
|---------|-------------|
| `git ignore-io <lang>` | Generate .gitignore from gitignore.io templates |
| `git ignore-io --append python node` | Append multiple templates to .gitignore |
| `git ignore-io -l` | List available templates |
| `git changelog` | Generate HISTORY.md from commits |
| `git changelog --tag <tag>` | Changelog since specific tag |
| `git summary` | Repo summary: age, commits, authors |
| `git summary --line` | Summary with line counts per author |
| `git effort` | Show effort (commits + active days) per file |
| `git effort --above 10` | Files with more than 10 commits |
| `git authors` | Generate AUTHORS file from git log |
| `git authors --list` | Print authors to stdout |
| `git contrib <author>` | Show contributions by an author |
| `git undo` | Undo the last commit (soft reset) |
| `git undo --hard` | Undo last commit and discard changes |
| `git setup` | Initialize repo + initial commit |
| `git touch <file>` | Create file + add + commit |
| `git obliterate <file>` | Remove file from entire history |
| `git delta <branch1> <branch2>` | List commits in branch1 not in branch2 |
| `git count` | Commit count by author |
| `git create-branch <name>` | Create local + remote branch |
| `git delete-branch <name>` | Delete local + remote branch |
| `git delete-merged-branches` | Delete all merged branches |
| `git delete-squashed-branches` | Delete squash-merged branches |
| `git fork <repo-url>` | Fork a repo on GitHub |
| `git release <tag>` | Create tag + push + changelog |
| `git alias` | List all aliases |
| `git archive-file` | Export repo as zip |
| `git missing <branch>` | Show commits missing between branches |
| `git lock <file>` | Lock a file (assume-unchanged) |
| `git unlock <file>` | Unlock a file |
| `git info` | Show repo info (remotes, branches, config) |
| `git standup` | Show what you worked on today/yesterday |
| `git standup -a "name" -d 7` | Specific author, last 7 days |
