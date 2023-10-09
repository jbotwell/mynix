{ pkgs, ... }:

{
  fonts.enableDefaultFonts = true;
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
    font-awesome
    ubuntu_font_family
  ];
}
