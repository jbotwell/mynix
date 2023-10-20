{ pkgs, ... }:

let myHaskells = ps: with ps; [ stack ];
in {
  home.packages = with pkgs; [
    (haskellPackages.ghcWithPackages myHaskells)
    ihaskell
  ];
}
