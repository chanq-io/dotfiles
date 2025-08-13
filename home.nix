{ pkgs, inputs, system, ..}: {
  home.username = "cardamom";
  home.homeDirectory = "/home/cardamom";
  home.stateVersion = "25.11";
  home.packages = with pkgs; [
    eza
    inputs.zen-browser.packages."${system}".specific
  ];

  imports = [
    ./modules/shell/zsh.nix
  ];

  programs.home-manager.enable = true;
}
