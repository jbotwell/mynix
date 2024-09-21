{pkgs, ...}: {
  home.packages = with pkgs; [
    exercism
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

    # others
    nmap
    ffmpeg
    pass
    nix-prefetch-git
    manix
    nh
    ast-grep
    alejandra
    openssl
  ];
}
