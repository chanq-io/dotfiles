{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/boot.nix
    ../../modules/nixos/desktop.nix
    ../../modules/nixos/fonts.nix
    ../../modules/nixos/hardware.nix
    ../../modules/nixos/locale.nix
    ../../modules/nixos/networking.nix
    ../../modules/nixos/nix.nix
    ../../modules/nixos/services.nix
    ../../modules/nixos/users.nix
  ];

  networking.hostName = "shrike";

  environment.systemPackages = with pkgs; [
    hyprland
    grim
    slurp
    wl-clipboard
    firefox
    os-prober
    git
    wget
    efibootmgr
  ];

  system.stateVersion = "25.11";
}
