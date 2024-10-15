{pkgs, ...}: {
  home.packages = with pkgs; [
    oils-for-unix
    zellij
  ];

  # TODO zellij

  home.file.".config/oil/oshrc".text = ''
    source ~/.bashrc
  '';

  home.file.".config/oil/oilrc".text = ''
    source ~/.bashrc
  '';

  programs.nushell = {
    enable = true;
    environmentVariables = {};
    shellAliases = {};
  };

  programs.bash = {
    enable = true;
  };

  programs.alacritty = {
    enable = true;
    settings = {
      env.TERM = "xterm-256color";
      shell = {
        program = "${pkgs.nushell}/bin/nu";
        args = ["-l" "-c" "zellij"];
      };
    };
  };

  programs.kitty = {
    enable = true;
    settings = {
      term = "xterm-256color";
      shell = "${pkgs.nushell}/bin/nu";
    };

    extraConfig = ''
      launch --type=os-window ${pkgs.zellij}/bin/zellij
    '';
  };
}
