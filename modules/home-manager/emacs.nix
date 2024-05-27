{pkgs, ...}: {
  programs.emacs.enable = true;
  programs.emacs.package = pkgs.emacsPackages.emacs;
  home.file = {
    ".config/doom" = {
      source = ./doom-emacs;
      recursive = true;
    };
  };
}
