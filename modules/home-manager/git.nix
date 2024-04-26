{ ... }: {
  programs.git = {
    enable = true;
    delta.enable = true;
    userName = "John Otwell";
    userEmail = "john.otwell@protonmail.com";
    ignores = [ "*.tags" ];
    hooks = {
      post-commit = ./git/ctags-hook.sh;
      post-checkout = ./git/ctags-hook.sh;
      post-merge = ./git/ctags-hook.sh;
      post-rewrite = ./git/ctags-post-rewrite-hook.sh;
    };
    extraConfig = {
      core.editor = "vim";
      merge.conflictStyle = "diff3";
      diff.colorMoved = "default";
      mergetool.vimdiff = true;
      pull.rebase = false;
      init.defaultBranch = "main";
      delta.side-by-side = true;
      delta.line-numbers = true;
    };
  };
}
