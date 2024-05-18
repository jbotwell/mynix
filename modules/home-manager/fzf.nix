{...}: {
  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    defaultCommand = "fd --type file --follow";
    defaultOptions = ["--height 30%"];
    fileWidgetCommand = "fd --type file --follow";
  };
}
