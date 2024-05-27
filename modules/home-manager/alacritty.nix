{...}: {
  programs.alacritty = {
    enable = true;
    settings = {
      env.TERM = "xterm-256color";
      shell = {
        program = "/run/current-system/sw/bin/bash";
        args = ["-l" "-c" "tmux"];
      };
    };
  };
}
