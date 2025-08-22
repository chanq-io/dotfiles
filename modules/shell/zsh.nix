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

    extraPackages = with pkgs; [
      chafa 
      clang
      fd
      fzf
      git
      gnumake
      ripgrep
      bat
      findutils
      viu
      ueberzugpp
      xclip
    ];

    plugins = with pkgs.vimPlugins; [
      base16-vim
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
      mini-nvim
      nvim-cmp
      nvim-dap
      nvim-lspconfig
      nvim-origami
      nvim-surround
      nvim-web-devicons
      nvim-treesitter
      nvim-treesitter-parsers.cpp
      nvim-treesitter-parsers.javascript
      nvim-treesitter-parsers.html
      nvim-treesitter-parsers.css
      nvim-treesitter-parsers.bash
      nvim-treesitter-parsers.toml
      nvim-treesitter-parsers.yaml
      nvim-treesitter-parsers.typescript
      nvim-treesitter-parsers.tsx
      nvim-treesitter-parsers.rust
      nvim-treesitter-parsers.vim
      plenary-nvim
      popup-nvim
      rose-pine
      rustaceanvim
      telekasten-nvim
      telescope-file-browser-nvim
      telescope-fzf-native-nvim
      telescope-nvim
      todo-comments-nvim
    ];
  };

  programs.zsh = {
    enable = true;
    dotDir = "${config.xdg.configHome}/zsh";  
  
    envExtra = ''
      if [ -r "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ]; then
        . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
      fi
    '';
  
    sessionVariables = {
      RPS1 = "";
      PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
      OPENSSL_DIR = "${pkgs.openssl.dev}";
      OPENSSL_LIB_DIR = "${pkgs.openssl.out}/lib";
      OPENSSL_INCLUDE_DIR = "${pkgs.openssl.dev}/include";
    };
  
    initContent = ''
      eval "$(starship init zsh)"
    '';
  
    profileExtra = ''
      if [ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
        . "$HOME/.nix-profile/etc/profile.d/nix.sh"
      fi
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
      docker = "${pkgs.podman}/bin/podman";
      cdot = "cd ~/.dotfiles"
    };
  
    plugins = [
      {
        name = "enhancd";
        file = "init.sh";
        src = pkgs.fetchFromGitHub {
          owner = "babarot";
          repo = "enhancd";
          rev = "5afb4eb6ba36c15821de6e39c0a7bb9d6b0ba415";
          sha256 = "pKQbwiqE0KdmRDbHQcW18WfxyJSsKfymWt/TboY2iic=";
        };
      }
      {
        name = "fast-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zdharma-continuum";
          repo = "fast-syntax-highlighting";
          rev = "v1.56";
          sha256 = "sha256-caVMOdDJbAwo8dvKNgwwidmxOVst/YDda7lNx2GvOjY=";
        };
      }
      {
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.7.1";
          sha256 = "sha256-vpTyYq9ZgfgdDsWzjxVAE7FZH4MALMNZIFyEOBLm5Qo=";
        };
      }
    ];
  };
}
