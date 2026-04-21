# Supabase CLI Cheatsheet

CLI for local Supabase development, database migrations, Edge Functions, and project management.

---

## Setup & Project Linking

```bash
supabase init                        # Initialize a new Supabase project locally (creates supabase/ dir)
supabase login                       # Authenticate with Supabase platform
supabase link --project-ref <ref>    # Link local project to remote Supabase project
supabase link --project-ref <ref> --password <db-pass>  # Link with DB password
```

## Local Development

| Command | Description |
|---|---|
| `supabase start` | Start local Supabase stack (Postgres, Auth, Storage, etc.) |
| `supabase stop` | Stop local stack |
| `supabase stop --no-backup` | Stop and discard local database data |
| `supabase status` | Show local service URLs and keys |
| `supabase status -o env` | Output status as environment variables |

`supabase start` provides local URLs for:
- **API**: `http://localhost:54321`
- **DB**: `postgresql://postgres:postgres@localhost:54322/postgres`
- **Studio**: `http://localhost:54323`
- **Inbucket** (email): `http://localhost:54324`

## Database Commands

| Command | Description |
|---|---|
| `supabase db reset` | Reset local DB: drop, recreate, run all migrations + seed |
| `supabase db push` | Push local migrations to remote database |
| `supabase db pull` | Pull remote schema changes as a new migration |
| `supabase db pull --schema auth,storage` | Pull specific schemas |
| `supabase db diff` | Diff local schema against migrations (shows uncommitted changes) |
| `supabase db diff --use-migra` | Use migra for diffing |
| `supabase db diff --schema public` | Diff specific schema |
| `supabase db diff -f <name>` | Diff and save as new migration file |
| `supabase db lint` | Lint database for common issues |
| `supabase db dump -f dump.sql` | Dump remote database schema |
| `supabase db dump -f dump.sql --data-only` | Dump data only |
| `supabase db dump -f roles.sql --role-only` | Dump roles only |

## Migrations

| Command | Description |
|---|---|
| `supabase migration new <name>` | Create a new empty migration file |
| `supabase migration list` | List migrations and their status (local vs remote) |
| `supabase migration up` | Apply pending migrations to local database |
| `supabase migration repair --status applied <version>` | Mark migration as applied |
| `supabase migration repair --status reverted <version>` | Mark migration as reverted |
| `supabase migration squash` | Squash migrations into a single file |
| `supabase migration squash --version <v>` | Squash up to a specific version |

### Migration Workflow

```bash
# 1. Make changes in Studio or via SQL
# 2. Generate migration from diff
supabase db diff -f add_users_table

# 3. Verify migration
supabase db reset

# 4. Push to remote
supabase db push
```

## Type Generation

```bash
supabase gen types typescript --local              # Generate types from local DB
supabase gen types typescript --linked              # Generate types from linked remote DB
supabase gen types typescript --local > types/supabase.ts  # Save to file
supabase gen types typescript --local --schema public      # Specific schema
```

## Edge Functions

| Command | Description |
|---|---|
| `supabase functions new <name>` | Create a new Edge Function |
| `supabase functions serve` | Serve all functions locally |
| `supabase functions serve <name>` | Serve specific function |
| `supabase functions serve --env-file .env` | Serve with env file |
| `supabase functions deploy <name>` | Deploy function to remote |
| `supabase functions deploy --no-verify-jwt` | Deploy without JWT verification |
| `supabase functions delete <name>` | Delete a deployed function |
| `supabase functions list` | List deployed functions |

### Edge Function Structure

```
supabase/functions/
  my-function/
    index.ts          # Entry point
```

```typescript
// supabase/functions/my-function/index.ts
import { serve } from "https://deno.land/std@0.168.0/http/server.ts"

serve(async (req) => {
  const { name } = await req.json()
  return new Response(
    JSON.stringify({ message: `Hello ${name}!` }),
    { headers: { "Content-Type": "application/json" } }
  )
})
```

## Secrets

```bash
supabase secrets list                              # List remote secrets
supabase secrets set KEY1=value1 KEY2=value2       # Set secrets
supabase secrets unset KEY1 KEY2                   # Remove secrets
```

## Inspect (Database Performance)

```bash
supabase inspect db calls                          # Most frequently called queries
supabase inspect db long-running-queries           # Long-running queries
supabase inspect db outliers                       # Slowest queries by total time
supabase inspect db index-usage                    # Index usage stats
supabase inspect db unused-indexes                 # Unused indexes
supabase inspect db table-sizes                    # Table sizes
supabase inspect db bloat                          # Table bloat
supabase inspect db cache-hit                      # Cache hit rate
supabase inspect db locks                          # Current locks
supabase inspect db blocking                       # Blocking queries
supabase inspect db role-connections               # Connections per role
```

## Other Commands

| Command | Description |
|---|---|
| `supabase projects list` | List all projects |
| `supabase orgs list` | List organizations |
| `supabase domains create` | Set up custom domain |
| `supabase vanity-subdomains activate` | Activate vanity subdomain |
| `supabase ssl-enforcement update --enable-db-ssl` | Enforce SSL on DB |
| `supabase network-restrictions update` | Configure network restrictions |
| `supabase seed buckets` | Seed storage buckets from config |

## Key Flags

| Flag | Description |
|---|---|
| `--project-ref <ref>` | Target a specific project |
| `--linked` | Use linked remote project |
| `--local` | Use local development instance |
| `--debug` | Verbose debug output |
| `--workdir <path>` | Set working directory |
| `--experimental` | Enable experimental features |
| `--dns-resolver native` | Use native DNS resolver |

## Config File

`supabase/config.toml` controls local development settings:

```toml
[api]
port = 54321
schemas = ["public", "graphql_public"]
extra_search_path = ["public", "extensions"]
max_rows = 1000

[db]
port = 54322
major_version = 15

[studio]
port = 54323

[auth]
site_url = "http://localhost:3000"
additional_redirect_urls = ["https://localhost:3000"]
jwt_expiry = 3600

[auth.external.google]
enabled = true
client_id = "env(GOOGLE_CLIENT_ID)"
secret = "env(GOOGLE_CLIENT_SECRET)"
redirect_uri = ""
```

## Tips

- Run `supabase db reset` frequently during development to ensure migrations are clean and reproducible.
- Use `supabase db diff -f <name>` to auto-generate migrations from changes made in Studio.
- Use `supabase status -o env` to quickly get connection strings for local services.
- Seed data goes in `supabase/seed.sql` and runs after migrations on `db reset`.
- Edge Functions run on Deno, not Node.js. Use Deno-compatible imports.
- Use `supabase gen types` in CI to keep TypeScript types in sync with your schema.
