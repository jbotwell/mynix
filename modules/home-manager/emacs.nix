{ pkgs, ... }:

{
  programs.emacs.enable = true;
  programs.emacs.package = pkgs.unstable.emacsPackages.emacs;
  # TODO: do the doom thing with flakes
}
