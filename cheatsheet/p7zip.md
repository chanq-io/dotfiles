# 7z (p7zip)

High-compression archiver supporting 7z, zip, tar, gz, bz2, xz, and more.

---

## Commands

| Command | Action |
|---------|--------|
| `7z a archive.7z files` | Add files to archive |
| `7z x archive.7z` | Extract with full paths |
| `7z e archive.7z` | Extract flat (no directories) |
| `7z l archive.7z` | List contents |
| `7z t archive.7z` | Test integrity |
| `7z u archive.7z files` | Update archive |
| `7z d archive.7z files` | Delete from archive |

## Key Flags

| Flag | Action |
|------|--------|
| `-o DIR` | Output directory |
| `-p PASS` | Password |
| `-mhe=on` | Encrypt filenames too |
| `-t TYPE` | Archive type (`7z`, `zip`, `tar`, `gzip`, `bzip2`, `xz`) |
| `-mx=N` | Compression level (0=store, 1=fastest, 9=ultra) |
| `-v SIZE` | Split volume (e.g., `100m`, `1g`) |
| `-r` | Recurse subdirectories |
| `-y` | Assume yes |
| `-x!PATTERN` | Exclude pattern |
| `-i!PATTERN` | Include pattern |

## Common Recipes

```bash
# Create 7z archive
7z a archive.7z folder/

# Create with max compression
7z a -mx=9 archive.7z folder/

# Create encrypted archive
7z a -p -mhe=on archive.7z folder/

# Create zip
7z a -tzip archive.zip folder/

# Extract to specific directory
7z x archive.7z -o./output/

# Extract password-protected
7z x archive.7z -pMyPassword

# List contents
7z l archive.7z

# Split into 100MB volumes
7z a -v100m archive.7z folder/

# Create tar.gz
7z a -ttar archive.tar folder/ && 7z a -tgzip archive.tar.gz archive.tar
```
