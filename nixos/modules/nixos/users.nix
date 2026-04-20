{ pkgs, ... }:

{
  users.users.cardamom = {
    isNormalUser = true;
    description = "Pierre Chanquion";
    extraGroups = [ "networkmanager" "wheel" "video" ];
    packages = with pkgs; [ ];
  };
}
