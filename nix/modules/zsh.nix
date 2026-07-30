{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    package = pkgs.emptyDirectory;

    # --------------------------------------------------------------------------
    # oh-my-zsh
    # --------------------------------------------------------------------------
    oh-my-zsh = {
      enable = true;
      plugins = [ ];
      # No theme — Starship is used as the prompt (see modules/starship.nix)
      theme = "";
    };

    autosuggestion.enable = false;
    syntaxHighlighting.enable = true;

    # --------------------------------------------------------------------------
    # Extra init sourced at the end of .zshrc
    # --------------------------------------------------------------------------
    initExtra = ''
      ### Fix slowness of pastes with zsh-syntax-highlighting
      pasteinit() {
        OLD_SELF_INSERT=''${''${(s.:.)widgets[self-insert]}[2,3]}
        zle -N self-insert url-quote-magic
      }
      pastefinish() {
        zle -N self-insert $OLD_SELF_INSERT
      }
      zstyle :bracketed-paste-magic paste-init pasteinit
      zstyle :bracketed-paste-magic paste-finish pastefinish

      # Colorful man pages
      export LESS_TERMCAP_mb=$'\e[1;32m'
      export LESS_TERMCAP_md=$'\e[1;32m'
      export LESS_TERMCAP_me=$'\e[0m'
      export LESS_TERMCAP_se=$'\e[0m'
      export LESS_TERMCAP_so=$'\e[01;33m'
      export LESS_TERMCAP_ue=$'\e[0m'
      export LESS_TERMCAP_us=$'\e[1;4;31m'

      # Environment Modules (HPC-style, system-level)
      [ -f /etc/profile.d/env-modules.sh ] && source /etc/profile.d/env-modules.sh
      export MODULEPATH=/opt/_modules:$HOME/opt/_modules:''${MODULEPATH:-}

      # SSH agent socket
      export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

      # icons and colors for lf file manager
      [ -f $HOME/.config/lf/icons ] && source $HOME/.config/lf/icons
      [ -f $HOME/.config/lf/colors ] && source $HOME/.config/lf/colors
    '';

    # --------------------------------------------------------------------------
    # Shell variables / environment
    # --------------------------------------------------------------------------
    sessionVariables = {
      EDITOR = "nvim";
      TERM   = "xterm-256color";
      npm_config_prefix = "$HOME/.local";
    };

    # --------------------------------------------------------------------------
    # PATH extensions
    # --------------------------------------------------------------------------
    envExtra = ''
      export PATH="$HOME/.local/bin:$HOME/opt/bin:$PATH"
    '';

    # --------------------------------------------------------------------------
    # Aliases
    # --------------------------------------------------------------------------
    shellAliases = {
      vi           = "nvim";
      scp          = "noglob scp";
      brave-nogpu  = "brave-browser --disable-gpu";
    };
  };

  # starship integration
  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      add_newline = false;

      character = {
        success_symbol = "[➜](bold green)";
        error_symbol   = "[](bold red)";
      };

      aws.disabled = true;
    };
  };

  # direnv integration (generates the hook automatically)
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };
}
