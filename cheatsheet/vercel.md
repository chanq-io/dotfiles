# Vercel CLI Cheatsheet

Command-line interface for deploying and managing projects on Vercel.

---

## Setup

```bash
npm i -g vercel                      # Install globally
vercel login                         # Authenticate (opens browser)
vercel login --github                # Login via GitHub
vercel login --token <token>         # Login with token (CI)
vercel whoami                        # Show current user
vercel switch <team>                 # Switch team scope
```

## Deploying

| Command | Description |
|---|---|
| `vercel` | Deploy to preview (prompts to link if needed) |
| `vercel --prod` | Deploy to production |
| `vercel --prebuilt` | Deploy using prebuilt output (`.vercel/output`) |
| `vercel --yes` | Skip confirmation prompts |
| `vercel --no-wait` | Don't wait for deployment to finish |
| `vercel --archive=tgz` | Compress upload |
| `vercel --force` | Force new deployment (skip cache) |
| `vercel --with-cache` | Retain build cache |

### Deploy Flags

| Flag | Description |
|---|---|
| `--prod` | Deploy to production domain |
| `--prebuilt` | Use pre-built output directory |
| `--yes` / `-y` | Auto-confirm prompts |
| `--no-wait` | Return immediately after upload |
| `--force` | Force rebuild, skip cache |
| `--build-env KEY=VAL` | Set build environment variable |
| `-e KEY=VAL` | Set runtime environment variable |
| `--regions <list>` | Deploy to specific regions |
| `--scope <team>` | Deploy under a team |
| `--token <t>` | Auth token (for CI) |

## Local Development

```bash
vercel dev                           # Start local dev server (mirrors Vercel environment)
vercel dev --listen 0.0.0.0:3000     # Bind to specific address/port
vercel build                         # Run build locally (outputs to .vercel/output)
```

## Project Management

| Command | Description |
|---|---|
| `vercel project ls` | List all projects |
| `vercel project add <name>` | Create a new project |
| `vercel project rm <name>` | Remove a project |
| `vercel link` | Link current directory to a Vercel project |
| `vercel link --yes` | Link with defaults, no prompts |
| `vercel unlink` | Unlink current directory |
| `vercel inspect <url>` | Show deployment details |

## Environment Variables

| Command | Description |
|---|---|
| `vercel env ls` | List all environment variables |
| `vercel env ls production` | List env vars for production |
| `vercel env add <key>` | Add env var (prompts for value and environments) |
| `vercel env add <key> production` | Add env var for specific environment |
| `vercel env add <key> production < value.txt` | Add from file/stdin |
| `vercel env rm <key>` | Remove env var |
| `vercel env rm <key> production` | Remove from specific environment |
| `vercel env pull .env.local` | Pull remote env vars to local file |
| `vercel env pull .env.local --environment=preview` | Pull from specific environment |

### Environments

Vercel has three target environments:
- `production` -- live production deployment
- `preview` -- branch/PR deployments
- `development` -- local dev (`vercel dev`)

## Domains

| Command | Description |
|---|---|
| `vercel domains ls` | List all domains |
| `vercel domains add <domain>` | Add a domain |
| `vercel domains rm <domain>` | Remove a domain |
| `vercel domains inspect <domain>` | Show domain details + DNS |
| `vercel domains move <domain> <team>` | Transfer domain to another team |
| `vercel certs ls` | List SSL certificates |

## DNS

```bash
vercel dns ls <domain>                             # List DNS records
vercel dns add <domain> <name> <type> <value>      # Add DNS record
vercel dns rm <record-id>                          # Remove DNS record
```

## Logs

| Command | Description |
|---|---|
| `vercel logs <url>` | View deployment logs |
| `vercel logs <url> --follow` | Stream logs in real time |
| `vercel logs <url> --since 1h` | Logs from last hour |
| `vercel logs <url> --output raw` | Raw log output |

## Deployments

| Command | Description |
|---|---|
| `vercel ls` | List recent deployments |
| `vercel ls --meta key=value` | Filter deployments by metadata |
| `vercel inspect <url>` | Detailed deployment info |
| `vercel redeploy` | Redeploy latest deployment |
| `vercel rollback <url>` | Rollback to a specific deployment |
| `vercel rm <url>` | Delete a deployment |
| `vercel promote <url>` | Promote preview deployment to production |
| `vercel alias set <url> <alias>` | Set custom alias for deployment |

## Secrets (Legacy, prefer Environment Variables)

| Command | Description |
|---|---|
| `vercel secrets ls` | List secrets |
| `vercel secrets add <name> <value>` | Add a secret |
| `vercel secrets rm <name>` | Remove a secret |

## Pull & Link Workflow

```bash
# 1. Link to existing project
vercel link

# 2. Pull environment variables and project settings
vercel env pull .env.local

# 3. Develop locally with Vercel environment
vercel dev

# 4. Deploy preview
vercel

# 5. Deploy to production
vercel --prod
```

## CI/CD Usage

```bash
# Install and authenticate
npm i -g vercel
vercel pull --yes --environment=production --token=$VERCEL_TOKEN

# Build
vercel build --prod --token=$VERCEL_TOKEN

# Deploy prebuilt
vercel deploy --prebuilt --prod --token=$VERCEL_TOKEN
```

## Key Files

| File | Description |
|---|---|
| `vercel.json` | Project configuration (routes, headers, rewrites, env) |
| `.vercel/project.json` | Local project link (auto-generated) |
| `.vercel/output/` | Build output directory (for `--prebuilt`) |
| `.vercelignore` | Files to exclude from deployment (like `.gitignore`) |

### vercel.json Example

```json
{
  "buildCommand": "npm run build",
  "outputDirectory": "dist",
  "framework": "nextjs",
  "regions": ["iad1"],
  "rewrites": [
    { "source": "/api/:path*", "destination": "/api/:path*" }
  ],
  "headers": [
    {
      "source": "/(.*)",
      "headers": [
        { "key": "X-Frame-Options", "value": "DENY" }
      ]
    }
  ],
  "redirects": [
    { "source": "/old", "destination": "/new", "permanent": true }
  ]
}
```

## Tips

- Use `vercel --prod` only when you are ready to go live; plain `vercel` creates a preview URL.
- Use `vercel env pull` to sync remote env vars locally instead of maintaining `.env` files manually.
- The `vercel dev` command replicates the Vercel environment locally, including serverless functions and routing.
- Use `--prebuilt` in CI to separate build and deploy steps for faster deployments.
- Add `--token` and `--yes` flags in CI pipelines to avoid interactive prompts.
- Use `vercel inspect <deployment-url>` to debug deployment issues (shows build logs, routes, etc.).
