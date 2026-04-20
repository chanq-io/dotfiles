{ pkgs, ... }:

{
  # hyprshot is a thin wrapper around grim + slurp with modes (region,
  # window, output). Keybinds live in hyprland.nix. Copies go to clipboard
  # AND save to ~/Pictures/Screenshots (hyprshot default).
  home.packages = with pkgs; [
    hyprshot
    grim
    slurp
  ];
}
