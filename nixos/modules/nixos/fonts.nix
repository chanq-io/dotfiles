{ pkgs, ... }:

let
  theme = import ../../../lib/theme.nix;
in
{
  fonts = {
    packages = with pkgs; [
      nerd-fonts.iosevka
      nerd-fonts.fira-mono
      noto-fonts
      noto-fonts-color-emoji
    ];

    # Emoji fallback chain — so CJK/symbols/emoji render everywhere
    # without each app needing to list Noto explicitly.
    fontconfig = {
      defaultFonts = {
        monospace = [ theme.fonts.mono ];
        sansSerif = [ "Noto Sans" ];
        serif = [ "Noto Serif" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
