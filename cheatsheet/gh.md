# GitHub CLI (gh) Cheatsheet

The official GitHub CLI for managing repos, PRs, issues, actions, releases, and more from the terminal.

---

## Authentication

| Command | Description |
|---------|-------------|
| `gh auth login` | Authenticate with GitHub |
| `gh auth login --with-token < token.txt` | Auth via token from stdin |
| `gh auth status` | Check auth status |
| `gh auth token` | Print current auth token |
| `gh auth logout` | Log out |
| `gh auth refresh -s <scopes>` | Add scopes (e.g., `read:project`) |
| `gh auth setup-git` | Configure git to use gh as credential helper |

---

## Repository

| Command | Description |
|---------|-------------|
| `gh repo clone <owner/repo>` | Clone a repo |
| `gh repo clone <owner/repo> -- --depth=1` | Shallow clone |
| `gh repo create <name>` | Create new repo (interactive) |
| `gh repo create <name> --public --source=.` | Create from existing local repo |
| `gh repo create <name> --private --clone` | Create private + clone it |
| `gh repo create <name> --template <t>` | Create from template repo |
| `gh repo fork` | Fork current repo |
| `gh repo fork --clone` | Fork + clone |
| `gh repo fork <owner/repo>` | Fork a specific repo |
| `gh repo view` | View current repo info |
| `gh repo view <owner/repo> --web` | Open repo in browser |
| `gh repo view --json name,description` | JSON output of repo fields |
| `gh repo list <owner>` | List repos for a user/org |
| `gh repo list <owner> -L 100` | List up to 100 repos |
| `gh repo rename <new-name>` | Rename current repo |
| `gh repo delete <owner/repo> --yes` | Delete a repo |
| `gh repo archive <owner/repo>` | Archive a repo |
| `gh repo edit --default-branch main` | Change default branch |
| `gh repo sync` | Sync fork with upstream |

---

## Pull Requests

### Creating & Listing

| Command | Description |
|---------|-------------|
| `gh pr create` | Create PR (interactive) |
| `gh pr create --title "T" --body "B"` | Create with inline title/body |
| `gh pr create --fill` | Auto-fill title/body from commits |
| `gh pr create --draft` | Create as draft PR |
| `gh pr create --base main` | Target a specific base branch |
| `gh pr create --reviewer user1,user2` | Request reviewers |
| `gh pr create --label bug,urgent` | Add labels |
| `gh pr create --assignee @me` | Assign to yourself |
| `gh pr create --web` | Open browser to create PR |
| `gh pr list` | List open PRs |
| `gh pr list --state all` | List all PRs |
| `gh pr list --author @me` | Your PRs |
| `gh pr list --label "bug"` | Filter by label |
| `gh pr list --search "review:required"` | Search with GitHub query syntax |
| `gh pr list --json number,title,url` | JSON output |

### Viewing & Checking Out

| Command | Description |
|---------|-------------|
| `gh pr view <number>` | View PR details |
| `gh pr view <number> --web` | Open PR in browser |
| `gh pr view <number> --json reviews` | JSON output of specific fields |
| `gh pr checkout <number>` | Check out a PR branch locally |
| `gh pr diff <number>` | View PR diff |
| `gh pr diff <number> --patch` | Patch format |
| `gh pr checks <number>` | View CI check status |
| `gh pr checks <number> --watch` | Watch checks until they complete |

### Reviewing & Merging

| Command | Description |
|---------|-------------|
| `gh pr review <number> --approve` | Approve a PR |
| `gh pr review <number> --request-changes -b "msg"` | Request changes |
| `gh pr review <number> --comment -b "msg"` | Leave a comment review |
| `gh pr merge <number>` | Merge PR (interactive) |
| `gh pr merge <number> --merge` | Merge commit |
| `gh pr merge <number> --squash` | Squash merge |
| `gh pr merge <number> --rebase` | Rebase merge |
| `gh pr merge <number> --auto` | Enable auto-merge |
| `gh pr merge <number> --delete-branch` | Delete branch after merge |
| `gh pr ready <number>` | Mark draft PR as ready |
| `gh pr close <number>` | Close a PR |
| `gh pr reopen <number>` | Reopen a closed PR |
| `gh pr edit <number> --title "new"` | Edit PR title |
| `gh pr edit <number> --add-label "label"` | Add label |
| `gh pr edit <number> --add-reviewer user` | Add reviewer |

---

## Issues

| Command | Description |
|---------|-------------|
| `gh issue create` | Create issue (interactive) |
| `gh issue create --title "T" --body "B"` | Create with title/body |
| `gh issue create --label bug --assignee @me` | Create with metadata |
| `gh issue create --web` | Open browser to create |
| `gh issue list` | List open issues |
| `gh issue list --state closed` | List closed issues |
| `gh issue list --label "bug"` | Filter by label |
| `gh issue list --assignee @me` | Your issues |
| `gh issue list --search "no:assignee"` | Search with GitHub syntax |
| `gh issue list --json number,title,labels` | JSON output |
| `gh issue view <number>` | View issue |
| `gh issue view <number> --web` | Open in browser |
| `gh issue view <number> --comments` | Show comments |
| `gh issue close <number>` | Close issue |
| `gh issue close <number> -r "not planned"` | Close with reason |
| `gh issue reopen <number>` | Reopen issue |
| `gh issue edit <number> --title "new"` | Edit issue |
| `gh issue pin <number>` | Pin issue |
| `gh issue transfer <number> <repo>` | Transfer to another repo |
| `gh issue develop <number>` | Create branch for issue |

---

## Actions / Workflow Runs

| Command | Description |
|---------|-------------|
| `gh run list` | List recent workflow runs |
| `gh run list --workflow=ci.yml` | Filter by workflow file |
| `gh run list --branch main` | Filter by branch |
| `gh run list --status failure` | Filter by status |
| `gh run list --json status,conclusion,url` | JSON output |
| `gh run view <run-id>` | View run details |
| `gh run view <run-id> --log` | View full logs |
| `gh run view <run-id> --log-failed` | View only failed step logs |
| `gh run view <run-id> --web` | Open in browser |
| `gh run watch <run-id>` | Watch run until it finishes |
| `gh run watch` | Watch most recent run |
| `gh run rerun <run-id>` | Rerun a workflow run |
| `gh run rerun <run-id> --failed` | Rerun only failed jobs |
| `gh run cancel <run-id>` | Cancel a running workflow |
| `gh run download <run-id>` | Download run artifacts |
| `gh workflow list` | List workflows |
| `gh workflow run <workflow>` | Manually trigger a workflow |
| `gh workflow run <workflow> -f key=val` | Trigger with inputs |
| `gh workflow enable <workflow>` | Enable a workflow |
| `gh workflow disable <workflow>` | Disable a workflow |

---

## Releases

| Command | Description |
|---------|-------------|
| `gh release list` | List releases |
| `gh release view <tag>` | View a release |
| `gh release create <tag>` | Create release (interactive) |
| `gh release create <tag> --generate-notes` | Auto-generate release notes |
| `gh release create <tag> --draft` | Create as draft |
| `gh release create <tag> --prerelease` | Mark as prerelease |
| `gh release create <tag> ./dist/*` | Upload assets |
| `gh release create <tag> --notes "body"` | Inline notes |
| `gh release create <tag> -F notes.md` | Notes from file |
| `gh release download <tag>` | Download release assets |
| `gh release delete <tag> --yes` | Delete a release |
| `gh release edit <tag> --draft=false` | Publish a draft release |

---

## Gists

| Command | Description |
|---------|-------------|
| `gh gist create <file>` | Create gist from file |
| `gh gist create --public <file>` | Create public gist |
| `gh gist create -d "description" f1 f2` | Multi-file gist with description |
| `gh gist list` | List your gists |
| `gh gist view <id>` | View a gist |
| `gh gist edit <id>` | Edit a gist |
| `gh gist clone <id>` | Clone a gist |
| `gh gist delete <id>` | Delete a gist |

---

## API

```bash
# GET request
gh api repos/{owner}/{repo}

# POST request with JSON body
gh api repos/{owner}/{repo}/issues -f title="Bug" -f body="Details"

# Use jq-style queries
gh api repos/{owner}/{repo}/pulls --jq '.[].title'

# Paginate through results
gh api repos/{owner}/{repo}/issues --paginate

# GraphQL query
gh api graphql -f query='{ viewer { login } }'

# Custom HTTP method
gh api -X DELETE repos/{owner}/{repo}/issues/1/labels/bug

# Use with headers
gh api -H "Accept: application/vnd.github+json" /repos/{owner}/{repo}
```

---

## Extensions

| Command | Description |
|---------|-------------|
| `gh extension list` | List installed extensions |
| `gh extension search <query>` | Search for extensions |
| `gh extension install <repo>` | Install an extension |
| `gh extension upgrade <name>` | Upgrade an extension |
| `gh extension upgrade --all` | Upgrade all extensions |
| `gh extension remove <name>` | Remove an extension |
| `gh extension create <name>` | Scaffold a new extension |

### Popular Extensions

| Extension | Description |
|-----------|-------------|
| `gh dash` | Dashboard TUI for PRs and issues |
| `gh copilot` | GitHub Copilot in the CLI |
| `gh poi` | Clean up local branches safely |
| `gh markdown-preview` | Preview markdown in browser |

---

## Key Global Flags

| Flag | Description |
|------|-------------|
| `--repo <owner/repo>` | Target a specific repo (overrides current dir) |
| `--json <fields>` | Output specific fields as JSON |
| `--jq <expr>` | Filter JSON output with jq expression |
| `--template <tpl>` | Format output with Go template |
| `--web` | Open result in browser |
| `--help` | Help for any command |
| `GH_REPO=owner/repo` | Env var to set default repo |
| `GH_TOKEN=<token>` | Env var to set auth token |
| `GH_HOST=<host>` | Env var for GitHub Enterprise host |
