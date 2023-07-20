{ ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        size = 18.0;
        normal = { family = "Source Code Pro"; };
        bold = { family = "Source Code Pro"; };
        italic = { family = "Source Code Pro"; };
      };
      env.TERM = "xterm-256color";
      shell = {
        program = "/run/current-system/sw/bin/bash";
        args = [ "-l" "-c" "tmux attach || tmux" ];
      };
    };
  };
}
