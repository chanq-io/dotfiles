{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      devices = [ "nodev" ];
      efiSupport = true;
      useOSProber = true;
      default = "saved";
      theme = "${pkgs.sleek-grub-theme.override { withStyle = "dark"; }}";
      gfxmodeEfi = "1920x1080";
    };
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking = {
    hostName = "shrike";
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  users.users.cardamom = {
    isNormalUser = true;
    description = "Pierre Chanquion";
    extraGroups = [ "networkmanager" "wheel" "video" ];
    packages = with pkgs; [ ];
  };

  nixpkgs.config.allowUnfree = true;
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
