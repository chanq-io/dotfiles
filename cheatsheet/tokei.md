# tokei

Fast lines-of-code counter: code / comments / blanks broken down by language.

---

## Usage

```bash
tokei                       # count cwd recursively
tokei src/ tests/           # specific paths
tokei --files               # per-file breakdown
tokei -t Rust,Lua           # only these languages
tokei -e target -e '*.min.js'   # exclude globs (repeatable)
tokei -s lines              # sort by: files|lines|code|comments|blanks
tokei -o json               # machine-readable (also yaml, cbor)
tokei --compact             # terse table
tokei --hidden              # include hidden files
tokei --no-ignore           # don't honor .gitignore
```

## Notes

- Respects `.gitignore`/`.ignore` by default.
- `tokei --languages` lists everything it can parse (~200 languages).
- Doc comments and block comments are counted as comments, not code; strings containing comment syntax are handled correctly per language.
