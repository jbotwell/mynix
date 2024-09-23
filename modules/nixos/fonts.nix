{pkgs, ...}: {
  fonts.enableDefaultPackages = true;
  fonts.packages = with pkgs; [
    nerdfonts
    font-awesome
    ubuntu_font_family
  ];
}
