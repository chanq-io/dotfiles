# HTTPie Cheatsheet

Command-line HTTP client for humans. Uses `http` and `https` commands with intuitive syntax.

## Basic Requests

```bash
http GET https://api.example.com/items          # GET (default if no data)
http POST https://api.example.com/items         # POST
http PUT https://api.example.com/items/1        # PUT
http PATCH https://api.example.com/items/1      # PATCH
http DELETE https://api.example.com/items/1     # DELETE
http HEAD https://api.example.com/items         # HEAD
http OPTIONS https://api.example.com/items      # OPTIONS
```

## Request Data

### JSON (default for POST/PUT/PATCH)

```bash
http POST :8000/api name=John age:=30           # String and non-string fields
http POST :8000/api tags:='["a","b"]'           # Raw JSON value
http POST :8000/api data:=@file.json            # JSON from file
http POST :8000/api < payload.json              # Redirect stdin as body
```

| Syntax     | Meaning                          |
|------------|----------------------------------|
| `key=val`  | String field: `{"key": "val"}`   |
| `key:=val` | Non-string JSON: `{"key": val}`  |
| `key:=@f`  | JSON value from file             |
| `key=@f`   | String value from file           |

### Form Data

```bash
http -f POST :8000/login user=admin pass=secret     # application/x-www-form-urlencoded
http -f POST :8000/upload file@photo.jpg             # multipart/form-data (auto)
http -f POST :8000/upload file@photo.jpg;type=image/jpeg  # explicit MIME type
```

## Headers

```bash
http :8000/api X-API-Key:abc123                 # Custom header
http :8000/api Accept:application/xml           # Override default
http :8000/api Authorization:"Bearer tok123"    # Auth header manually
http :8000/api Header:                          # Unset/empty header
```

## Authentication

```bash
http -a user:pass :8000/api                     # Basic auth
http -A bearer -a tok123 :8000/api              # Bearer token
http -A digest -a user:pass :8000/api           # Digest auth
http --auth-type=bearer --auth=tok123 :8000/api # Long form
```

## Sessions

```bash
http --session=mysess -a user:pass :8000/login  # Create named session (saves cookies, auth)
http --session=mysess :8000/dashboard           # Reuse session
http --session=/tmp/sess.json :8000/api         # Session file at path
http --session-read-only=mysess :8000/api       # Read session but don't update it
```

## Output Control

| Flag             | Description                                       |
|------------------|---------------------------------------------------|
| `--print=HhBb`  | What to print: H=req headers, B=req body, h=resp headers, b=resp body |
| `--print=hb`    | Response headers + body (default)                 |
| `--print=HB`    | Request headers + body                            |
| `--headers`/`-h`| Print only response headers (`--print=h`)         |
| `--body`/`-b`   | Print only response body (`--print=b`)            |
| `--verbose`/`-v`| Print full request and response (`--print=HhBb`)  |
| `--style=monokai`| Syntax highlight theme                            |
| `--pretty=all`  | Format + color (default for terminal)             |
| `--pretty=none` | No formatting, no color                           |

```bash
http --print=Hh :8000/api                       # Request + response headers only
http -v POST :8000/api name=test                 # Full verbose output
http --style=fruity :8000/api                    # Different color theme
```

## Download

```bash
http --download :8000/file.zip                   # Download with progress bar
http -d :8000/file.zip -o out.zip                # Download to specific file
http --download --output=dir/ :8000/file.zip     # Download to directory
```

## Key Flags

| Flag                   | Description                              |
|------------------------|------------------------------------------|
| `--verify=no`          | Skip SSL certificate verification        |
| `--ssl=tls1.2`        | Force specific SSL version               |
| `--cert=file`         | Client-side SSL certificate              |
| `--timeout=30`        | Request timeout in seconds (default 30)  |
| `--follow`/`-F`       | Follow redirects                         |
| `--max-redirects=5`   | Max number of redirects to follow        |
| `--output=FILE`/`-o`  | Write output to file                     |
| `--check-status`      | Exit with error on 4xx/5xx              |
| `--ignore-stdin`      | Do not read stdin                        |
| `--offline`           | Build request but don't send             |
| `--default-scheme=https` | Default scheme when omitted           |
| `--proxy=http:socks5://localhost:9050` | Proxy configuration      |
| `--compress`/`-x`     | Request gzip compressed response         |

## URL Shortcuts

```bash
http :8000/api                    # http://localhost:8000/api
http :/api                        # http://localhost/api
http example.com                  # http://example.com
https example.com                 # https://example.com
```

## Piping and Scripting

```bash
http :8000/api | jq .data                  # Pipe JSON to jq
echo '{"name":"x"}' | http POST :8000/api  # Pipe body from stdin
http -b :8000/api > response.json          # Save body to file
http --check-status :8000/health || echo "down"  # Health check script
```
