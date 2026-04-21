# home-manager

Manage user-level configuration and packages declaratively with Nix.

---

## Commands (Standalone)

| Command | Action |
|---------|--------|
| `home-manager switch --flake .#user@host` | Build and activate |
| `home-manager build --flake .#user@host` | Build only |
| `home-manager generations` | List generations |
| `home-manager expire-generations "-30 days"` | Remove old generations |
| `home-manager packages` | List installed packages |
| `home-manager news` | Show news entries |
| `home-manager uninstall` | Remove home-manager |

When used as a NixOS module, `nixos-rebuild switch` handles activation.

## Module Structure

```nix
{ config, pkgs, lib, ... }:
{
  # Install packages
  home.packages = with pkgs; [
    ripgrep
    fd
    jq
  ];

  # Set home-manager version tracking
  home.stateVersion = "25.11";

  # Set environment variables
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  # Manage dotfiles
  home.file.".config/foo/config".text = ''
    some config content
  '';

  home.file.".config/foo/config".source = ./config-file;

  # XDG config files
  xdg.configFile."foo/config".text = ''
    content
  '';
  xdg.configFile."foo/config".source = ./config-file;
}
```

## Common Program Modules

### Zsh

```nix
programs.zsh = {
  enable = true;
  enableCompletion = true;
  autosuggestion.enable = true;
  syntaxHighlighting.enable = true;
  shellAliases = {
    ll = "eza -l";
    la = "eza -la";
    v = "nvim";
  };
  initExtra = ''
    # Extra zshrc content
    source ~/.dotfiles/shell/aliases.zsh
  '';
  envExtra = ''
    # Extra zshenv content
  '';
  history = {
    size = 50000;
    save = 50000;
    ignoreDups = true;
    share = true;
  };
  oh-my-zsh = {
    enable = true;
    plugins = [ "git" "docker" ];
    theme = "robbyrussell";
  };
};
```

### Git

```nix
programs.git = {
  enable = true;
  userName = "Name";
  userEmail = "email@example.com";
  delta.enable = true;
  extraConfig = {
    init.defaultBranch = "main";
    pull.rebase = true;
    push.autoSetupRemote = true;
    core.editor = "nvim";
  };
  aliases = {
    co = "checkout";
    st = "status -sb";
    lg = "log --oneline --graph --decorate";
  };
  ignores = [ ".DS_Store" ".direnv" "result" ];
};
```

### Starship

```nix
programs.starship = {
  enable = true;
  settings = {
    add_newline = true;
    character.success_symbol = "[➜](bold green)";
    directory.truncation_length = 3;
    git_branch.symbol = " ";
  };
};
```

### Other Programs

```nix
programs.fzf.enable = true;
programs.zoxide.enable = true;
programs.direnv = {
  enable = true;
  nix-direnv.enable = true;
};
programs.bat = {
  enable = true;
  config.theme = "base16";
};
programs.eza = {
  enable = true;
  enableZshIntegration = true;
  icons = "auto";
  git = true;
};
programs.kitty = {
  enable = true;
  theme = "Base16 Default Dark";
  settings = {
    font_family = "Fira Mono Nerd Font";
    font_size = 12;
    background_opacity = "0.9";
  };
};
programs.lazygit.enable = true;
programs.btop.enable = true;
programs.jq.enable = true;
```

## Services (Linux)

```nix
services.mako = {
  enable = true;
  defaultTimeout = 5000;
  borderRadius = 5;
};

services.gammastep = {
  enable = true;
  latitude = 51.5;
  longitude = -0.1;
  temperature = { day = 6500; night = 3500; };
};

services.cliphist.enable = true;
services.playerctld.enable = true;
```

## Wayland/Hyprland

```nix
wayland.windowManager.hyprland = {
  enable = true;
  settings = {
    monitor = [ "HDMI-A-3,3840x2160@30,0x0,1.5" ];
    "$mod" = "SUPER";
    bind = [
      "$mod, Return, exec, kitty"
      "$mod, Q, killactive"
      "$mod, D, exec, wofi --show drun"
    ];
    exec-once = [
      "waybar"
      "mako"
      "swww-daemon"
    ];
  };
};
```

## Useful Patterns

```nix
# Conditional configuration
{ config, lib, pkgs, ... }:
{
  # Only enable on specific host
  programs.steam.enable = lib.mkIf (config.networking.hostName == "shrike") true;

  # Platform-specific packages
  home.packages = with pkgs; [
    ripgrep
  ] ++ lib.optionals stdenv.isLinux [
    radeontop
  ];
}
```

## Searching Options

```bash
# Search available home-manager options
man home-configuration.nix

# Online search
# https://home-manager-options.extranix.com/
```
