{ pkgs, inputs, system, lib, ...}: 
{
  home.username = "cardamom";
  home.homeDirectory = "/home/cardamom";
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    eza
    inputs.zen-browser.packages."${system}".default
    neofetch
  ];

  imports = [
    ./modules/shell/zsh.nix
  ];

 
  programs.home-manager.enable = true;

  home.file.".config/i3/config" = {
    source = ./config/i3/config;
    recursive = false;
  };


  home.file.".config/polybar/config.ini" = {
    source = ./config/polybar/config.ini;
    recursive = false;
  };
  home.file.".config/polybar/launch.sh" = {
    source = ./config/polybar/launch.sh;
    recursive = false;
  };
}
