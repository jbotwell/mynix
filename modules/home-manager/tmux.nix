{...}: {
  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    shortcut = "a";
    mouse = true;
    keyMode = "vi";
    extraConfig = ''
      # easy-to-remember split pane commands
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"
      set-option -g focus-events on
      set -g base-index 1
    '';
  };
}
