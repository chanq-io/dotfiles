{ ... }:

let
  theme = import ../../../lib/theme.nix;
in
{
  programs.zathura = {
    enable = true;

    options = {
      # Dark-mode by default. `recolor-keephue` preserves colour relationships
      # so diagrams and charts stay readable instead of being flattened to
      # monochrome.
      recolor = true;
      recolor-keephue = true;
      recolor-darkcolor = theme.base05;
      recolor-lightcolor = theme.base00;

      # Fit-to-width on open so the page lands at a sensible zoom regardless
      # of source PDF page size.
      adjust-open = "width";
      pages-per-row = 1;

      # Yank to the system clipboard (Ctrl-c / `y` in visual mode) rather than
      # the primary selection. Matches kitty / neovim clipboard behaviour.
      selection-clipboard = "clipboard";

      # Search ergonomics.
      incremental-search = true;
      abort-clear-search = false;

      # Window chrome.
      window-title-basename = true;
      statusbar-basename = true;
      guioptions = "";  # hide menubar/statusbar by default, toggle with F5/F7
      font = "${theme.fonts.mono} 11";

      # SyncTeX so neovim (vimtex, etc.) can jump source ↔ pdf.
      synctex = true;

      # Themed chrome — Petrol Noir.
      default-bg = theme.base00;
      default-fg = theme.base05;
      statusbar-bg = theme.base01;
      statusbar-fg = theme.base05;
      inputbar-bg = theme.base01;
      inputbar-fg = theme.base05;
      notification-bg = theme.base01;
      notification-fg = theme.base05;
      notification-error-bg = theme.base08;
      notification-error-fg = theme.base00;
      notification-warning-bg = theme.base09;
      notification-warning-fg = theme.base00;
      highlight-color = theme.base0A;
      highlight-active-color = theme.base09;
      completion-bg = theme.base01;
      completion-fg = theme.base05;
      completion-highlight-bg = theme.base02;
      completion-highlight-fg = theme.base07;
      index-bg = theme.base00;
      index-fg = theme.base05;
      index-active-bg = theme.base02;
      index-active-fg = theme.base07;
    };
  };
}
