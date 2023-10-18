{ ... }: {
  programs.tmux = {
    enable = true;
    shortcut = "a";
    keyMode = "vi";
    extraConfig = ''
      # Mouse works as expected
      set-option -g mouse on
      # easy-to-remember split pane commands
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"
      set-option -g focus-events on
      set -g default-terminal "tmux-256color"
      set -g base-index 1
    '';
  };
}
