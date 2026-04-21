# uv Cheatsheet

An extremely fast Python package and project manager, written in Rust. Replaces pip, pip-tools, virtualenv, and more.

---

## Project Management

```bash
uv init                      # create new project (pyproject.toml)
uv init --lib                # create library project
uv init --app                # create application project
uv init --python 3.12        # init with specific Python version
```

### Dependencies

```bash
uv add requests              # add dependency
uv add "requests>=2.28"      # add with version constraint
uv add --dev pytest          # add dev dependency
uv add --group lint ruff     # add to named dependency group
uv add --optional ml numpy   # add to optional dependency group
uv remove requests           # remove dependency
uv lock                      # update lockfile (uv.lock)
uv sync                      # sync environment with lockfile
uv sync --frozen             # sync without updating lockfile
uv sync --no-dev             # sync production deps only
uv tree                      # show dependency tree
```

### Running

```bash
uv run script.py             # run with project environment
uv run python -c "print(1)"  # run any command in project env
uv run pytest                # run project tools
uv run --with httpx script.py  # run with extra ephemeral dep
uv run --python 3.12 script.py  # run with specific Python
```

## Virtual Environments

```bash
uv venv                      # create .venv in current dir
uv venv myenv                # create named venv
uv venv --python 3.12        # create with specific Python
uv venv --python pypy        # create with PyPy
source .venv/bin/activate    # activate (standard, not a uv command)
```

## pip Interface

Drop-in replacements for pip and pip-tools commands:

```bash
uv pip install requests              # install package
uv pip install -r requirements.txt   # install from requirements
uv pip install -e ".[dev]"           # editable install with extras
uv pip install --upgrade requests    # upgrade package
uv pip uninstall requests            # uninstall package
uv pip list                          # list installed packages
uv pip show requests                 # show package details
uv pip freeze                        # output installed packages
uv pip check                         # check for conflicts
```

### pip-tools Style (compile/sync)

```bash
uv pip compile requirements.in -o requirements.txt   # resolve & lock
uv pip compile pyproject.toml -o requirements.txt     # from pyproject
uv pip compile --upgrade requirements.in              # upgrade all
uv pip compile --upgrade-package requests requirements.in  # upgrade one
uv pip sync requirements.txt         # sync env to match exactly
```

## Python Management

```bash
uv python install                    # install latest Python
uv python install 3.12               # install specific version
uv python install 3.11 3.12          # install multiple
uv python list                       # list available Pythons
uv python list --only-installed      # list installed only
uv python find 3.12                  # find a Python installation
uv python pin 3.12                   # pin version for project (.python-version)
uv python uninstall 3.11             # remove installed Python
```

## Tool Management

Install and run Python CLI tools in isolated environments:

```bash
uv tool install ruff                 # install tool globally
uv tool install --python 3.12 ruff   # install with specific Python
uv tool install "ruff>=0.4"          # install with version constraint
uv tool run ruff check .             # run without installing (ephemeral)
uv tool run --from "black" black .   # explicit package name
uv tool list                         # list installed tools
uv tool upgrade ruff                 # upgrade a tool
uv tool upgrade --all                # upgrade all tools
uv tool uninstall ruff               # remove tool
uv tool dir                          # show tool install directory
```

Shorthand: `uvx` is equivalent to `uv tool run`:

```bash
uvx ruff check .                     # same as uv tool run ruff check .
uvx black --check .
uvx --from "httpie" http GET example.com
```

## Inline Script Metadata

For standalone scripts with dependencies:

```python
# /// script
# requires-python = ">=3.12"
# dependencies = ["requests", "rich"]
# ///

import requests
from rich import print
print(requests.get("https://example.com").status_code)
```

```bash
uv run script.py             # auto-installs script dependencies
uv add --script script.py requests   # add dep to script metadata
```

## Key Flags

| Flag | Description |
|------|-------------|
| `--python VERSION` | Specify Python version |
| `--frozen` | Don't update lockfile |
| `--locked` | Require lockfile is up to date |
| `--no-cache` | Disable cache |
| `--refresh` | Refresh cached data |
| `--offline` | Disable network access |
| `--index-url URL` | Custom package index |
| `--extra-index-url URL` | Additional package index |
| `--find-links DIR` | Find packages in directory |
| `--no-build-isolation` | Disable build isolation |
| `--verbose` / `-v` | Verbose output |
| `--quiet` / `-q` | Quiet output |
| `--color auto/always/never` | Color output |
| `--native-tls` | Use system TLS instead of rustls |

## Configuration

### pyproject.toml

```toml
[project]
name = "my-project"
version = "0.1.0"
requires-python = ">=3.12"
dependencies = ["requests>=2.28"]

[project.optional-dependencies]
dev = ["pytest", "ruff"]

[tool.uv]
dev-dependencies = ["pytest>=8.0"]

[tool.uv.sources]
my-lib = { git = "https://github.com/user/my-lib" }
```

### uv.toml (standalone config)

```toml
[pip]
index-url = "https://pypi.example.com/simple"

[tool]
python = "3.12"
```

## Environment Variables

| Variable | Description |
|----------|-------------|
| `UV_PYTHON` | Default Python version |
| `UV_CACHE_DIR` | Cache directory |
| `UV_INDEX_URL` | Default index URL |
| `UV_EXTRA_INDEX_URL` | Additional index URLs |
| `UV_DEFAULT_INDEX` | Default index |
| `UV_LINK_MODE` | `copy`, `hardlink`, or `symlink` |
| `UV_NO_CACHE` | Disable caching |
| `UV_PYTHON_PREFERENCE` | `managed-only`, `system`, `only-system` |
| `UV_TOOL_DIR` | Tool installation directory |
| `UV_TOOL_BIN_DIR` | Tool binary directory |

## Cache

```bash
uv cache clean               # clear all caches
uv cache prune               # remove unused cache entries
uv cache dir                 # show cache directory
```
