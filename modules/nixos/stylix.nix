{pkgs, ...}: {
  stylix.image = assets/test_image.png;
  stylix.polarity = "dark";
  stylix.cursor.package = pkgs.vimix-cursors;
  stylix.cursor.name = "Vimix Cursors";
  stylix.fonts = {
    sizes = {
      desktop = 20;
      terminal = 20;
      popups = 20;
      applications = 20;
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
