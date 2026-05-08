# NixOS-SPECIFIC ALIASES
# ======================
alias nixos-rebuild='sudo nixos-rebuild switch --flake ~/.dotfiles/nixos#shrike'
alias update-deps='nix flake update --flake ~/.dotfiles/nixos && nixos-rebuild'
alias zconf='v ~/.dotfiles/nixos/modules/home/shell.nix'
