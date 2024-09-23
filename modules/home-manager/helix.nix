{pkgs, ...}: {
  home.packages = with pkgs; [
    helix
    # lsp
    helix-gpt
    markdown-oxide
  ];

  home.file.".config/helix/config.toml".source = ./helix/config.toml;
}
