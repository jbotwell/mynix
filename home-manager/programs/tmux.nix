{ ... }: {
  programs.tmux = {
    enable = true;
    terminal = "tmux-256color-italic";
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

  # may need to run `tic ~/.config/tmux-256color-italic.terminfo`
  home.file.".config/tmux-256color-italic.terminfo".text = ''
    tmux-256color-italic|tmux with 256 colors and italic,
      sitm=\E[3m, ritm=\E[23m,
      use=tmux-256color,
  '';
}
