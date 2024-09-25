{
  pkgs,
  inputs,
  ...
}: let
  naersk = pkgs.callPackage inputs.naersk {};
  lsp-ai = naersk.buildPackage {
    src = inputs.lsp-ai;
    # buildInputs = [pkgs.openssl pkgs.pkg-config];
    OPENSSL_NO_VENDOR = 1;
  };
in {
  programs.helix.enable = true;

  programs.helix.extraPackages = with pkgs; [
    # helix-specific lsp's
    lsp-ai

    # lsp's
    # md
    markdown-oxide
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
      g = {q = ":reflow";};
    };
  };

  programs.helix.languages = {
    language = [
      {
        name = "markdown";
        language-servers = [
          "marksman"
          "markdown-oxide"
          "lsp-ai"
        ];
      }
    ];

    language-server = {
      lsp-ai = import ./lsp-ai.nix;

      typescript-language-server = with pkgs.nodePackages; {
        command = "${typescript-language-server}/bin/typescript-language-server";
        args = ["--stdio" "--tsserver-path=${typescript}/lib/node_modules/typescript/lib"];
      };
    };
  };
}
