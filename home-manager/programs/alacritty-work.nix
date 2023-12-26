{ ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        size = 20.0;
        normal = { family = "Hack Nerd Font"; };
        bold = { family = "Hack Nerd Font"; };
        italic = { family = "Hack Nerd Font"; };
      };
      env.TERM = "xterm-256color";
      shell = {
        program = "/opt/homebrew/bin/bash";
        args = [ "-l" "-c" "tmux" ];
      };
    };
  };
}
