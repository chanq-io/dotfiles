# Cargo & Rustup Cheatsheet

Rust's package manager, build system, and toolchain manager.

---

## Project Setup

```bash
cargo new myproject          # create binary project with git
cargo new --lib mylib        # create library project
cargo init                   # init in current directory
cargo init --lib             # init as library in current dir
```

## Build & Run

| Command | Description |
|---------|-------------|
| `cargo build` | Build debug |
| `cargo build --release` | Build optimized release |
| `cargo run` | Build and run |
| `cargo run -- args` | Run with arguments |
| `cargo run --example name` | Run a specific example |
| `cargo run --bin name` | Run a specific binary |
| `cargo check` | Type-check without building (fast) |
| `cargo clean` | Remove target/ directory |

### Key Build Flags

| Flag | Description |
|------|-------------|
| `--release` | Optimized build |
| `--features "f1,f2"` | Enable features |
| `--all-features` | Enable all features |
| `--no-default-features` | Disable default features |
| `--target triple` | Cross-compile (e.g., `x86_64-unknown-linux-musl`) |
| `--jobs N` / `-j N` | Parallel jobs |
| `--verbose` / `-v` | Verbose output |
| `--timings` | Show build timing report |
| `-p package` | Select workspace package |

## Testing & Benchmarking

```bash
cargo test                    # run all tests
cargo test test_name          # run tests matching name
cargo test -- --nocapture     # show println! output
cargo test -- --test-threads=1  # single-threaded tests
cargo test --doc              # run doc-tests only
cargo test -p crate_name     # test specific crate
cargo bench                   # run benchmarks
cargo bench bench_name        # run specific benchmark
```

## Code Quality

```bash
cargo clippy                  # run linter
cargo clippy --fix            # auto-fix lint warnings
cargo clippy -- -W clippy::pedantic   # stricter lints
cargo fmt                     # format all code
cargo fmt --check             # check formatting without changing
cargo fmt -- --config max_width=100   # custom config
```

## Dependencies

```bash
cargo add serde               # add dependency
cargo add serde --features derive    # add with features
cargo add tokio@1.0           # add specific version
cargo add --dev pretty_assertions    # add dev dependency
cargo add --build cc          # add build dependency
cargo remove serde            # remove dependency
cargo update                  # update all deps within semver
cargo update -p serde         # update specific crate
cargo tree                    # show dependency tree
cargo tree -d                 # show duplicated deps
cargo tree -i serde           # show what depends on serde
```

## Documentation

```bash
cargo doc                     # build docs
cargo doc --open              # build and open in browser
cargo doc --no-deps           # skip dependency docs
cargo doc --document-private-items   # include private items
```

## Publishing

```bash
cargo login                   # authenticate with crates.io
cargo publish                 # publish to crates.io
cargo publish --dry-run       # test publish without uploading
cargo package                 # create distributable tarball
cargo yank --version 1.0.0    # yank a published version
cargo owner --add user        # add crate owner
```

## Installing Binaries

```bash
cargo install ripgrep         # install from crates.io
cargo install --path .        # install from local path
cargo install --git url       # install from git
cargo install --list          # list installed binaries
cargo uninstall ripgrep       # remove installed binary
```

## Cargo Watch (requires cargo-watch)

```bash
cargo watch                         # re-run cargo check on changes
cargo watch -x run                  # re-run on changes
cargo watch -x test                 # re-test on changes
cargo watch -x "test -- --nocapture"  # with args
cargo watch -x clippy               # re-lint on changes
cargo watch -s "cargo build && cargo test"  # chain commands
cargo watch -w src -x run           # watch specific dir only
cargo watch --clear                 # clear screen between runs
```

## Workspaces

In root `Cargo.toml`:

```toml
[workspace]
members = ["crate_a", "crate_b"]
```

```bash
cargo build -p crate_a        # build specific member
cargo test --workspace         # test all members
cargo run -p crate_a           # run specific member
```

## Useful Cargo Subcommands (install separately)

| Command | Description |
|---------|-------------|
| `cargo expand` | Expand macros |
| `cargo audit` | Check for vulnerable deps |
| `cargo deny` | Lint dependency graph |
| `cargo outdated` | Show outdated deps |
| `cargo bloat` | Find what takes space in binary |
| `cargo flamegraph` | Generate flamegraphs |
| `cargo nextest run` | Faster test runner |
| `cargo llvm-cov` | Code coverage |
| `cargo criterion` | Better benchmarking |

---

## Rustup

### Toolchain Management

```bash
rustup show                   # show installed toolchains & active
rustup update                 # update all toolchains
rustup update stable          # update specific toolchain
rustup default stable         # set default toolchain
rustup default nightly        # switch to nightly
rustup override set nightly   # set override for current dir
rustup override unset         # remove directory override
```

### Targets

```bash
rustup target list            # list available targets
rustup target list --installed  # list installed targets
rustup target add wasm32-unknown-unknown       # add target
rustup target add x86_64-unknown-linux-musl    # add musl target
rustup target remove TARGET   # remove a target
```

### Components

```bash
rustup component list         # list available components
rustup component add rust-src             # add Rust source
rustup component add rust-analyzer        # add rust-analyzer
rustup component add clippy               # add clippy
rustup component add rustfmt              # add rustfmt
rustup component add llvm-tools-preview   # add llvm tools
rustup component remove COMPONENT         # remove component
```

### Other Commands

```bash
rustup doc                    # open Rust documentation
rustup doc --std              # open std library docs
rustup run nightly cargo build    # run command with specific toolchain
cargo +nightly build              # shorthand for above
rustup self update            # update rustup itself
rustup which rustc            # show path to active rustc
rustc --version               # show compiler version
rustc --print target-list     # list all supported targets
```
