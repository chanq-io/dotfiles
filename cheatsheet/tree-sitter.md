# Tree-sitter CLI Cheatsheet

Incremental parsing library and CLI tool for building and testing language grammars.

---

## Installation

```bash
npm install -g tree-sitter-cli    # via npm
cargo install tree-sitter-cli     # via cargo
```

## Core Commands

| Command | Description |
|---------|-------------|
| `tree-sitter init` | Create a new grammar project |
| `tree-sitter generate` | Generate parser from `grammar.js` |
| `tree-sitter parse FILE` | Parse a file and print syntax tree |
| `tree-sitter highlight FILE` | Syntax-highlight a file |
| `tree-sitter test` | Run grammar tests |
| `tree-sitter query QUERY FILE` | Run a tree-sitter query |
| `tree-sitter build` | Build the parser as a shared library |
| `tree-sitter version` | Show version |

## Generate

Generate the parser C code from `grammar.js`:

```bash
tree-sitter generate                 # generate from grammar.js
tree-sitter generate grammar.js      # explicit grammar file
tree-sitter generate --abi-version 14  # specify ABI version
tree-sitter generate --no-bindings   # skip language bindings
tree-sitter generate --build         # generate and build
```

After generation, creates/updates:
- `src/parser.c` -- the parser
- `src/tree_sitter/parser.h` -- parser header
- `src/node-types.json` -- node type info
- `src/grammar.json` -- serialized grammar

## Parse

Parse a source file and print the concrete syntax tree:

```bash
tree-sitter parse file.rs                  # parse and print tree
tree-sitter parse file.rs --quiet          # only show errors
tree-sitter parse file.rs --stat           # print parsing statistics
tree-sitter parse file.rs --dot            # output DOT graph
tree-sitter parse file.rs --xml            # output XML
tree-sitter parse file.rs --cst            # print CST (concrete syntax tree)
tree-sitter parse file.rs --scope source.rust  # specify language scope
tree-sitter parse file.rs --timeout 5000   # timeout in microseconds
tree-sitter parse file.rs --debug          # print debug info during parse
tree-sitter parse file.rs --debug-graph    # output debug graph
tree-sitter parse 'source string' --string # parse a string directly
```

### Output Format

```
(source_file
  (function_item
    name: (identifier)
    parameters: (parameters)
    body: (block
      (expression_statement
        (string_literal)))))
```

Error nodes show as `(ERROR ...)` or `(MISSING ...)`.

## Highlight

```bash
tree-sitter highlight file.rs              # highlight to terminal
tree-sitter highlight file.rs --html       # output HTML
tree-sitter highlight file.rs --scope source.rust  # specify scope
tree-sitter highlight --query QUERY_FILE file.rs   # custom highlights query
```

Requires `queries/highlights.scm` in the grammar directory (or a configured path).

## Test

Grammar tests live in `test/corpus/` as `.txt` files:

```
==================
Test Name
==================

source code here

---

(expected_syntax_tree)
```

```bash
tree-sitter test                           # run all tests
tree-sitter test --filter "test name"      # run matching tests
tree-sitter test --update                  # update expected output
tree-sitter test --debug                   # debug output
tree-sitter test --debug-graph             # debug graph output
```

### Test File Format

```
==================
Function declaration
==================

fn main() {
    println!("hello");
}

---

(source_file
  (function_item
    name: (identifier)
    parameters: (parameters)
    body: (block
      (expression_statement
        (macro_invocation
          macro: (identifier)
          (token_tree
            (string_literal)))))))

==================
Attribute test
:language(rust)
==================

#[derive(Debug)]
struct Foo;

---

(source_file ...)
```

Tests marked with `:skip` are skipped. Use `:fail` to expect parse failure.

## Query

Run tree-sitter queries (S-expression pattern matching):

```bash
tree-sitter query queries/highlights.scm file.rs
tree-sitter query query.scm file.rs --captures    # show captures
tree-sitter query query.scm file.rs --test        # test mode
tree-sitter query query.scm file.rs --scope source.rust
```

### Query Syntax Basics

```scheme
; Match function definitions, capture the name
(function_item
  name: (identifier) @function.name)

; Match string literals
(string_literal) @string

; Match any call expression
(call_expression
  function: (identifier) @function.call)

; Predicates
((identifier) @var
 (#match? @var "^_"))       ; regex match

((identifier) @constant
 (#eq? @var "NULL"))        ; exact match
```

## Build

```bash
tree-sitter build                          # build shared library
tree-sitter build --wasm                   # build WASM module
tree-sitter build --docker                 # build WASM using Docker
tree-sitter build --output parser.so       # custom output path
```

## Init

```bash
tree-sitter init                           # interactive project setup
```

Creates a new grammar project with the standard directory structure:
- `grammar.js` -- grammar definition
- `bindings/` -- language bindings (Node, Rust, etc.)
- `queries/` -- highlight, indent, fold queries
- `test/corpus/` -- test files
- `src/` -- generated parser (after `generate`)

## Configuration

Config file: `~/.config/tree-sitter/config.json` (or `tree-sitter init-config` to create).

```json
{
  "parser-directories": [
    "/home/user/tree-sitter-grammars"
  ],
  "theme": {
    "function": "blue",
    "keyword": "purple",
    "string": "green",
    "comment": "gray",
    "type": "yellow"
  }
}
```

```bash
tree-sitter init-config      # create default config file
tree-sitter dump-languages   # list all detected languages
```

The `parser-directories` array tells the CLI where to find grammar repos (used by `parse`, `highlight`, `query` for language detection).

## Grammar Development Workflow

```bash
# 1. Start a new grammar
tree-sitter init

# 2. Edit grammar.js

# 3. Generate parser
tree-sitter generate

# 4. Write tests in test/corpus/*.txt

# 5. Run tests
tree-sitter test

# 6. Try parsing real files
tree-sitter parse example_file.ext

# 7. Add highlight queries in queries/highlights.scm

# 8. Test highlighting
tree-sitter highlight example_file.ext

# 9. Build shared library for editor use
tree-sitter build
```

## grammar.js Skeleton

```javascript
module.exports = grammar({
  name: 'mylang',

  extras: $ => [/\s/, $.comment],

  rules: {
    source_file: $ => repeat($._statement),

    _statement: $ => choice(
      $.function_declaration,
      $.expression_statement,
    ),

    function_declaration: $ => seq(
      'fn',
      field('name', $.identifier),
      '(', ')',
      field('body', $.block),
    ),

    block: $ => seq('{', repeat($._statement), '}'),

    expression_statement: $ => seq($._expression, ';'),

    _expression: $ => choice(
      $.identifier,
      $.number,
      $.string,
    ),

    identifier: $ => /[a-zA-Z_]\w*/,
    number: $ => /\d+/,
    string: $ => seq('"', /[^"]*/, '"'),
    comment: $ => token(seq('//', /.*/)),
  }
});
```
