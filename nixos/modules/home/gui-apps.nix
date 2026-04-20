{ pkgs, inputs, ... }:

{
  # GUI apps installed per-user via home-manager. System-level apps (Steam,
  # 1Password GUI for polkit) live in modules/nixos/*. Community flakes
  # (zen-browser, claude-desktop) come from flake inputs threaded through
  # extraSpecialArgs in flake.nix.
  home.packages = [
    pkgs.firefox
    pkgs.ungoogled-chromium
    pkgs.spotify
    pkgs.maestral-gui
    inputs.zen-browser.packages.${pkgs.system}.default
    inputs.claude-desktop.packages.${pkgs.system}.claude-desktop
    inputs.betterbird.packages.${pkgs.system}.betterbird
  ];
}
