{pkgs, ...}: {
  stylix.image = assets/spacedream.png;
  # stylix.image = assets/wp9734246-free-science-fiction-wallpapers.png;
  stylix.polarity = "dark";
  stylix.cursor.package = pkgs.borealis-cursors;
  stylix.cursor.name = "Borealis-cursors";
  stylix.fonts = {
    sizes = {
      desktop = 15;
      terminal = 15;
      popups = 15;
      applications = 15;
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
