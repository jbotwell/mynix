{
  description = "john's nix config";

  inputs = {
    #nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # home-manager
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-unstable = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "unstable";
    };
  };

  outputs = { nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations = let
      mkSystem = modules:
        nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; }; # Pass flake inputs to our config
          modules = [
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
            }
          ] ++ modules;
        };
    in {
      fw = mkSystem [ ./hosts/fw/configuration.nix ];
      mini = mkSystem [ ./hosts/fw/configuration.nix ];
    };

    # Standalone home-manager configuration entrypoint
    homeConfigurations = {
      "john@fw" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          config.allowUnfree = true;
          # TODO: remove when obsidian is unborked by their devs
          config.permittedInsecurePackages = [ "electron-25.9.0" ];
        }; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {
          inherit inputs;
        }; 
        modules = [ ./hosts/fw/john.nix ];
      };
    };
  };
}
