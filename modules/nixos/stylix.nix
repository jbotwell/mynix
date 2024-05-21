{pkgs, ...}: {
  stylix.image = assets/spacedream.png;
  # stylix.image = assets/wp9734246-free-science-fiction-wallpapers.png;
  stylix.fonts = {
    serif = {
      package = pkgs.nerdfonts;
      name = "Monoid Serif";
    };

    sansSerif = {
      package = pkgs.nerdfonts;
      name = "Monoid Sans";
    };

    monospace = {
      package = pkgs.nerdfonts;
      name = "Monoid Sans Mono";
    };

    emoji = {
      package = pkgs.nerdfonts;
      name = "Noto Color Emoji";
    };
  };
}
