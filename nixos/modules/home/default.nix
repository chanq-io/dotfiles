{ ... }:

{
  imports = [
    ./cli.nix
    ./dev.nix
    ./git.nix
    ./hyprland.nix
    ./mako.nix
    ./neovim.nix
    ./shell.nix
    ./terminal.nix
    ./waybar.nix
    ./wofi.nix
  ];

  home.username = "cardamom";
  home.homeDirectory = "/home/cardamom";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;
}
