let
  username = "john";
  homeDirectory = "/home/${username}";
  configName = ".config";
  configHome = "${homeDirectory}/${configName}";
in
  {lib, ...}: {
    imports = [
      ../../modules/home-manager/bash.nix
      ../../modules/home-manager/fzf.nix
      ../../modules/home-manager/git.nix
      ../../modules/home-manager/htop.nix
      ../../modules/home-manager/misc-terminal.nix
    ];

    home = lib.mkDefault {
      inherit username homeDirectory;
      file."${configName}/nixpkgs/config.nix".text = ''
        { allowUnfree = true; }
      '';
      stateVersion = "22.11";
    };

    xdg = {
      inherit configHome;
      enable = true;
    };

    programs.home-manager.enable = true;
  }
