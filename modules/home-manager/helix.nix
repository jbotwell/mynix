{pkgs, ...}: {
  home.packages = with pkgs; [
    helix
    # lsp
    helix-gpt
    markdown-oxide
  ];
}
