{
  description = "john's nix config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    stylix.url = "github:danth/stylix";
    my-nixvim.url = "github:jbotwell/nixvim";

    my-bash-it = {
      url = "github:jbotwell/my_bash_it";
      flake = false;
    };

    js-debug = {
      url = "github:microsoft/vscode-js-debug";
      flake = false;
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    stylix,
    ...
  } @ inputs: {
    nixosConfigurations = let
      mkSystem = hm-module: modules:
        nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs;}; # Pass flake inputs to our config
          modules =
            [
              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.extraSpecialArgs = {inherit inputs;};
                home-manager.users.john = import hm-module;
              }
            ]
            ++ modules;
        };
    in {
      fw = mkSystem ./hosts/fw/john.nix [./hosts/fw/configuration.nix];
      mini = mkSystem ./hosts/mini/john.nix [./hosts/mini/configuration.nix];
      xtx = mkSystem ./hosts/xtx/john.nix [./hosts/xtx/configuration.nix stylix.nixosModules.stylix];
    };

    formatter = nixpkgs.alejandra;
  };
}
