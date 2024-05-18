{ pkgs, ... }:
let
  ctags-hook = pkgs.writeShellScript "ctags-hook.sh" ''
    git ls-files | ctags -f .git/.tags --tag-relative -L -
  '';
in {
  programs.git = {
    enable = true;
    delta.enable = true;
    userName = "John Otwell";
    userEmail = "john.otwell@protonmail.com";
    ignores = [ "/tags" ];
    hooks = {
      post-commit = ctags-hook;
      post-checkout = ctags-hook;
      post-merge = ctags-hook;
      post-rewrite = pkgs.writeShellScript "ctags-rewrite-hook.sh" ''
        case "$1" in
          rebase) git ls-files | ctags -f .git/.tags --tag-relative -L - ;;
        esac
      '';
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
