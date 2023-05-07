{ ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
      shell = {
        program = "/run/current-system/sw/bin/bash";
        args = [ "-l" "-c" "tmux attach || tmux" ];
      };
    };
  };
}
