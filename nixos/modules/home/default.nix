{ ... }:

{
  imports = [
    ./cli.nix
    ./dev.nix
    ./git.nix
    ./shell.nix
  ];

  home.username = "cardamom";
  home.homeDirectory = "/home/cardamom";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;
}
