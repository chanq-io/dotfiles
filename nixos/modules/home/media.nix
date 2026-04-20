{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Media swiss army knife. ffmpeg-full bundles libfdk_aac (non-free)
    # for high-quality AAC encodes; requires nixpkgs.config.allowUnfree.
    ffmpeg-full

    # Audio processing
    sox

    # MPRIS control — bound to XF86Audio* keys in hyprland.nix
    playerctl

    # TUI spotify
    spotify-player
  ];
}
