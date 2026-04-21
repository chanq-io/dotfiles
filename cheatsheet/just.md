# Just Cheatsheet

A handy command runner alternative to `make`. Justfiles are simpler, more portable, and purpose-built for running project commands.

---

## CLI Flags

| Flag | Description |
|------|-------------|
| `just` | Run the default recipe |
| `just <recipe> [args]` | Run a specific recipe |
| `just --list` | List available recipes with descriptions |
| `just --list --unsorted` | List recipes in file order |
| `just --summary` | One-line list of recipe names |
| `just --dry-run <recipe>` | Print commands without executing |
| `just --evaluate` | Evaluate and print all variables |
| `just --evaluate <var>` | Print a single variable's value |
| `just --dump` | Print the entire justfile |
| `just --dump --format json` | Dump justfile as JSON |
| `just --fmt` | Format the justfile |
| `just --fmt --check` | Check formatting (CI-friendly) |
| `just --choose` | Select recipe interactively (requires fzf) |
| `just --chooser "fzf --preview='just --show {}'"` | Custom chooser command |
| `just --show <recipe>` | Print a single recipe |
| `just --justfile <path>` | Use a specific justfile |
| `just --working-directory <dir>` | Set working directory |
| `just --set <var> <val>` | Override a variable |
| `just --dotenv-filename .env.local` | Use a custom env file |
| `just --dotenv-path /path/.env` | Absolute path to env file |
| `just --verbose` | Show commands and output |
| `just --quiet` | Suppress echoed commands |
| `just --yes` | Confirm all prompts automatically |
| `just --timestamp` | Show timestamps on output |
| `just --no-highlight` | Disable syntax highlighting of errors |
| `just --completions <shell>` | Generate shell completions (bash/zsh/fish) |

---

## Justfile Syntax

### Basic Recipes

```just
# A comment describing the recipe
build:
    cargo build --release

# Recipe with description (shown in --list)
# Run the test suite
test:
    cargo test

# Multiple commands (each line runs in its own shell)
deploy:
    cargo build --release
    scp target/release/app server:/opt/
    ssh server 'systemctl restart app'
```

### Default Recipe

```just
# The first recipe is the default, or name one explicitly:
default:
    @just --list

# Or set an alias
default: build
```

### Recipe Arguments

```just
# Positional arguments
greet name:
    echo "Hello, {{name}}!"

# With default values
serve port="8080":
    python -m http.server {{port}}

# Variadic arguments (one or more)
test +files:
    cargo test {{files}}

# Variadic arguments (zero or more)
lint *flags:
    clippy {{flags}}

# Environment variable arguments
build $RUST_LOG="info":
    cargo build
```

### Dependencies

```just
# Recipe depends on another
build: check
    cargo build

# Multiple dependencies
deploy: build test
    ./deploy.sh

# Dependencies with arguments
push version: (build version) (tag version)
    git push

build version:
    cargo build --features={{version}}

tag version:
    git tag {{version}}

# Run dependency after the recipe
deploy: && notify
    ./deploy.sh

notify:
    echo "Deploy done!"
```

### Variables & Expressions

```just
# Simple variables
version := "1.0.0"
target  := "x86_64-unknown-linux-gnu"

# Backtick expressions (shell command output)
git_hash := `git rev-parse --short HEAD`
date     := `date +%Y-%m-%d`

# Concatenation
binary := "myapp-" + version

# Conditionals
mode := if env("CI", "") != "" { "release" } else { "debug" }

# Path functions
project_root := justfile_directory()
config_path  := join(project_root, "config")
```

### Built-in Functions

| Function | Description |
|----------|-------------|
| `os()` | Operating system: `"linux"`, `"macos"`, `"windows"` |
| `os_family()` | OS family: `"unix"`, `"windows"` |
| `arch()` | CPU architecture: `"x86_64"`, `"aarch64"` |
| `num_cpus()` | Number of logical CPUs |
| `env("KEY")` | Get env var (error if unset) |
| `env("KEY", "default")` | Get env var with fallback |
| `env_var("KEY")` | Alias for `env("KEY")` |
| `env_var_or_default("KEY", "val")` | Alias with default |
| `invocation_directory()` | Dir where `just` was called from |
| `invocation_directory_native()` | Same, with native path separators |
| `justfile()` | Absolute path to the justfile |
| `justfile_directory()` | Directory containing the justfile |
| `just_executable()` | Path to the just binary |
| `just_pid()` | PID of the just process |
| `uuid()` | Generate a random UUID |
| `sha256("string")` | SHA-256 hash |
| `sha256_file("path")` | SHA-256 of a file |
| `blake3("string")` | BLAKE3 hash |
| `blake3_file("path")` | BLAKE3 of a file |

### String Functions

| Function | Description |
|----------|-------------|
| `uppercase(s)` | Convert to uppercase |
| `lowercase(s)` | Convert to lowercase |
| `trim(s)` | Trim whitespace |
| `trim_start(s)` | Trim leading whitespace |
| `trim_end(s)` | Trim trailing whitespace |
| `trim_start_match(s, pat)` | Trim prefix |
| `trim_end_match(s, pat)` | Trim suffix |
| `replace(s, from, to)` | Replace substring |
| `replace_regex(s, regex, to)` | Replace with regex |
| `quote(s)` | Shell-quote a string |
| `join(a, b)` | Join paths |
| `clean(path)` | Normalize a path |
| `absolute_path(path)` | Make path absolute |
| `extension(path)` | File extension |
| `file_name(path)` | Filename |
| `file_stem(path)` | Filename without extension |
| `parent_directory(path)` | Parent directory |
| `without_extension(path)` | Path without extension |

### OS Detection

```just
# Conditional per OS
install:
    #!/usr/bin/env bash
    if [[ "{{os()}}" == "macos" ]]; then
        brew install myapp
    elif [[ "{{os()}}" == "linux" ]]; then
        sudo apt install myapp
    fi

# Or use conditional assignment
linker := if os() == "linux" { "mold" } else { "lld" }

# Per-OS recipes
[linux]
install:
    sudo apt install myapp

[macos]
install:
    brew install myapp

[windows]
install:
    choco install myapp
```

### Environment Variables & Dotenv

```just
# Set env vars for recipes
export DATABASE_URL := "postgres://localhost/mydb"

# Load .env file automatically
set dotenv-load

# Or specify a custom env file
set dotenv-filename := ".env.local"
set dotenv-path := "/absolute/path/.env"

# Per-recipe env var
build $RUST_LOG="debug":
    cargo build
```

### Settings

```just
# Use a specific shell
set shell := ["bash", "-euo", "pipefail", "-c"]

# Windows-specific shell
set windows-shell := ["powershell.exe", "-NoLogo", "-Command"]

# Allow positional arguments as $1, $2, etc.
set positional-arguments

# Don't print recipe lines before executing
set quiet

# Error if using undefined variables
set allow-duplicate-recipes

# Export all variables as environment variables
set export

# Change working directory for recipes
set working-directory := "subdir"

# Fail fast on errors
set fallback  # search parent dirs for justfile
```

### Recipe Attributes

```just
# Hide from --list
[private]
_helper:
    echo "internal"

# Confirm before running
[confirm]
deploy:
    ./deploy.sh

# Custom confirmation message
[confirm("Are you sure you want to delete everything?")]
clean:
    rm -rf build/

# Don't fail if command fails
[allow-warnings]
lint:
    clippy

# Run recipe in a specific directory
[working-directory("frontend")]
build-ui:
    npm run build

# OS-specific recipes
[linux]
install-deps:
    sudo apt install build-essential

[macos]
install-deps:
    xcode-select --install

# Mark as no-cd (don't change to justfile dir)
[no-cd]
run:
    echo "Running from {{invocation_directory()}}"

# Require specific tools to be in PATH
[script("python3")]
analyze:
    import json
    print(json.dumps({"status": "ok"}))
```

### Shebang Recipes

```just
# Use any interpreter
polyglot:
    #!/usr/bin/env python3
    import sys
    print(f"Python {sys.version}")

node-task:
    #!/usr/bin/env node
    console.log("Hello from Node!")

multi-line-bash:
    #!/usr/bin/env bash
    set -euo pipefail
    for f in *.txt; do
        echo "Processing $f"
    done
```

### Conditional Expressions

```just
# If/else
mode := if env("CI", "") != "" { "release" } else { "debug" }

# Regex match
greeting := if "hello" =~ "hel.*" { "matched" } else { "no match" }

# Use in recipes
build:
    cargo build {{ if mode == "release" { "--release" } else { "" } }}
```

### Error Handling

```just
# Prefix a line with '-' to ignore errors
clean:
    -rm -rf build/
    -rm -rf dist/
    echo "cleaned"

# Prefix with '@' to suppress echoing
setup:
    @echo "Setting up..."
    @mkdir -p build

# Combine: don't echo, ignore errors
teardown:
    -@rm -rf tmp/
```

---

## Imports & Modules

```just
# Import another justfile
import "tasks/build.just"
import? "local.just"  # optional import (no error if missing)

# Modules (namespaced)
mod build
mod deploy "ops/deploy.just"

# Usage: just build::compile, just deploy::production
```

---

## Practical Examples

```just
set dotenv-load
set shell := ["bash", "-euo", "pipefail", "-c"]

default:
    @just --list

version := `git describe --tags --always --dirty 2>/dev/null || echo "dev"`

# Build the application
build *args:
    cargo build {{args}}

# Build for release
release: (build "--release")

# Run the test suite
test *args:
    cargo test {{args}}

# Run lints
lint:
    cargo clippy -- -D warnings
    cargo fmt --check

# Format code
fmt:
    cargo fmt
    just --fmt --unstable

# Start dev server
dev port="3000":
    cargo watch -x "run -- --port {{port}}"

# Create a new release
[confirm("Create release {{version}}. Continue?")]
tag:
    git tag -a "{{version}}" -m "Release {{version}}"
    git push origin "{{version}}"

# Remove build artifacts
clean:
    cargo clean
    -rm -rf dist/

# Print project info
info:
    @echo "Version: {{version}}"
    @echo "OS:      {{os()}} / {{arch()}}"
    @echo "CPUs:    {{num_cpus()}}"
```
