{
  pkgs,
  inputs,
  lib,
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
    helix-gpt
    markdown-oxide

    # other lsp's
    marksman
  ];

  home.file.".config/helix/languages.toml".file = ./languages.toml;

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

  # programs.helix.languages = {
  #   language = [
  #     {
  #       name = "markdown";
  #       language-servers = [
  #         "marksman"
  #         "markdown-oxide"
  #         "lsp-ai"
  #       ];
  #     }
  #   ];

  #   language-server.lsp-ai = {
  #     command = "${lsp-ai}/bin/lsp-ai";
  #     config.memory = {
  #       file_store = {};
  #     };
  #     config.models.csonnet = {
  #       type = "anthropic";
  #       chat_endpoint = "https://api.anthropic.com/v1/messages";
  #       model = "claude-3-5-sonnet-20240620";
  #       auth_token_env_var_name = "ANTHROPIC_API_KEY";
  #     };
  #     config.chat = {
  #       trigger = "!C";
  #       action_display_name = "Chat";
  #       model = "csonnet";
  #       parameters = {
  #         max_context = 4096;
  #         max_tokens = 1024;
  #         system = "You are a code assistant chatbot. The user will ask you for assistance coding and you will do you best to answer succinctly and accurately";
  #       };
  #     };
  #   };

  #   language-server.typescript-language-server = with pkgs.nodePackages; {
  #     command = "${typescript-language-server}/bin/typescript-language-server";
  #     args = ["--stdio" "--tsserver-path=${typescript}/lib/node_modules/typescript/lib"];
  #   };
  # };
}
