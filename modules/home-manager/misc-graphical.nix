{pkgs, ...}: {
  home.packages = with pkgs; [
    anki
    calibre
    firefox
    pkgs23.obsidian
    signal-desktop
    slack
    ungoogled-chromium
    vlc
    zathura
  ];
}
