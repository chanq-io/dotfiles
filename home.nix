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
    cargo-make
    eza
    fd
    fenix.packages.${pkgs.system}.stable.toolchain
    fzf
    git
    gnumake
    graphviz
    just
    inputs.zen-browser.packages."${system}".default
    lldb
    llvm
    lua5_1
    luarocks
    neofetch
    nodePackages.bash-language-server
    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.vscode-langservers-extracted
    nodePackages.yaml-language-server
    nodejs
    openssl
    pkg-config
    podman
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

  home.sessionVariables.PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";

  imports = [
    ./modules/shell/zsh.nix
  ];

  programs.home-manager.enable = true;

  home.file.".cargo/config.toml" = {
    source = ./config/cargo/config.toml;
  };

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
