{ pkgs, ... }:

let
  theme = import ../../../lib/theme.nix;

  # Custom CSS applied to both GTK3 and GTK4. Overrides Adwaita-dark with
  # Petrol Noir palette colours so file pickers, dialogs, and GTK-native apps
  # (Zen, Betterbird, Spotify) pick up the scheme automatically.
  customCss = ''
    @define-color window_bg_color ${theme.base00};
    @define-color window_fg_color ${theme.base05};
    @define-color view_bg_color ${theme.base01};
    @define-color view_fg_color ${theme.base05};
    @define-color headerbar_bg_color ${theme.base01};
    @define-color headerbar_fg_color ${theme.base05};
    @define-color headerbar_backdrop_color ${theme.base00};
    @define-color card_bg_color ${theme.base01};
    @define-color card_fg_color ${theme.base05};
    @define-color sidebar_bg_color ${theme.base01};
    @define-color sidebar_fg_color ${theme.base05};
    @define-color popover_bg_color ${theme.base01};
    @define-color popover_fg_color ${theme.base05};
    @define-color dialog_bg_color ${theme.base01};
    @define-color dialog_fg_color ${theme.base05};
    @define-color accent_bg_color ${theme.base0A};
    @define-color accent_fg_color ${theme.base00};
    @define-color accent_color ${theme.base0A};
    @define-color destructive_bg_color ${theme.base08};
    @define-color destructive_fg_color ${theme.base05};
    @define-color success_bg_color ${theme.base0B};
    @define-color success_fg_color ${theme.base05};
    @define-color warning_bg_color ${theme.base09};
    @define-color warning_fg_color ${theme.base00};
    @define-color error_bg_color ${theme.base08};
    @define-color error_fg_color ${theme.base05};
    @define-color borders ${theme.base02};

    tooltip {
      background-color: ${theme.base01};
      color: ${theme.base05};
      border: 1px solid ${theme.base02};
    }

    selection {
      background-color: ${theme.base0A};
      color: ${theme.base00};
    }
  '';
in
{
  gtk = {
    enable = true;

    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    cursorTheme = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = 24;
    };

    font = {
      name = "Noto Sans";
      size = 11;
    };

    gtk3.extraCss = customCss;
    gtk4.extraCss = customCss;
  };

  # Tell GTK apps to prefer dark colour scheme via dconf. This is the
  # freedesktop standard that Zen, Betterbird, and other modern GTK apps
  # check at startup.
  dconf.settings."org/gnome/desktop/interface" = {
    color-scheme = "prefer-dark";
    gtk-theme = "Adwaita-dark";
  };

  # Hyprland needs to know about the cursor theme for consistent rendering.
  home.pointerCursor = {
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
    hyprcursor.enable = true;
  };
}
