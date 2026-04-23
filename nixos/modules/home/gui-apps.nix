{ pkgs, inputs, ... }:

{
  # GUI apps installed per-user via home-manager. System-level apps (Steam,
  # 1Password GUI for polkit) live in modules/nixos/*. Community flakes
  # (zen-browser, claude-desktop) come from flake inputs threaded through
  # extraSpecialArgs in flake.nix.
  home.packages = [
    pkgs.firefox
    pkgs.ungoogled-chromium
    pkgs.google-chrome
    pkgs.spotify
    pkgs.maestral-gui
    pkgs.zoom-us
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.claude-desktop.packages.${pkgs.stdenv.hostPlatform.system}.claude-desktop
    inputs.betterbird.packages.${pkgs.stdenv.hostPlatform.system}.betterbird
  ];
}
