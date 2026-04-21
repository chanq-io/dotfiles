# Claude Code

Anthropic's agentic CLI for software development powered by Claude.

## Basic Usage

```bash
claude                          # Start interactive REPL
claude "explain this project"   # Start with an initial prompt
claude -p "query"               # Print mode: one-shot, no interactive REPL
claude -c                       # Continue most recent conversation
claude -c -p "follow up"       # Continue in print mode
```

## Key Flags

| Flag | Description |
|---|---|
| `-p` / `--print` | Print mode: non-interactive single response |
| `-c` / `--continue` | Continue the most recent conversation |
| `--model <model>` | Specify model (e.g., `claude-sonnet-4-20250514`) |
| `--dangerously-skip-permissions` | Skip all permission prompts (use in CI only) |
| `--output-format` | Output format: `text`, `json`, `stream-json` |
| `--max-turns <n>` | Limit agentic turns in non-interactive mode |
| `--allowedTools <tools>` | Comma-separated list of allowed tools |
| `--verbose` | Enable verbose logging |
| `--no-cache` | Disable prompt caching |
| `-r` / `--resume` | Resume a specific conversation by ID |

## Slash Commands

| Command | Description |
|---|---|
| `/help` | Show help and available commands |
| `/clear` | Clear conversation context |
| `/compact` | Condense conversation to save context window |
| `/config` | Open or modify configuration |
| `/cost` | Show token usage and cost for current session |
| `/init` | Initialize project with CLAUDE.md |
| `/review` | Review a pull request |
| `/commit` | Create a git commit with AI-generated message |
| `/pr-comments` | View and address PR comments |
| `/terminal-setup` | Install Shift+Enter key binding for newlines |
| `/vim` | Toggle vim mode for input editing |
| `/bug` | Report a bug |
| `/logout` | Sign out of current account |
| `/login` | Switch accounts or auth methods |

## CLAUDE.md

Project instructions file that Claude reads automatically. Place in project root or `~/.claude/CLAUDE.md` for global instructions.

```markdown
# CLAUDE.md

## Project overview
Brief description of the project.

## Code style
- Use TypeScript strict mode
- Prefer functional patterns

## Architecture
Describe the project structure.

## Testing
How to run tests: `npm test`
How to run a single test: `npm test -- path/to/test`

## Common commands
- Build: `npm run build`
- Lint: `npm run lint`
```

### CLAUDE.md Locations (in priority order)

1. `./CLAUDE.md` - Current directory (highest priority)
2. `./CLAUDE.local.md` - Local overrides (gitignored)
3. Parent directories' `CLAUDE.md` files
4. `~/.claude/CLAUDE.md` - Global instructions

## MCP Integration

Configure MCP (Model Context Protocol) servers for extended tool access.

```bash
# Add MCP server via CLI
claude mcp add <name> <command> [args...]

# Examples
claude mcp add github -- gh copilot
claude mcp add sqlite -- npx -y @anthropic-ai/mcp-server-sqlite db.sqlite
claude mcp add filesystem -- npx -y @anthropic-ai/mcp-server-filesystem /path

# List configured servers
claude mcp list

# Remove a server
claude mcp remove <name>
```

MCP config in `~/.claude/settings.json`:

```json
{
    "mcpServers": {
        "filesystem": {
            "command": "npx",
            "args": ["-y", "@anthropic-ai/mcp-server-filesystem", "/home/user"]
        }
    }
}
```

## Piping & Scripting

```bash
# Pipe input
cat error.log | claude -p "explain this error"

# Use in scripts
result=$(claude -p "generate a regex for email validation")

# JSON output for programmatic use
claude -p "list project deps" --output-format json

# Process files
claude -p "review this file" < src/main.ts

# Multi-turn scripting
claude -p "find all TODO comments" --max-turns 5
```

## Configuration

```bash
claude config list              # List all settings
claude config get <key>         # Get a setting value
claude config set <key> <val>   # Set a setting
```

### Key Settings

| Setting | Description |
|---|---|
| `model` | Default model to use |
| `permissions` | Tool permission rules |
| `env` | Environment variables for sessions |

## Tips

- Use `/compact` when context gets large to free up the context window.
- `CLAUDE.md` is the primary way to give Claude persistent project context.
- Print mode (`-p`) is ideal for CI/CD pipelines and scripting.
- `--dangerously-skip-permissions` is for trusted CI environments only.
- Use `--max-turns` with `-p` to control how much autonomous work Claude does.
- `Esc` key interrupts Claude mid-response.
- Multi-line input: use `Shift+Enter` (after `/terminal-setup`) or `\` at line end.
