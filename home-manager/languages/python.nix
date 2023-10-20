{ pkgs, ... }:

let
  myPythons = ps:
    with ps; [
      jupyter
      jupyterlab
      ilua
      pynvim
      ueberzug
      pillow
      # cairosvg
      pnglatex
      plotly
      pyperclip
    ];
in { home.packages = with pkgs; [ (python311.withPackages myPythons) ]; }
