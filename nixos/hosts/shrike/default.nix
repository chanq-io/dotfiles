{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/boot.nix
    ../../modules/nixos/locale.nix
    ../../modules/nixos/networking.nix
    ../../modules/nixos/nix.nix
    ../../modules/nixos/users.nix
  ];

  networking.hostName = "shrike";

  programs.hyprland.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  hardware.graphics.enable = true;

  environment.loginShellInit = ''
    if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = "1" ]; then
      exec Hyprland
    fi
  '';

  environment.systemPackages = with pkgs; [
    hyprland
    kitty
    waybar
    wofi
    mako
    grim
    slurp
    wl-clipboard
    firefox
    os-prober
    git
    neovim
    wget
    efibootmgr
  ];

  services.openssh.enable = true;

  system.stateVersion = "25.11";
}
