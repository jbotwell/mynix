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

    js-debug = {
      url = "github:microsoft/vscode-js-debug";
      flake = false;
    };

    # my stuff
    my-bash-it = {
      url = "github:jbotwell/my_bash_it";
      flake = false;
    };

    my-nixvim.url = "github:jbotwell/nixvim";
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  } @ inputs: {
    nixosConfigurations = let
      mkSystem = modules:
        nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs;}; # Pass flake inputs to our config
          modules =
            [
              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
              }
            ]
            ++ modules;
        };
    in {
      fw = mkSystem [./hosts/fw/configuration.nix];
      mini = mkSystem [./hosts/mini/configuration.nix];
    };

    # Standalone home-manager configuration entrypoint
    homeConfigurations = {
      "john@fw" = let
        system = "x86_64-linux";
      in
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
          extraSpecialArgs = {inherit inputs system;};
          modules = [./hosts/fw/john.nix];
        };
      "john@mini" = let
        system = "x86_64-linux";
      in
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
          extraSpecialArgs = {inherit inputs system;};
          modules = [./hosts/mini/john.nix];
        };
    };
    # TODO remove this
    devShells.x86_64-linux.aider = import ./aider-shell.nix inputs;

    formatter = nixpkgs.alejandra;
  };
}
