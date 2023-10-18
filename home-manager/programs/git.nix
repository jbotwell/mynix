{ ... }:

{
  programs.git = {
    enable = true;
    delta.enable = true;
    delta.options = {
      features = {
        side_by_side = true;
        decorations = true;
      };
      syntax_theme = "Dracula";
    };
    userName = "John Otwell";
    userEmail = "john.otwell@protonmail.com";
    extraConfig = {
      interactive.diffFilter = "delta --color-only";
      merge.conflictStyle = "diff3";
      diff.colorMoved = "default";
      mergetool.vimdiff = true;
      pull.rebase = false;
      init.defaultBranch = "main";
    };
  };
}
