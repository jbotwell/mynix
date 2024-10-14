{
  pkgs,
  inputs,
  ...
}: let
  naersk = pkgs.callPackage inputs.naersk {};
  lsp-ai = naersk.buildPackage {
    src = inputs.lsp-ai;
    OPENSSL_NO_VENDOR = 1;
  };
  scls = naersk.buildPackage {
    src = inputs.scls;
    OPENSSL_NO_VENDOR = 1;
  };
  sclsCmd = "${scls}/bin/simple-completion-language-server";
in {
  programs.helix.enable = true;

  programs.helix.extraPackages = with pkgs; [
    # helix-specific lsp's
    lsp-ai

    # lsp's
    # md
    markdown-oxide
    marksman

    # formatters
    nixfmt-rfc-style
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
      g = {
        q = ":reflow";
        j = "goto_line_start";
        k = "goto_line_end";
      };
      j = "move_char_left";
      k = "move_char_right";
      l = "move_visual_line_up";
      h = "move_visual_line_down";
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
          "scls"
        ];
      }
      {
        name = "nix";
        language-servers = [
          "nil"
          "lsp-ai"
          "scls"
        ];
        formatter = {
          command = "nixfmt"
        }
      }
    ];

    language-server = {
      lsp-ai = {
        command = "${lsp-ai}/bin/lsp-ai";
        config = import ./lsp-ai.nix;
      };

      nil = {
        command = "${pkgs.nil}/bin/nil";
      };

      scls = {
        command = "${sclsCmd}";
      };

      typescript-language-server = with pkgs.nodePackages; {
        command = "${typescript-language-server}/bin/typescript-language-server";
        args = ["--stdio" "--tsserver-path=${typescript}/lib/node_modules/typescript/lib"];
      };
    };
  };
}
