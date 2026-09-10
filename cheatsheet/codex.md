# Codex CLI

OpenAI's agentic coding CLI (peer of `claude-code`). On NixOS it comes from the nixpkgs-unstable overlay; on macOS from brew. The `codex-acp` / ACP bridge is what codecompanion.nvim uses (adapter `codex`, ChatGPT auth).

---

## Sessions

```bash
codex                       # interactive TUI in cwd
codex "fix the failing test"  # start with an initial prompt
codex exec "write a commit message"   # non-interactive: run one task, print, exit
codex resume                # pick up a previous session
codex --model <model>       # override model
codex -C <dir>              # run against another directory
```

## Auth

```bash
codex login                 # ChatGPT-account OAuth (default here)
codex login --api-key       # use an OpenAI API key instead
codex logout
```

## In-session Commands

| Command | Action |
|---------|--------|
| `/init` | Generate an AGENTS.md for the project |
| `/model` | Switch model / reasoning effort |
| `/approvals` | Change approval mode |
| `/review` | Review current changes |
| `/compact` | Summarize conversation to reclaim context |
| `/status` | Session info (model, tokens, approvals) |
| `/diff` | Show working-tree diff |
| `/quit` | Exit |

## Approval Modes

| Mode | Behavior |
|------|----------|
| Read Only / suggest | Proposes edits/commands, asks before everything |
| Auto / agent | Edits files and runs commands in the workspace sandbox, asks to go outside it |
| Full access | No prompts (use with care) |

## Config

`~/.codex/config.toml` — model, approval defaults, MCP servers. Project instructions live in `AGENTS.md` (repo root and/or `~/.codex/AGENTS.md`), the same convention this repo's `agents/` dir feeds.
