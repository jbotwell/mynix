{...}: {
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal = {
          family = "NotoMono Nerd Font";
          style = "Regular";
        };
        bold = {
          family = "NotoMono Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "NotoMono Nerd Font";
          style = "Italic";
        };
        bold_italic = {
          family = "NotoMono Nerd Font";
          style = "Bold Italic";
        };
        size = 22.0;
      };
      env.TERM = "xterm-256color";
      shell = {
        program = "/opt/homebrew/bin/bash";
        args = ["-l" "-c" "tmux"];
      };
    };
  };
}
