# xh Cheatsheet

Fast HTTP client written in Rust. Mostly compatible with HTTPie syntax but faster and with some extra features.

## Key Differences from HTTPie

| Feature              | xh                                    | HTTPie                        |
|----------------------|---------------------------------------|-------------------------------|
| Speed                | Significantly faster (Rust)           | Python                        |
| Default HTTPS        | `xh example.com` uses HTTPS           | `http` uses HTTP              |
| Commands             | `xh` (HTTPS) / `xhs` (HTTPS alias)   | `http` / `https`              |
| `--curl` flag        | Print equivalent curl command          | Not available                 |
| `--offline` flag     | Build and print request, don't send   | Available too                 |
| Nested JSON          | Supported natively                    | Requires plugin               |
| Request body from CLI| Same `key=val` / `key:=val` syntax    | Same                          |
| Sessions             | Compatible with HTTPie sessions       | Yes                           |
| Config               | Not supported                         | `~/.httpie/config.json`       |

## Basic Requests

```bash
xh GET https://api.example.com/items
xh POST https://api.example.com/items name=John age:=30
xh PUT https://api.example.com/items/1 name=Updated
xh PATCH https://api.example.com/items/1 status=active
xh DELETE https://api.example.com/items/1
xh :8000/api                              # GET https://localhost:8000/api
```

## Request Data

```bash
xh POST :8000/api name=John age:=30               # JSON (default)
xh POST :8000/api tags:='["a","b"]'                # Raw JSON
xh -f POST :8000/login user=admin pass=secret      # Form data
xh -f POST :8000/upload file@photo.jpg             # File upload (multipart)
xh POST :8000/api < payload.json                   # Body from stdin
```

### Nested JSON (xh-specific)

```bash
xh POST :8000/api user[name]=John user[age]:=30    # {"user": {"name": "John", "age": 30}}
xh POST :8000/api items[0]=first items[1]=second   # {"items": ["first", "second"]}
```

## Headers and Auth

```bash
xh :8000/api X-API-Key:abc123                      # Custom header
xh -a user:pass :8000/api                          # Basic auth
xh -A bearer -a tok123 :8000/api                   # Bearer token
xh -A digest -a user:pass :8000/api                # Digest auth
```

## Output Control

| Flag             | Description                                              |
|------------------|----------------------------------------------------------|
| `--print=HhBb`  | H=req headers, B=req body, h=resp headers, b=resp body  |
| `-v`/`--verbose` | Print full request + response                           |
| `-h`/`--headers` | Response headers only                                   |
| `-b`/`--body`    | Response body only                                      |
| `-m`/`--meta`    | Show response metadata (timing, size)                   |
| `--style=THEME`  | Color theme (monokai, solarized, etc.)                  |
| `--pretty=all`   | Format + color                                          |
| `--pretty=none`  | Raw output, no color                                    |
| `--response-charset=utf-8` | Force response encoding                      |

## Offline Mode and Curl Output

```bash
xh --offline POST :8000/api name=test              # Print request without sending
xh --curl POST :8000/api name=test X-Key:abc       # Print equivalent curl command
xh --curl -a user:pass :8000/api                   # Curl output with auth
```

Example `--curl` output:
```
curl -X POST -H 'Content-Type: application/json' -d '{"name":"test"}' -H 'X-Key: abc' https://localhost:8000/api
```

## Key Flags

| Flag                    | Description                             |
|-------------------------|-----------------------------------------|
| `--verify=no`           | Skip SSL verification                  |
| `--cert=FILE`           | Client SSL certificate                 |
| `--timeout=SECONDS`     | Request timeout                        |
| `-F`/`--follow`         | Follow redirects                       |
| `--max-redirects=N`     | Limit redirects                        |
| `-o`/`--output=FILE`    | Write response to file                 |
| `-d`/`--download`       | Download with progress bar             |
| `--check-status`        | Exit with error on 4xx/5xx            |
| `--proxy=http:URL`      | Set proxy                              |
| `-x`/`--compress`       | Request compressed response            |
| `--https`               | Force HTTPS                            |
| `--http-version=2`      | Use HTTP/2                             |
| `--ignore-stdin`        | Don't read stdin                       |
| `--default-scheme=http` | Override default scheme                |
| `--raw=BODY`            | Raw request body string                |

## Sessions

```bash
xh --session=mysess -a user:pass :8000/login       # Create session
xh --session=mysess :8000/dashboard                 # Reuse session
xh --session-read-only=mysess :8000/api             # Read-only session
```

## Piping and Scripting

```bash
xh -b :8000/api | jq .data                         # Pipe to jq
xh --check-status :8000/health || echo "down"       # Health check
xh -b :8000/items > items.json                      # Save response body
```
