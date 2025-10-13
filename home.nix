{ pkgs, config, inputs, fenix, nixgl, system, lib, ...}: 
let
  has = name: builtins.hasAttr name pkgs;
  get = name: builtins.getAttr name pkgs;
  nixglIntel  = pkgs.nixgl.nixGLIntel;
  nixglNvidia = pkgs.nixgl.nixGLNvidia;
  pipewirePkgs =
    [ pkgs.pipewire pkgs.wireplumber ]
    ++ lib.optional (has "pipewire-alsa") (get "pipewire-alsa")
    ++ lib.optional (has "pipewire-pulse") (get "pipewire-pulse")
    ++ lib.optional (has "pipewire-jack") (get "pipewire-jack");
in
{
  home.username = "cardamom";
  home.homeDirectory = "/home/cardamom";
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    alsa-lib
    alsa-utils
    atk
    bat
    cairo
    calcure
    cargo-make
    chafa
    clang
    cmake
    coreutils
    eza
    fd
    fenix.packages.${pkgs.system}.stable.toolchain
    feh
    fontconfig
    freetype
    fribidi
    fzf
    gdk-pixbuf
    gh
    git
    glib
    gnumake
    graphite2
    graphviz
    gtk3
    harfbuzz
    just
    libsoup_3
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
    pango
    pavucontrol
    pkg-config
    pkgs.vscode-extensions.vadimcn.vscode-lldb
    podman
    protobuf
    pyright
    python3
    ripgrep
    taplo
    tldr
    tree-sitter
    ueberzugpp
    unzip
    viu
    webkitgtk_4_1
    wget
    xclip
    zoom-us
    nixGLIntel
    nixGLNvidia
    (writeShellScriptBin "zoom-intel" ''
      export QT_QPA_PLATFORM=xcb
      export QT_XCB_GL_INTEGRATION=xcb_egl
      export LIBGL_DRI3_DISABLE=1
      exec ${nixglIntel}/bin/nixGLIntel ${zoom-us}/bin/zoom-us "$@"
    '')

    (writeShellScriptBin "zoom-intel-soft" ''
      export QT_QPA_PLATFORM=xcb
      export QT_XCB_GL_INTEGRATION=none
      export QT_OPENGL=software
      export LIBGL_ALWAYS_SOFTWARE=1
      exec ${nixglIntel}/bin/nixGLIntel ${zoom-us}/bin/zoom-us "$@"
    '')

    (writeShellScriptBin "zoom-nvidia" ''
      export __NV_PRIME_RENDER_OFFLOAD=1
      export __GLX_VENDOR_LIBRARY_NAME=nvidia
      export __VK_LAYER_NV_optimus=NVIDIA_only
      exec ${nixglNvidia}/bin/nixGLNvidia ${zoom-us}/bin/zoom-us "$@"
    '')
  ] ++ pipewirePkgs;

  xdg.desktopEntries."zoom-us-nixgl-intel" = {
    name = "Zoom (Intel)";
    exec = "zoom-intel";
    terminal = false;
    type = "Application";
    categories = [ "Network" "VideoConference" ];
    icon = "zoom";
  };

  xdg.desktopEntries."zoom-us-nixgl-intel-soft" = {
    name = "Zoom (Intel, software)";
    exec = "zoom-intel-soft";
    terminal = false;
    type = "Application";
    categories = [ "Network" "VideoConference" ];
    icon = "zoom";
  };

  xdg.desktopEntries."zoom-us-nixgl-nvidia" = {
    name = "Zoom (NVIDIA offload)";
    exec = "zoom-nvidia";
    terminal = false;
    type = "Application";
    categories = [ "Network" "VideoConference" ];
    icon = "zoom";
  };

  xdg.userDirs = {
    enable = true;
    download = "${config.home.homeDirectory}/downloads";
  };

  imports = [
    ./modules/shell/zsh.nix
  ];

  programs.home-manager.enable = true;

  # alsa / pipewire conf
  home.file.".asoundrc" = {
    source = ./config/.asoundrc;
  };

  # cargo conf
  home.file.".cargo/config.toml" = {
    source = ./config/cargo/config.toml;
  };

  # i3 conf
  xdg.configFile."i3/config" = {
    source = ./config/i3/config;
  };

  # picom conf
  xdg.configFile."picom/picom.conf" = {
    source = ./config/picom/picom.conf;
  };

  # rofi conf
  xdg.configFile."rofi/config.rasi" = {
    source = ./config/rofi/config.rasi;
  };

  xdg.configFile."rofi/darkmatrix.rasi" = {
    source = ./config/rofi/darkmatrix.rasi;
  };

  # kitty conf
  xdg.configFile."kitty" = {
    source = ./config/kitty;
    recursive = true;
  };

  # polybar conf
  xdg.configFile."polybar" = {
    source = ./config/polybar;
    recursive = true;
  };

  # nvim conf
  xdg.configFile."nvim" = {
    source = ./config/nvim;
    recursive = true;
  };

  # wezterm conf
  home.file.".wezterm.lua" = {
    source = ./config/wezterm.lua;
    recursive = true;
  };
}
