{ ... }:

let
  theme = import ../../../lib/theme.nix;
in
{
  services.mako = {
    enable = true;
    settings = {
      font = "${theme.fonts.mono} 10";
      background-color = theme.base00;
      text-color = theme.base05;
      border-color = theme.base02;
      progress-color = "over ${theme.base01}";
      border-size = 2;
      border-radius = 6;
      padding = "12,16";
      margin = 10;
      default-timeout = 6000;
      max-visible = 5;
      anchor = "top-right";
      layer = "overlay";

      "urgency=low" = {
        border-color = theme.base03;
        text-color = theme.base04;
        default-timeout = 3000;
      };

      "urgency=normal" = {
        border-color = theme.base0D;
      };

      "urgency=high" = {
        border-color = theme.base08;
        text-color = theme.base08;
        default-timeout = 0;
      };
    };
  };
}
