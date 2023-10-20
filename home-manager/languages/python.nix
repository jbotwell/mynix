{ pkgs, ... }:

let myPythons = ps: with ps; [ jupyter jupyterlab ilua ];
in { home.packages = with pkgs; [ (python311.withPackages myPythons) ]; }
