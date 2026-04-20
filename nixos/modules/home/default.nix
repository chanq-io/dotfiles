{ ... }:

{
  imports = [
    ./cli.nix
    ./cliphist.nix
    ./dev.nix
    ./gammastep.nix
    ./git.nix
    ./hypridle.nix
    ./hyprland.nix
    ./hyprlock.nix
    ./mako.nix
    ./media.nix
    ./neovim.nix
    ./qpwgraph.nix
    ./screenshot.nix
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
