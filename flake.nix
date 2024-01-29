{
  description = "john's nix config";

  inputs = {
    #nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # darwin
    darwin.url = "github:NixOS/nixpkgs/nixpkgs-23.05-darwin";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # home-manager
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-unstable = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "unstable";
    };

    # darwin home-manager
    # darwin-home-manager = {
    #   url = "github:nix-community/home-manager/release-23.05";
    #   inputs.nixpkgs.follows = "darwin";
    # };
    # darwin-home-unstable = {
    #   url = "github:nix-community/home-manager";
    #   inputs.nixpkgs.follows = "nixpkgs-unstable";
    # };
  };

  outputs = { nixpkgs, home-manager, darwin, ... }@inputs: {
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
        }; # Pass flake inputs to our config
        modules = [ ./home-manager/john.nix ];
      };
      "john@work" = home-manager.lib.homeManagerConfiguration {
        pkgs = import darwin {
          system = "aarch64-darwin";
          config.allowUnfree = true;
        }; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {
          inputs.nixpkgs = inputs.darwin;
          inputs.unstable = inputs.nixpkgs-unstable;
        }; # Pass flake inputs to our config
        modules = [ ./home-manager/john-work.nix ];
      };
    };
  };
}
