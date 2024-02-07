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
in { home.packages = with pkgs; [ (python311.withPackages myPythons) ]; }
