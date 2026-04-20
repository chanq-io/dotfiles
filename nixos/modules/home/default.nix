{ ... }:

{
  imports = [
    ./cli.nix
    ./dev.nix
    ./git.nix
    ./neovim.nix
    ./shell.nix
    ./terminal.nix
  ];

  home.username = "cardamom";
  home.homeDirectory = "/home/cardamom";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;
}
