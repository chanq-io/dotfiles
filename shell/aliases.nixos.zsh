# NixOS-SPECIFIC ALIASES
# ======================
alias nixos-rebuild='sudo nixos-rebuild switch --flake ~/.dotfiles/nixos#shrike'
alias update-deps='nix flake update --flake ~/.dotfiles/nixos && nixos-rebuild'
alias clean-deps='sudo nix-collect-garbage --delete-older-than 7d && sudo /run/current-system/bin/switch-to-configuration boot'
alias zconf='v ~/.dotfiles/nixos/modules/home/shell.nix'
