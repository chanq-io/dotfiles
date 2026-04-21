# jq

Lightweight command-line JSON processor.

---

## Basic Usage

```bash
cat data.json | jq '.'           # pretty-print
jq '.' data.json                  # same, file input
echo '{"a":1}' | jq '.a'         # extract field
curl -s url | jq '.results'      # process API response
```

## Key Flags

| Flag | Action |
|------|--------|
| `-r` / `--raw-output` | Output strings without quotes |
| `-R` / `--raw-input` | Read each line as string |
| `-s` / `--slurp` | Read all inputs into array |
| `-c` / `--compact-output` | One-line output |
| `-e` / `--exit-status` | Exit 1 if last output is false/null |
| `-n` / `--null-input` | Don't read input |
| `--arg NAME VAL` | Pass string variable |
| `--argjson NAME VAL` | Pass JSON variable |
| `--slurpfile NAME FILE` | Read file into variable |
| `-S` / `--sort-keys` | Sort object keys |
| `--tab` | Use tabs for indentation |
| `--indent N` | Set indentation level |
| `-j` / `--join-output` | No newline after output |

## Filters

### Basic Access

```bash
.                    # identity (whole input)
.field               # object field
.field.nested        # nested field
."field-name"        # field with special chars
.field?              # suppress error if missing
```

### Arrays

```bash
.[]                  # iterate array elements
.[0]                 # first element
.[-1]                # last element
.[2:5]               # slice (index 2 to 4)
.[:3]                # first 3
.[-2:]               # last 2
```

### Pipe & Comma

```bash
.a | .b              # pipe: chain filters
.a, .b               # comma: multiple outputs
```

## Built-in Functions

| Function | Action |
|----------|--------|
| `length` | Length of string/array/object |
| `keys` | Object keys as array |
| `values` | Object values as array |
| `has("key")` | Check if key exists |
| `in(obj)` | Check if input key exists in obj |
| `contains(x)` | Check if input contains x |
| `inside(x)` | Check if input is inside x |
| `type` | Type name as string |
| `empty` | Produce no output |
| `error("msg")` | Raise error |
| `not` | Boolean negation |
| `map(f)` | Apply f to each element |
| `map_values(f)` | Apply f to each value |
| `select(cond)` | Keep if condition true |
| `sort` | Sort array |
| `sort_by(.field)` | Sort by field |
| `group_by(.field)` | Group by field |
| `unique` | Remove duplicates |
| `unique_by(.field)` | Unique by field |
| `flatten` | Flatten nested arrays |
| `flatten(n)` | Flatten n levels |
| `reverse` | Reverse array |
| `min` / `max` | Min / max of array |
| `min_by(f)` / `max_by(f)` | Min / max by function |
| `add` | Sum numbers / concat strings / merge objects |
| `any(cond)` / `all(cond)` | Any / all match |
| `limit(n; f)` | First n results of f |
| `first(f)` / `last(f)` | First / last result |
| `range(n)` | Generate 0 to n-1 |
| `range(m; n)` | Generate m to n-1 |
| `indices(str)` | All indices of substring |
| `ltrimstr(s)` | Remove prefix |
| `rtrimstr(s)` | Remove suffix |
| `startswith(s)` | Test prefix |
| `endswith(s)` | Test suffix |
| `split(s)` | Split string |
| `join(s)` | Join array |
| `ascii_downcase` | Lowercase |
| `ascii_upcase` | Uppercase |
| `test(regex)` | Regex test (boolean) |
| `match(regex)` | Regex match (object) |
| `capture(regex)` | Regex named captures |
| `gsub(regex; s)` | Regex replace all |
| `sub(regex; s)` | Regex replace first |
| `tostring` / `tonumber` | Type conversion |
| `tojson` / `fromjson` | JSON encode / decode |
| `to_entries` | Object → `[{key, value}]` array |
| `from_entries` | `[{key, value}]` → object |
| `with_entries(f)` | Transform entries |
| `transpose` | Transpose array of arrays |
| `env` | Environment variables |
| `$ENV.NAME` | Specific env var |

## Formatting

| Filter | Output |
|--------|--------|
| `@base64` | Base64 encode |
| `@base64d` | Base64 decode |
| `@uri` | URI encode |
| `@csv` | CSV format |
| `@tsv` | TSV format |
| `@html` | HTML escape |
| `@json` | JSON encode |
| `@text` | Raw string |

## Conditionals & Loops

```bash
if .x > 0 then "pos" elif .x == 0 then "zero" else "neg" end
.[] | if .active then . else empty end
reduce .[] as $x (0; . + $x)          # sum array
foreach .[] as $x (0; . + $x)         # running sum
try .field catch "default"             # error handling
```

## Object Construction

```bash
{name: .user, age: .profile.age}      # build object
{(.key): .value}                       # dynamic key
[.[] | select(.active)]                # filter to array
[.[] | .name]                          # pluck field
```

## Variables

```bash
.x as $x | .y as $y | {x: $x, y: $y}
```

## Common Recipes

```bash
# Pretty-print
jq '.' data.json

# Extract field from array of objects
jq '.[].name' data.json
jq -r '.[].name' data.json            # raw strings

# Filter objects
jq '[.[] | select(.age > 30)]' data.json

# Count elements
jq '. | length' data.json

# Get unique values of a field
jq '[.[].status] | unique' data.json

# Sum a field
jq '[.[].price] | add' data.json

# Convert object to key-value pairs
jq 'to_entries[] | "\(.key)=\(.value)"' -r data.json

# Merge objects
jq '.[0] * .[1]' <<< '[{"a":1},{"b":2}]'

# CSV output
jq -r '.[] | [.name, .age] | @csv' data.json

# Pass variables
jq --arg name "Alice" '.[] | select(.name == $name)' data.json

# Slurp multiple files
jq -s '.' file1.json file2.json

# Flatten nested structure
jq '[.. | .name? // empty]' data.json

# Group and count
jq 'group_by(.status) | map({status: .[0].status, count: length})' data.json
```

## String Interpolation

```bash
jq '"Name: \(.name), Age: \(.age)"' data.json
jq -r '"Name: \(.name), Age: \(.age)"' data.json
```
