{
  description = "john's nix config";

  inputs = {
    #nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # home-manager
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-unstable = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "unstable";
    };

    neorg-overlay.url = "github:nvim-neorg/nixpkgs-neorg-overlay";
  };

  outputs = { nixpkgs, home-manager, ... }@inputs: {
    # NixOS configuration entrypoint
    nixosConfigurations = let
      mkSystem = inputs: additionalModules:
        inputs.nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; }; # Pass flake inputs to our config
          modules = [
            inputs.home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
            }
          ] ++ additionalModules;
        };
    in {
      fw = mkSystem inputs [ ./nixos/fw/configuration.nix ];
      sync-pi = mkSystem inputs [ ./nixos/sync-pi/configuration.nix ];
      media-pi = mkSystem inputs [ ./nixos/media-pi/configuration.nix ];
      wsl = mkSystem inputs [ ./nixos/wsl/configuration.nix ];
    };

    # Standalone home-manager configuration entrypoint
    homeConfigurations = {
      "john@fw" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          config.allowUnfree = true;
        }; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {
          inherit inputs;
        }; # Pass flake inputs to our config
        modules = [ ./home-manager/john.nix ];
      };
      "john@wsl" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          config.allowUnfree = true;
        }; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {
          inherit inputs;
        }; # Pass flake inputs to our config
        modules = [ ./home-manager/johnterm.nix ];
      };
    };
  };
}
