{ pkgs, inputs, fenix, system, lib, ...}: 
{
  home.username = "cardamom";
  home.homeDirectory = "/home/cardamom";
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    bat
    chafa
    clang
    cmake
    coreutils
    eza
    fd
    fenix.packages.${pkgs.system}.stable.toolchain
    fzf
    git
    gnumake
    graphviz
    inputs.zen-browser.packages."${system}".default
    lldb
    llvm
    lua5_1
    luarocks
    neofetch
    nodePackages.bash-language-server
    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.vscode-languages-extracted
    nodePackages.yaml-language-server
    nodejs
    pkgs.vscode-extensions.vadimcn.vscode-lldb
    ripgrep
    taplo
    tldr
    tree-sitter
    ueberzugpp
    unzip
    viu
    wget
    xclip
  ];

  imports = [
    ./modules/shell/zsh.nix
  ];

 
  programs.home-manager.enable = true;

  xdg.configFile."i3/config" = {
    source = ./config/i3/config;
  };

  xdg.configFile."kitty" = {
    source = ./config/kitty;
    recursive = true;
  };

  xdg.configFile."polybar" = {
    source = ./config/polybar;
    recursive = true;
  };

  xdg.configFile."nvim" = {
    source = ./config/nvim;
    recursive = true;
  };
}
