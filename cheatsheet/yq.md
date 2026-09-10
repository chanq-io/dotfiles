# yq (yq-go)

jq-style processor for YAML, JSON, TOML, XML, CSV, and .properties. This is the Go implementation (`mikefarah/yq`), not the Python wrapper.

---

## Basics

```bash
yq '.spec.replicas' deploy.yaml         # read a value
yq '.metadata.name' *.yaml              # across multiple files
yq -i '.spec.replicas = 3' deploy.yaml  # edit in place
yq '.a.b[0].c' file.yaml                # array indexing
yq '.users[].name' file.yaml            # iterate arrays
cat file.yaml | yq '.foo'               # stdin works too
```

## Format Conversion

`-p` sets input format, `-o` output format (`yaml`, `json`, `xml`, `toml`, `csv`, `tsv`, `props`).

```bash
yq -o json file.yaml                    # YAML → JSON
yq -p json -o yaml file.json            # JSON → YAML
yq -p toml -o json Cargo.toml           # TOML → JSON
yq -p xml '.root.item' file.xml         # query XML
yq -o json -I 0 file.yaml               # compact (indent 0) JSON
```

## Common Operations

| Expression | Effect |
|------------|--------|
| `.a.b \| length` | Length of array/map/string |
| `.items[] \| select(.name == "x")` | Filter |
| `.items[] \| .name` | Map/extract |
| `. \| keys` | Keys of a map |
| `.a.b = "v"` | Set value |
| `.a.b \|= upcase` | Update using current value |
| `del(.a.b)` | Delete key |
| `.a += {"new": "entry"}` | Merge into map |
| `.items += ["x"]` | Append to array |
| `... comments=""` | Strip all comments |
| `sort_by(.name)` | Sort array of objects |
| `group_by(.type)` | Group array |
| `to_entries / from_entries` | Map ↔ key/value pairs |
| `env(VAR)` | Read environment variable |
| `load("other.yaml")` | Load another file into the expression |

## Multiple Documents & Files

```bash
yq 'select(.kind == "Service")' multi-doc.yaml   # filter multi-doc YAML
yq eval-all '. as $item ireduce ({}; . * $item)' a.yaml b.yaml   # deep merge files
yq ea 'select(fi == 0) * select(fi == 1)' base.yaml override.yaml # merge (fi = file index)
```

## Useful Flags

| Flag | Effect |
|------|--------|
| `-i` | Edit file in place |
| `-o <fmt>` / `-p <fmt>` | Output / input format |
| `-I <n>` | Indent width |
| `-r` | Raw output for strings (no quotes) |
| `-n` | Don't read input (create documents from scratch) |
| `-e` | Exit 1 if expression result is null/false |
| `--no-colors` / `-C` | Force colors off / on |

```bash
yq -n '.name = "new" | .replicas = 1' > new.yaml   # generate a file from nothing
```
