{ pkgs, ... }:

let myHaskells = ps: with ps; [ stack ihaskell ];
in {
  home.packages = with pkgs; [ (haskellPackages.ghcWithPackages myHaskells) ];
}
