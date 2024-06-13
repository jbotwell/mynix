{pkgs, ...}: {
  stylix.enable = true;
  stylix.image = assets/spacedream.png;
  stylix.polarity = "dark";
  stylix.cursor.package = pkgs.bibata-cursors;
  stylix.cursor.name = "Bibata-Modern-Ice";
  stylix.fonts = {
    sizes = {
      desktop = 18;
      terminal = 18;
      popups = 18;
      applications = 18;
    };
    serif = {
      package = pkgs.noto-fonts;
      name = "Noto Serif";
    };

    sansSerif = {
      package = pkgs.noto-fonts;
      name = "Noto Sans";
    };

    monospace = {
      package = pkgs.noto-fonts;
      name = "Noto Sans Mono";
    };

    emoji = {
      package = pkgs.noto-fonts;
      name = "Noto Color Emoji";
    };
  };
}
