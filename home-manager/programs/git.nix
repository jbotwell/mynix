{ ... }:

{
  programs.git = {
    enable = true;
    userName = "John Otwell";
    userEmail = "john.otwell@protonmail.com";
    extraConfig = {
      mergetool.vimdiff = true;
      pull.rebase = false;
      init.defaultBranch = "main";
    };
  };
}
