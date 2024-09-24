{pkgs, ...}: {
  programs.helix.enable = true;
  programs.helix.extraPackages = with pkgs; [
    # helix-specific lsp's
    helix-gpt
    markdown-oxide

    # other lsp's
    marksman
  ];

  programs.helix.settings = {
    editor = {
      line-number = "relative";
      cursor-shape.insert = "bar";
      cursor-shape.normal = "block";
      cursor-shape.select = "underline";
      file-picker.hidden = false;
    };

    keys.normal = {
      C-b = "increment";
    };
  };

  programs.helix.languages = {
    language = [
      {
        name = "markdown";
        language-servers = ["marksman" "markdown-oxide"];
      }
    ];

    language-server.typescript-language-server = with pkgs.nodePackages; {
      command = "${typescript-language-server}/bin/typescript-language-server";
      args = ["--stdio" "--tsserver-path=${typescript}/lib/node_modules/typescript/lib"];
    };
  };
}
