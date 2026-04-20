{ ... }:

let
  theme = import ../../../lib/theme.nix;
in
{
  programs.wofi = {
    enable = true;
    settings = {
      show = "drun";
      width = 500;
      height = 400;
      location = "center";
      prompt = "run";
      filter_rate = 100;
      allow_markup = true;
      no_actions = true;
      halign = "fill";
      orientation = "vertical";
      content_halign = "fill";
      insensitive = true;
      allow_images = true;
      image_size = 24;
      gtk_dark = true;
    };

    style = ''
      * {
        font-family: "FiraMono Nerd Font Mono", sans-serif;
        font-size: 13px;
      }

      window {
        background-color: ${theme.base00};
        border: 2px solid ${theme.base0A};
        border-radius: 6px;
      }

      #input {
        margin: 6px;
        padding: 6px 10px;
        background-color: ${theme.base01};
        color: ${theme.base05};
        border: 1px solid ${theme.base02};
        border-radius: 4px;
        outline: none;
      }

      #inner-box {
        margin: 6px;
        background-color: ${theme.base00};
      }

      #outer-box {
        background-color: ${theme.base00};
      }

      #entry {
        padding: 6px 10px;
        color: ${theme.base05};
        border-radius: 4px;
      }

      #entry:selected {
        background-color: ${theme.base0A};
        color: ${theme.base00};
      }

      #text {
        margin-left: 8px;
      }

      #scroll {
        margin-top: 4px;
      }
    '';
  };
}
