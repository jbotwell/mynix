{pkgs, ...}: {
  programs.helix.enable = true;
  programs.helix.extraPackages = with pkgs; [
    # helix-specific lsp's
    helix-gpt
    markdown-oxide
  ];

  programs.helix.settings = {
    theme = "molokai";
    editor.line-number = "relative";
    editor.cursor-shape.insert = "bar";
    editor.cursor-shape.normal = "block";
    editor.cursor-shape.select = "underline";
    editor.file-picker.hidden = false;
  };

  programs.helix.languages = {
    language = [
      {
        name = "markdown";
        # language-servers = [ "marksman", "markdown-oxide", "hx-lsp" ];
        language-servers = ["hx-lsp"];
      }
    ];

    language-server.hx-lsp = with pkgs; {
      command = "${hx-lsp}/bin/hx-lsp";
    };

    language-server.typescript-language-server = with pkgs.nodePackages; {
      command = "${typescript-language-server}/bin/typescript-language-server";
      args = ["--stdio" "--tsserver-path=${typescript}/lib/node_modules/typescript/lib"];
    };
  };

  home.file.".config/helix/snippets" = {
    source = ./snippets;
    recursive = true;
  };
}
