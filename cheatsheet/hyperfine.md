# hyperfine

Statistical command-line benchmarking: warmup runs, outlier detection, and side-by-side comparison.

---

## Usage

```bash
hyperfine 'fd -e rs'                        # benchmark one command
hyperfine 'fd -e rs' 'find . -name "*.rs"'  # compare two (relative speed summary)
hyperfine --warmup 3 'rg TODO'              # warm caches first (I/O-heavy commands)
hyperfine --runs 20 './my-script.sh'        # fixed number of runs (default: auto ≥10)
hyperfine --min-runs 5 'cargo build'        # lower bound on runs for slow commands
```

## Setup / Teardown

| Flag | Effect |
|------|--------|
| `--prepare <cmd>` | Run before *each* timing run (e.g. `sync; purge caches`, `make clean`) |
| `--setup <cmd>` | Run once before benchmark |
| `--cleanup <cmd>` | Run once after benchmark |
| `--conclude <cmd>` | Run after each timing run |

```bash
hyperfine --prepare 'cargo clean' 'cargo build'     # cold-build benchmark
```

## Parameter Scans

```bash
hyperfine -P threads 1 8 'make -j {threads}'        # numeric sweep
hyperfine -L compiler gcc,clang '{compiler} -O2 main.c'  # list of values
```

## Output / Export

| Flag | Effect |
|------|--------|
| `--export-markdown out.md` | Results table for READMEs/PRs |
| `--export-json out.json` | Full run data (feeds the plotting scripts in hyperfine repo) |
| `--export-csv out.csv` | CSV |
| `-n <name>` | Human-readable name per command (repeat per command) |
| `--show-output` | Don't capture command output |
| `-N` | No intermediate shell — for very fast (<5ms) commands |
| `-i` | Ignore non-zero exit codes |

## Notes

- Commands run through a shell by default; hyperfine measures and subtracts shell startup. Use `-N` when benchmarking sub-5ms commands to reduce noise.
- Warnings about outliers usually mean caching effects — add `--warmup` (warm) or `--prepare` (cold) to make runs uniform.
