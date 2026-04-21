# 1Password CLI (op)

Command-line interface for 1Password. Access secrets, manage items and vaults.

## Authentication

```bash
op signin                       # Sign in interactively
op signout                      # Sign out
op whoami                       # Show current session info
op account list                 # List configured accounts
op account get                  # Get current account details
```

## Items

```bash
op item list                    # List all items
op item list --vault <vault>    # List items in a vault
op item list --categories Login # Filter by category
op item list --tags <tag>       # Filter by tag
op item get <name-or-id>        # Get item details
op item get <name> --fields label=password    # Get specific field
op item get <name> --format json              # JSON output
op item create --category Login --title "My App" \
    --url https://example.com \
    username=user password=pass               # Create item
op item edit <name> password=newpass           # Edit item field
op item delete <name>           # Delete item
op item share <name> --emails user@example.com  # Share item
```

### Categories

`Login`, `Password`, `Secure Note`, `Credit Card`, `Identity`, `SSH Key`, `API Credential`, `Database`, `Server`, `Document`

## Vaults

```bash
op vault list                   # List all vaults
op vault get <name>             # Get vault details
op vault create <name>          # Create a vault
op vault delete <name>          # Delete a vault
```

## Secret References (op://)

Reference secrets directly without fetching the whole item.

```bash
# Format: op://vault/item/[section/]field
op read "op://Personal/GitHub/password"
op read "op://Dev/AWS/Access Key ID"
op read "op://Personal/SSH Key/private key"
```

## op inject

Replace secret references in templates with actual values.

```bash
# Template file (.env.tpl):
# DB_PASSWORD={{ op://Dev/Database/password }}
# API_KEY={{ op://Dev/Service/api-key }}

op inject -i .env.tpl -o .env

# Pipe mode
cat config.tpl | op inject > config.yml
```

## op run

Run a command with secrets injected as environment variables.

```bash
# Using secret references in env vars
export DB_PASS="op://Dev/Database/password"
op run -- my-app

# Inline
op run --env-file .env -- docker compose up

# With specific env vars
op run -- env | grep DB_PASS

# No masking in output
op run --no-masking -- printenv SECRET
```

## Documents

```bash
op document list                # List documents
op document get <name>          # Download document to stdout
op document get <name> -o file  # Save to file
op document create file.pdf --title "My Doc" --vault Personal
op document edit <name> file.pdf
op document delete <name>
```

## SSH Agent

```bash
# In ~/.ssh/config:
# Host *
#     IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
# (Linux: ~/.1password/agent.sock)

# Or export:
export SSH_AUTH_SOCK=~/.1password/agent.sock
```

## Key Flags

| Flag | Description |
|---|---|
| `--format json` | Output as JSON |
| `--format csv` | Output as CSV |
| `--vault <name>` | Target a specific vault |
| `--account <id>` | Target a specific account |
| `--cache` | Enable response caching |
| `--no-newline` | Omit trailing newline |
| `--force` | Skip confirmation prompts |
| `-o` / `--out-file` | Output to file |

## Service Accounts

```bash
# Set token for non-interactive use (CI/CD)
export OP_SERVICE_ACCOUNT_TOKEN="<token>"
op item list                    # Works without signin
```

## Useful Patterns

```bash
# Copy password to clipboard
op item get GitHub --fields label=password | wl-copy -o

# Generate a password
op item create --generate-password=32,letters,digits --category Password --title "Random"

# List all logins as JSON
op item list --categories Login --format json | jq '.[].title'

# Check if signed in
op whoami 2>/dev/null && echo "signed in" || echo "not signed in"

# Use in scripts with read
DB_PASS=$(op read "op://Dev/Database/password")
```
