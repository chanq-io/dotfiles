{ pkgs, inputs, system, lib, ...}: 
let 
  nixGL = import (pkgs.fetchFromGitHub {
    owner = "nix-community";
    repo = "nixGL";
    rev = "a8e1ce7d49a149ed70df676785b07f63288f53c5";
    sha256 = "010n26nhha1l64m7m08rzrfhyixfr8japn3vzbn80dj092wwggrr";
  }) { inherit pkgs; };
  kitty-wrapped = pkgs.writeShellScriptBin "kitty" ''
    exec ${nixGL.auto.nixGLDefault}/bin/nixGL ${pkgs.kitty}/bin/kitty "$@"
  '';
in
{
  home.username = "cardamom";
  home.homeDirectory = "/home/cardamom";
  home.stateVersion = "25.11";
  home.packages = with pkgs; [
    eza
    inputs.zen-browser.packages."${system}".default
    kitty-wrapped
    neofetch
  ];

  imports = [
    ./modules/shell/zsh.nix
  ];

  programs.home-manager.enable = true;
  programs.kitty = {
    enable = true;
  };
}
