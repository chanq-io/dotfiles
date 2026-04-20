{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Media swiss army knife. Stock ffmpeg-full ships with
    # --disable-nonfree so libfdk_aac isn't baked in; override flips that
    # on. Consequence: ffmpeg recompiles from source on nixpkgs bumps
    # (~10-20 min). allowUnfree covers the licence side.
    (ffmpeg-full.override { withUnfree = true; })

    # Audio processing
    sox

    # MPRIS control — bound to XF86Audio* keys in hyprland.nix
    playerctl

    # TUI spotify
    spotify-player
  ];
}
