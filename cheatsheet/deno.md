# Deno Cheatsheet

A secure JavaScript/TypeScript runtime with built-in tooling. TypeScript works out of the box.

---

## Running Code

```bash
deno run file.ts                   # run a script
deno run --watch file.ts           # run with file watcher
deno run https://example.com/mod.ts  # run remote module
deno run -A file.ts                # run with all permissions
deno run --allow-read --allow-net file.ts  # specific permissions
deno task TASK                     # run task from deno.json
deno repl                          # start interactive REPL
```

## Permissions

Deno is secure by default. Grant access explicitly:

| Flag | Description |
|------|-------------|
| `-A`, `--allow-all` | Allow all permissions |
| `--allow-read[=paths]` | File system read |
| `--allow-write[=paths]` | File system write |
| `--allow-net[=hosts]` | Network access |
| `--allow-env[=vars]` | Environment variables |
| `--allow-run[=cmds]` | Subprocess execution |
| `--allow-ffi` | Foreign function interface |
| `--allow-sys` | System info access |
| `--deny-read[=paths]` | Deny file read (overrides allow) |
| `--deny-write[=paths]` | Deny file write |
| `--deny-net[=hosts]` | Deny network access |
| `--deny-env[=vars]` | Deny env access |

```bash
deno run --allow-read=./data --allow-net=api.example.com file.ts
deno run --allow-env=HOME,PATH file.ts
deno run --allow-run=git,curl file.ts
```

## Built-in Tools

### Format

```bash
deno fmt                     # format all files
deno fmt file.ts             # format specific file
deno fmt --check             # check without modifying
deno fmt --options-indent-width=4   # custom indent
deno fmt --ext=md README.md  # format as specific extension
```

### Lint

```bash
deno lint                    # lint all files
deno lint file.ts            # lint specific file
deno lint --rules            # list available rules
```

### Test

```bash
deno test                    # run all tests
deno test file_test.ts       # run specific test file
deno test --filter "name"    # filter by test name
deno test --watch            # re-run on changes
deno test --coverage         # collect coverage
deno coverage ./coverage     # display coverage report
deno test --doc              # test code blocks in JSDoc/markdown
deno test --parallel         # run tests in parallel
deno test --reporter=dot     # change reporter (pretty, dot, junit, tap)
```

Test file format:

```typescript
import { assertEquals } from "jsr:@std/assert";

Deno.test("my test", () => {
  assertEquals(1 + 1, 2);
});

Deno.test("async test", async () => {
  const data = await fetchData();
  assertEquals(data.status, 200);
});
```

### Benchmark

```bash
deno bench                   # run all benchmarks
deno bench bench.ts          # run specific file
```

```typescript
Deno.bench("example", () => {
  new URL("https://example.com");
});
```

### Compile

```bash
deno compile file.ts                # compile to executable
deno compile -A file.ts             # with permissions baked in
deno compile --output myapp file.ts # custom output name
deno compile --target x86_64-unknown-linux-gnu file.ts  # cross-compile
```

Available targets: `x86_64-unknown-linux-gnu`, `aarch64-unknown-linux-gnu`, `x86_64-pc-windows-msvc`, `x86_64-apple-darwin`, `aarch64-apple-darwin`.

### Type Checking

```bash
deno check file.ts           # type-check without running
deno check --all file.ts     # type-check including remote modules
```

### Documentation

```bash
deno doc file.ts             # show docs for a module
deno doc --html file.ts      # generate HTML docs
deno doc --json file.ts      # JSON output
```

### Info

```bash
deno info                    # show cache directories, config
deno info file.ts            # show dependency tree for a module
deno info --json file.ts     # JSON dependency graph
```

## Package Management

```bash
deno install                 # install deps from deno.json
deno add jsr:@std/assert     # add JSR package
deno add npm:express         # add npm package
deno remove @std/assert      # remove a dependency
```

### Import Maps (deno.json)

```jsonc
{
  "imports": {
    "@std/assert": "jsr:@std/assert@^1.0.0",
    "express": "npm:express@4",
    "~/": "./src/"
  }
}
```

## deno.json Configuration

```jsonc
{
  "tasks": {
    "dev": "deno run --watch --allow-all main.ts",
    "build": "deno compile -A main.ts"
  },
  "imports": {
    "@std/assert": "jsr:@std/assert@^1.0.0"
  },
  "compilerOptions": {
    "strict": true,
    "jsx": "react-jsx",
    "jsxImportSource": "react"
  },
  "fmt": {
    "indentWidth": 2,
    "semiColons": true,
    "singleQuote": false
  },
  "lint": {
    "rules": {
      "exclude": ["no-unused-vars"]
    }
  },
  "test": {
    "exclude": ["./fixtures/"]
  },
  "exclude": ["node_modules/", "dist/"],
  "nodeModulesDir": "auto",
  "lock": true
}
```

## Node/npm Compatibility

```bash
deno run --node-modules-dir=auto main.ts   # create node_modules
deno install --node-modules-dir=auto       # install with node_modules
```

Deno supports `package.json`, `node_modules`, and most Node built-in modules via `node:` specifiers:

```typescript
import { readFile } from "node:fs/promises";
import express from "npm:express";
```

## Environment Variables

```bash
deno run --env=.env file.ts          # load .env file
```

| Variable | Description |
|----------|-------------|
| `DENO_DIR` | Cache directory |
| `DENO_INSTALL_ROOT` | Where `deno install` puts binaries |
| `DENO_AUTH_TOKENS` | Auth tokens for private registries |
| `DENO_CERT` | Custom CA certificate |
| `DENO_TLS_CA_STORE` | TLS CA store (`mozilla` or `system`) |
| `NO_COLOR` | Disable color output |

## Useful Flags

| Flag | Description |
|------|-------------|
| `--watch` | Watch for file changes and restart |
| `--inspect` | Enable V8 inspector (debugger) |
| `--inspect-brk` | Enable inspector and break on start |
| `--no-check` | Skip type checking |
| `--cached-only` | Fail if not in cache (offline mode) |
| `--lock=deno.lock` | Check against lockfile |
| `--config=deno.json` | Specify config file |
| `--no-config` | Ignore config file |
| `--quiet` / `-q` | Suppress non-error output |
| `--unstable-*` | Enable unstable APIs (e.g., `--unstable-kv`) |

## Global Install

```bash
deno install -g --allow-net --name myutil https://example.com/cli.ts
deno uninstall -g myutil
```
