{ pkgs, ... }:

let
  myPythons = ps:
    with ps; [
      # for the correct working of Jupyter + Magma
      jupyter
      jupyterlab
      ilua
      pynvim
      ueberzug
      pillow
      pnglatex
      plotly
      pyperclip
    ];
in {
  home.packages = with pkgs.unstable; [ (python312.withPackages myPythons) ];
}
