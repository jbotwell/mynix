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
  };

  outputs = {
    nixpkgs,
    home-manager,
    stylix,
    ...
  } @ inputs: {
    nixosConfigurations = let
      specialArgs = {inherit inputs;};
      mkSystem = hm-module: otherModules:
        nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          modules =
            [
              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.extraSpecialArgs = specialArgs;
                home-manager.users.john = import hm-module;
              }
            ]
            ++ otherModules;
        };
    in {
      fw = mkSystem ./hosts/fw/john.nix [./hosts/fw/configuration.nix stylix.nixosModules.stylix];
      mini = mkSystem ./hosts/mini/john.nix [./hosts/mini/configuration.nix];
      xtx = mkSystem ./hosts/xtx/john.nix [./hosts/xtx/configuration.nix stylix.nixosModules.stylix];
    };

    formatter = nixpkgs.alejandra;
  };
}
