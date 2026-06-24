{ ... }:

{
  programs.git = {
    enable = true;

    userName  = "Hurng-Chun Lee";
    userEmail = "h.lee@donders.ru.nl";

    extraConfig = {
      core.editor = "vim";
      pull.rebase  = false;
    };

    aliases = {
      lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
    };
  };
}
