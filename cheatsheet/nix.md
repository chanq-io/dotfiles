# Nix

Purely functional package manager and build system.

---

## Flake Commands (nix 2.x)

| Command | Action |
|---------|--------|
| `nix build .#pkg` | Build a package from flake |
| `nix run .#pkg` | Build and run a package |
| `nix develop` | Enter flake devshell |
| `nix develop -c zsh` | Enter devshell with specific shell |
| `nix shell nixpkgs#pkg` | Temporary shell with package |
| `nix flake init` | Create a basic `flake.nix` |
| `nix flake init -t templates#...` | Init from template |
| `nix flake update` | Update all flake inputs |
| `nix flake update INPUT` | Update a specific input |
| `nix flake lock --update-input INPUT` | Update single input (alt) |
| `nix flake show` | Show flake outputs |
| `nix flake metadata` | Show flake inputs + revisions |
| `nix flake check` | Run flake checks |
| `nix flake archive` | Ensure all inputs are cached |
| `nix eval .#attr` | Evaluate a Nix expression |
| `nix fmt` | Format Nix files (if formatter defined) |
| `nix search nixpkgs QUERY` | Search packages |
| `nix path-info -Sh .#pkg` | Show closure size |
| `nix log .#pkg` | Show build log |
| `nix profile install nixpkgs#pkg` | Install to user profile |
| `nix profile list` | List installed profile packages |
| `nix profile remove N` | Remove by index |
| `nix profile upgrade '.*'` | Upgrade all profile packages |

## NixOS System Management

| Command | Action |
|---------|--------|
| `sudo nixos-rebuild switch --flake .#host` | Build + activate + add to boot |
| `sudo nixos-rebuild boot --flake .#host` | Build + add to boot (activate on reboot) |
| `sudo nixos-rebuild test --flake .#host` | Build + activate (don't add to boot) |
| `sudo nixos-rebuild build --flake .#host` | Build only (no activation) |
| `sudo nixos-rebuild dry-activate --flake .#host` | Show what would change |
| `nixos-rebuild list-generations` | List system generations |
| `nix-env --list-generations --profile /nix/var/nix/profiles/system` | Same, verbose |
| `sudo nix-env --delete-generations old --profile /nix/var/nix/profiles/system` | Delete old gens |

## Garbage Collection & Store

| Command | Action |
|---------|--------|
| `nix store gc` | Garbage collect unreachable paths |
| `nix-collect-garbage` | GC (classic) |
| `nix-collect-garbage -d` | Delete old generations + GC |
| `sudo nix-collect-garbage -d` | Same for system profiles |
| `nix store optimise` | Deduplicate store (hard links) |
| `nix store verify --all` | Verify store integrity |
| `nix store path-from-hash-part HASH` | Find store path by hash |
| `nix why-depends .#pkg .#dep` | Explain dependency chain |

## Nix REPL

```bash
nix repl                       # start REPL
nix repl --expr 'import <nixpkgs> {}'  # with nixpkgs loaded
```

| Command | Action |
|---------|--------|
| `:l <nixpkgs>` | Load nixpkgs |
| `:lf .` | Load current flake |
| `:b expr` | Build expression |
| `:p expr` | Print evaluated value |
| `:t expr` | Show type |
| `:doc builtins.map` | Show documentation |
| `:q` | Quit |

```nix
# In REPL after :l <nixpkgs>
lib.version                    # nixpkgs version
pkgs.hello.meta                # package metadata
builtins.attrNames pkgs.lib    # list lib functions
```

## Nix Language Quick Reference

### Types

| Type | Example |
|------|---------|
| String | `"hello"`, `''multiline''` |
| Integer | `42` |
| Float | `3.14` |
| Bool | `true`, `false` |
| Null | `null` |
| Path | `./file.nix`, `/etc/nixos` |
| List | `[ 1 2 3 ]` |
| Attribute set | `{ a = 1; b = 2; }` |
| Function | `x: x + 1`, `{ a, b }: a + b` |

### Key Syntax

```nix
# Let binding
let
  x = 1;
  y = 2;
in x + y

# With (bring attrs into scope)
with pkgs; [ hello git ]

# Inherit (shorthand for a = a)
{ inherit pkgs; }              # same as { pkgs = pkgs; }
{ inherit (pkgs) git vim; }    # same as { git = pkgs.git; vim = pkgs.vim; }

# Recursive attrset
rec { a = 1; b = a + 1; }

# Override / merge
set1 // set2                   # right-biased merge

# String interpolation
"hello ${name}"
''
  multiline with ${var}
''

# Import
import ./file.nix { inherit pkgs; }

# Conditionals
if x > 0 then "pos" else "neg"

# Functions
add = x: y: x + y;
greet = { name, greeting ? "Hello" }: "${greeting}, ${name}";
```

### Useful Builtins

| Function | Action |
|----------|--------|
| `builtins.map f list` | Map over list |
| `builtins.filter f list` | Filter list |
| `builtins.length list` | List length |
| `builtins.elem x list` | Check membership |
| `builtins.attrNames set` | Get attribute names |
| `builtins.attrValues set` | Get attribute values |
| `builtins.hasAttr name set` | Check attr exists |
| `builtins.getAttr name set` | Get attr value |
| `builtins.readFile path` | Read file as string |
| `builtins.toJSON value` | Convert to JSON |
| `builtins.fromJSON str` | Parse JSON |
| `builtins.fetchurl { url; sha256; }` | Fetch URL |
| `builtins.trace msg val` | Debug print |
| `builtins.typeOf val` | Type as string |
| `builtins.toString val` | Convert to string |
| `builtins.concatLists lists` | Flatten one level |
| `builtins.listToAttrs list` | `[{name; value;}]` → attrset |

### Useful lib Functions

| Function | Action |
|----------|--------|
| `lib.mkIf cond value` | Conditional module value |
| `lib.mkDefault value` | Low-priority default |
| `lib.mkForce value` | High-priority override |
| `lib.mkMerge [ ... ]` | Merge multiple values |
| `lib.mkOption { type; default; description; }` | Define option |
| `lib.types.str` / `bool` / `int` / `path` | Option types |
| `lib.types.listOf type` | List option type |
| `lib.types.attrsOf type` | Attrset option type |
| `lib.types.nullOr type` | Nullable option type |
| `lib.types.enum [ ... ]` | Enum option type |
| `lib.optional cond value` | `[ value ]` if true, else `[]` |
| `lib.optionals cond list` | `list` if true, else `[]` |
| `lib.optionalString cond str` | `str` if true, else `""` |
| `lib.concatStringsSep sep list` | Join strings |
| `lib.concatMapStringsSep sep f list` | Map + join |
| `lib.mapAttrs f set` | Map over attrset values |
| `lib.filterAttrs f set` | Filter attrset |
| `lib.recursiveUpdate a b` | Deep merge attrsets |
| `lib.generators.toINI {} set` | Generate INI |
| `lib.generators.toYAML {} val` | Generate YAML |

## Flake Structure

```nix
{
  description = "My flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }: {
    nixosConfigurations.hostname = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hosts/hostname
        home-manager.nixosModules.home-manager
      ];
    };
  };
}
```

## Debugging

```bash
# Show what a rebuild would do
sudo nixos-rebuild dry-activate --flake .#host

# Build with verbose output
nix build .#pkg -L

# Show derivation
nix show-derivation .#pkg

# Show dependency tree
nix-store -q --tree /nix/store/...

# Find what depends on a store path
nix-store -q --referrers /nix/store/...

# Diff two system generations
nvd diff /nix/var/nix/profiles/system-{N}-link /nix/var/nix/profiles/system-{N+1}-link
```
