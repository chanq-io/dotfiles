{ ... }:

{
  imports = [
    ./cli.nix
    ./dev.nix
    ./git.nix
    ./hypridle.nix
    ./hyprland.nix
    ./hyprlock.nix
    ./mako.nix
    ./neovim.nix
    ./shell.nix
    ./terminal.nix
    ./wallpaper.nix
    ./waybar.nix
    ./wofi.nix
  ];

  home.username = "cardamom";
  home.homeDirectory = "/home/cardamom";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;
}
