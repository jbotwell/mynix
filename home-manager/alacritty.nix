{ ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
      shell = {
        program = "/bin/bash";
        args = [ "-l" "-c" "tmux attach || tmux" ];
      };
    };
  };
}
