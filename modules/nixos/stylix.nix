{pkgs, ...}: {
  stylix.enable = true;
  stylix.image = assets/spacedream.png;
  stylix.polarity = "dark";
  stylix.cursor.package = pkgs.bibata-cursors;
  stylix.cursor.name = "Bibata-Modern-Ice";
  stylix.fonts = {
    sizes = {
      desktop = 22;
      terminal = 22;
      popups = 22;
      applications = 22;
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
      package = pkgs.nerdfonts;
      name = "mononoki Nerd Font";
    };

    emoji = {
      package = pkgs.nerdfonts;
      name = "mononoki Nerd Font";
    };
  };
}
