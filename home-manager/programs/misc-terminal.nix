{ pkgs, ... }:

{
  home.packages = with pkgs; [
    exercism
    dotnet-sdk_7
    xclip

    # modern unix
    bat
    eza
    lsd
    delta 
    du-dust
    duf
    broot
    fd
    ripgrep
    silver-searcher
    mcfly
    choose
    jq
    sd
    cheat
    tldr
    bottom
    glances
    gtop
    hyperfine
    gping
    procs
    httpie
    curlie
    xh
    zoxide
    dog

    thefuck
    nmap
    ffmpeg
    pass
    nix-prefetch-git
  ];

  programs.bash.sessionVariables = { DOTNET_ROOT = "${pkgs.dotnet-sdk_7}"; };
}
