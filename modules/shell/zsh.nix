{ config, pkgs, lib, ... }: {
  home.packages = with pkgs; [ starship ];
  home.file = {
    "starship.toml" = {
      source = ./starship.toml;
      target = ".config/starship.toml";
    }; 
  };

  programs.bat = {
    enable = true;
    config = { theme = "base16"; };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.jq = {
    enable = true;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      cmp-buffer
      cmp-cmdline
      cmp-nvim-lsp
      cmp-path
      cmp-vsnip
      comment-nvim
      copilot-vim
      fidget-nvim
      fzf-lua
      lualine-nvim
      mason-lspconfig-nvim
      mason-nvim
      mini-nvim
      nvim-cmp
      nvim-lspconfig
      nvim-origami
      nvim-surround
      nvim-treesitter.withAllGrammars
      nvim-web-devicons
      plenary-nvim
      popup-nvim
      rustaceanvim
      telekasten-nvim
      telescope-file-browser-nvim
      telescope-fzf-native-nvim
      telescope-nvim
      todo-comments-nvim
      transparent-nvim
    ];
  };

  programs.zsh = with pkgs; {
    enable = true;
    dotDir = "${config.xdg.configHome}/.config/zsh";

    sessionVariables = {
      RPS1 = "";
    };

    initContent = ''
      eval "$(starship init zsh)"
    '';

    profileExtra = ''
      # Load Nix
      if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then . $HOME/.nix-profile/etc/profile.d/nix.sh; fi
    '';

    history = {
      expireDuplicatesFirst = true;
      ignoreSpace = false;
      save = 100000000;
      size = 1000000000;
    };

    shellAliases = {
      ls = "${pkgs.eza}/bin/eza -l --group-directories-first";
      l  = "${pkgs.eza}/bin/eza -l --group-directories-first";
      la = "${pkgs.eza}/bin/eza -la --group-directories-first";
    };

    plugins = [
      {
        name = "enhancd";
        file = "init.sh";
        src = fetchFromGitHub {
          owner = "babarot";
          repo = "enchancd";
          rev = "5afb4eb6ba36c15821de6e39c0a7bb9d6b0ba415";
          sha256 = "pKQbwiqE0KdmRDbHQcW18WfxyJSsKfymWt/TboY2iic=";
        };
      }
    ];
  };
}
