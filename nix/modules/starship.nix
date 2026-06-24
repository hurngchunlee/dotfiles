{ ... }:

{
  programs.starship = {
    enable = true;
    # Starship handles its own shell integration; zsh.nix calls `starship init zsh` manually.
    enableZshIntegration = false;

    settings = {
      add_newline = false;

      character = {
        success_symbol = "[➜](bold green)";
        error_symbol   = "[](bold red)";
      };

      aws.disabled = true;
    };
  };
}
