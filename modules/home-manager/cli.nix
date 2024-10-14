{ pkgs, ...}: {

  # TODO zellij
  # TODO kitty
  # TODO pet
  # TODO oils
  # TODO tre
  # TODO duf
  # TODO diskonaut
  # TODO ast-grep
  # TODO yazi
  # TODO just

  home.packages = with pkgs; [
    aider-chat
    delta
    eza
    fd
    jq
    the-fuck
    zoxide
  ];

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    defaultCommand = "fd --type file --follow";
    defaultOptions = ["--height 30%"];
    fileWidgetCommand = "fd --type file --follow";
  };
}
