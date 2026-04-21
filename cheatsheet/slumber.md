# Slumber Cheatsheet

Terminal-based HTTP client with a TUI interface. Define request collections in YAML, manage environments/profiles, and send requests interactively.

## Getting Started

```bash
slumber                           # Open TUI (looks for slumber.yml in cwd)
slumber -f path/to/collection.yml # Open specific collection file
slumber collections path          # Show default collection path
slumber generate curl "curl ..."  # Generate collection from a curl command
slumber generate openapi spec.yml # Generate collection from OpenAPI spec
```

## Collection File Format (YAML)

```yaml
# slumber.yml
profiles:
  local:
    name: Local Dev
    data:
      host: http://localhost:8000
      token: dev-token-123
  staging:
    name: Staging
    data:
      host: https://staging.api.example.com
      token: stg-token-456

chains:
  auth_token:
    source: !request
      recipe: login
    selector: $.token

requests:
  login:
    name: Login
    method: POST
    url: "{{host}}/auth/login"
    headers:
      Content-Type: application/json
    body: !json
      username: admin
      password: secret

  get_items:
    name: Get Items
    method: GET
    url: "{{host}}/api/items"
    headers:
      Authorization: "Bearer {{chains.auth_token}}"
    query:
      - page=1
      - limit=20

  create_item:
    name: Create Item
    method: POST
    url: "{{host}}/api/items"
    headers:
      Authorization: "Bearer {{token}}"
      Content-Type: application/json
    body: !json
      name: New Item
      active: true

  upload_file:
    name: Upload File
    method: POST
    url: "{{host}}/api/upload"
    body: !file ./data/payload.bin
```

## Template Syntax

| Syntax                       | Description                                |
|------------------------------|--------------------------------------------|
| `{{field}}`                  | Profile data value                         |
| `{{chains.chain_id}}`       | Value from a chain                         |
| `{{env.VAR}}`               | Environment variable                       |

## Chain Sources

```yaml
chains:
  from_request:
    source: !request
      recipe: login           # Extract from another request's response
    selector: $.token         # JSONPath selector

  from_command:
    source: !command
      command: ["echo", "hello"]  # Run shell command

  from_file:
    source: !file
      path: ./token.txt       # Read from file

  from_prompt:
    source: !prompt
      message: "Enter API key"  # Prompt user at runtime
```

## Body Types

```yaml
body: !json { "key": "value" }    # JSON body
body: !form_urlencoded            # Form data
  key: value
body: !form_multipart             # Multipart form
  file: !file ./upload.txt
body: !raw "plain text body"      # Raw string
body: !file ./payload.bin         # Binary file
```

## Key Bindings

### Global

| Key         | Action                          |
|-------------|---------------------------------|
| `q`         | Quit                            |
| `?`         | Show help / key bindings        |
| `Tab`       | Cycle focus between panes       |
| `Shift+Tab` | Cycle focus reverse             |
| `f`         | Toggle fullscreen on pane       |

### Request List (left pane)

| Key         | Action                          |
|-------------|---------------------------------|
| `j`/`k`     | Move down / up                  |
| `Enter`     | Select request                  |
| `/`         | Search/filter requests          |

### Request / Response Pane

| Key         | Action                          |
|-------------|---------------------------------|
| `Enter`     | Send selected request           |
| `p`         | Switch profile                  |
| `j`/`k`     | Scroll down / up                |
| `y`         | Copy response body to clipboard |
| `s`         | Save response body to file      |
| `e`         | Open request in editor          |

### Response Viewing

| Key         | Action                          |
|-------------|---------------------------------|
| `h`         | View response headers           |
| `b`         | View response body              |
| `1`/`2`/`3` | Switch response tabs           |

## CLI Request Mode

```bash
slumber request --profile local get_items          # Send request non-interactively
slumber request -f coll.yml --profile staging login # With specific collection
slumber show --profile local get_items             # Preview request without sending
```

## Tips

- Collection files are auto-reloaded on save -- edit in another terminal and slumber updates.
- Use `chains` to build dynamic workflows (e.g., login then use token for subsequent requests).
- Profiles let you switch between environments (local, staging, prod) with a single keypress.
- The `!request` chain source enables dependent request chaining automatically.
