{ ... }:

{
  imports = [
    ./claude.nix
    ./cli.nix
    ./cliphist.nix
    ./dev.nix
    ./direnv.nix
    ./gammastep.nix
    ./git.nix
    ./gtk.nix
    ./gui-apps.nix
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
    ./zathura.nix
  ];

  home.username = "cardamom";
  home.homeDirectory = "/home/cardamom";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;
}
