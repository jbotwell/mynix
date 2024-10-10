{pkgs, ...}: let
  snipDir = ".config/helix/snippets";
  toml = pkgs.formats.toml {};
in {
  home.file."${snipDir}/snippets.toml".source = toml.generate "snippets" {
    snippets = [
      {
        prefix = "ld";
        scope = ["python"];
        body = ''log.debug("$1")'';
      }
    ];
  };

  home.file."${snipDir}/external-snippets.toml".source = toml.generate "external-snippets" {
    sources = [
      {
        name = "friendly-snippets";
        git = "https://github.com/rafamadriz/friendly-snippets.git";
        paths = [
          {
            scope = ["markdown"];
            path = "snippets/markdown/markdown.json";
          }
        ];
      }
    ];
  };
}
