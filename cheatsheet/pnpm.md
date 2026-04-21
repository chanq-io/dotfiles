# pnpm Cheatsheet

Fast, disk space efficient package manager for Node.js.

---

## Install & Manage Dependencies

| Command | Description |
|---------|-------------|
| `pnpm install` / `pnpm i` | Install all deps from lockfile |
| `pnpm add PKG` | Add production dependency |
| `pnpm add -D PKG` | Add dev dependency |
| `pnpm add -g PKG` | Add global package |
| `pnpm add -O PKG` | Add optional dependency |
| `pnpm add -E PKG` | Add with exact version (no ^ prefix) |
| `pnpm add PKG@version` | Add specific version |
| `pnpm add PKG@next` | Add with dist-tag |
| `pnpm remove PKG` / `pnpm rm PKG` | Remove dependency |
| `pnpm remove -g PKG` | Remove global package |
| `pnpm update` / `pnpm up` | Update all deps within ranges |
| `pnpm update --latest` / `-L` | Update to latest, ignore ranges |
| `pnpm update PKG` | Update specific package |

## Key Install Flags

| Flag | Description |
|------|-------------|
| `--frozen-lockfile` | Fail if lockfile is outdated (CI) |
| `--prefer-offline` | Use cached packages when possible |
| `--prod` | Install production deps only |
| `--no-optional` | Skip optional deps |
| `--shamefully-hoist` | Hoist all deps (compat with npm) |
| `--ignore-scripts` | Skip lifecycle scripts |

## Scripts & Execution

| Command | Description |
|---------|-------------|
| `pnpm run SCRIPT` | Run a package.json script |
| `pnpm start` | Run start script (shorthand) |
| `pnpm test` / `pnpm t` | Run test script (shorthand) |
| `pnpm exec CMD` | Run a command from node_modules/.bin |
| `pnpm dlx PKG` | Download and run a package (like npx) |
| `pnpm create APP` | Shorthand for create-* generators |

```bash
pnpm run build
pnpm exec tsc --version
pnpm dlx create-react-app my-app
pnpm create vite my-app
```

## Inspect Dependencies

| Command | Description |
|---------|-------------|
| `pnpm list` / `pnpm ls` | List installed packages |
| `pnpm list --depth=0` | Top-level deps only |
| `pnpm list -g` | List global packages |
| `pnpm why PKG` | Show why a package is installed |
| `pnpm outdated` | Show outdated packages |
| `pnpm audit` | Check for security vulnerabilities |
| `pnpm audit --fix` | Auto-fix vulnerabilities |
| `pnpm licenses list` | List dependency licenses |

## Store Management

pnpm uses a content-addressable store to deduplicate packages on disk.

| Command | Description |
|---------|-------------|
| `pnpm store status` | Check for modified packages in store |
| `pnpm store prune` | Remove unreferenced packages |
| `pnpm store path` | Show store directory path |

## Linking

| Command | Description |
|---------|-------------|
| `pnpm link --global` | Link current package globally |
| `pnpm link --global PKG` | Link global package into project |
| `pnpm unlink` | Unlink a linked package |

## Workspaces

### Setup

```yaml
# pnpm-workspace.yaml
packages:
  - "packages/*"
  - "apps/*"
```

### Workspace Commands

| Command | Description |
|---------|-------------|
| `pnpm -r CMD` / `pnpm --recursive CMD` | Run in every workspace package |
| `pnpm --filter PKG CMD` | Run in specific package |
| `pnpm --filter PKG... CMD` | Run in package and its dependencies |
| `pnpm --filter ...PKG CMD` | Run in package and its dependents |
| `pnpm --filter "./packages/**" CMD` | Run in matching directories |
| `pnpm --filter "!PKG" CMD` | Run in all except package |
| `pnpm -r --parallel CMD` | Run in parallel across packages |
| `pnpm add PKG --filter TARGET` | Add dep to specific workspace package |
| `pnpm add PKG -w` | Add dep to workspace root |

### Filter Examples

```bash
pnpm --filter my-app run build           # build specific package
pnpm --filter my-app... run build         # build package + its deps
pnpm --filter "my-app^..." run build      # build only deps of my-app
pnpm --filter "./packages/*" run test     # test all packages in dir
pnpm -r run build                         # build everything
pnpm -r --parallel run lint               # lint all in parallel
pnpm --filter "...[origin/main]" run test # test changed since main
```

### Workspace Protocol

In `package.json`:

```json
{
  "dependencies": {
    "shared-utils": "workspace:*",
    "my-lib": "workspace:^1.0.0"
  }
}
```

## Configuration

### `.npmrc`

```ini
# .npmrc
auto-install-peers=true
strict-peer-dependencies=false
shamefully-hoist=false
node-linker=hoisted           # or isolated (default), pnp
prefer-frozen-lockfile=true
```

### Key Config Options

| Setting | Description |
|---------|-------------|
| `auto-install-peers` | Auto-install peer deps |
| `strict-peer-dependencies` | Fail on unmet peer deps |
| `shamefully-hoist` | Hoist all to root node_modules |
| `node-linker` | `isolated` (default), `hoisted`, `pnp` |
| `public-hoist-pattern` | Patterns for packages to hoist |
| `side-effects-cache` | Cache packages with side effects |

## Miscellaneous

```bash
pnpm env use --global lts       # install and use Node LTS
pnpm env use --global 22        # install and use Node 22
pnpm setup                      # set up pnpm (add to PATH)
pnpm config list                # show config
pnpm root                       # show node_modules path
pnpm root -g                    # show global node_modules path
pnpm bin                        # show .bin directory path
pnpm pack                       # create tarball of package
pnpm publish                    # publish to registry
pnpm publish --no-git-checks    # skip git checks when publishing
```

## pnpm vs npm vs yarn

| npm | yarn | pnpm |
|-----|------|------|
| `npm install` | `yarn` | `pnpm install` |
| `npm install PKG` | `yarn add PKG` | `pnpm add PKG` |
| `npx` | `yarn dlx` | `pnpm dlx` |
| `npm run` | `yarn run` | `pnpm run` |
| `npm test` | `yarn test` | `pnpm test` |
