{ pkgs, ... }:

{
  home.packages = with pkgs; [
    calibre
    libreoffice
    signal-desktop
    slack
    vlc
    zathura
    zoom-us
    anki
    unstable.obsidian
    raven-reader
    ungoogled-chromium
    firefox
    unstable.vscode
  ];
}
