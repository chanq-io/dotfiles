# NixOS-SPECIFIC ALIASES
# ======================
alias rebuild='sudo nixos-rebuild switch --flake ~/.dotfiles/nixos#shrike'
alias update-deps='nix flake update ~/.dotfiles/nixos && rebuild'
alias zconf='v ~/.dotfiles/nixos/modules/home/shell.nix'
