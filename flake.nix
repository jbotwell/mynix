{
  description = "john's nix config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    pkgs23.url = "github:NixOs/nixpkgs/nixos-23.11";
    home-manager.url = "github:nix-community/home-manager";
    stylix.url = "github:danth/stylix";
    sops-nix.url = "github:Mic92/sops-nix";
    nix-bitcoin.url = "github:fort-nix/nix-bitcoin/release";
    naersk.url = "github:nix-community/naersk";

    lsp-ai = {
      url = "github:SilasMarvin/lsp-ai";
      flake = false;
    };

    scls = {
      url = "github:estin/simple-completion-language-server";
      flake = false;
    };

    # my stuff
    my-nixvim.url = "github:jbotwell/nixvim";
    my-bash-it = {
      url = "github:jbotwell/my_bash_it";
      flake = false;
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      stylix,
      nix-bitcoin,
      ...
    }@inputs:
    {
      nixosConfigurations =
        let
          bitcoinConfig = {
            systemd.tmpfiles.rules = [
              "d /mnt/data/bitcoind 0770 bitcoin bitcoin"
            ];
            services.bitcoind.dataDir = "/mnt/data/bitcoind";

            nix-bitcoin.generateSecrets = true;

            services.bitcoind.enable = true;
            services.electrs.enable = true;
            services.lnd.enable = true;
            services.rtl.enable = true;
            services.rtl.nodes.lnd.enable = true;

            nix-bitcoin.operator = {
              enable = true;
              name = "john";
            };
          };
          specialArgs = {
            inherit inputs;
          };
          xtxHome = ./hosts/xtx/john.nix;
          xtxNixos = ./hosts/xtx/configuration.nix;
          fwHome = ./hosts/fw/john.nix;
          fwNixos = ./hosts/fw/configuration.nix;
          miniHome = ./hosts/mini/john.nix;
          miniNixos = ./hosts/mini/configuration.nix;
          mkSystem =
            hm-module: otherModules:
            nixpkgs.lib.nixosSystem {
              inherit specialArgs;
              modules = [
                home-manager.nixosModules.home-manager
                {
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                  home-manager.extraSpecialArgs = specialArgs;
                  home-manager.users.john = import hm-module;
                }
              ] ++ otherModules;
            };
        in
        {
          fw = mkSystem fwHome [
            fwNixos
            stylix.nixosModules.stylix
          ];
          mini = mkSystem miniHome [
            miniNixos
            nix-bitcoin.nixosModules.default
            bitcoinConfig
          ];
          xtx = mkSystem xtxHome [
            xtxNixos
            stylix.nixosModules.stylix
          ];
        };

      homeConfigurations = {
        "john@work" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "aarch64-darwin";
            config.allowUnfree = true;
            config.permittedInsecurePackages = [
              "electron-25.9.0"
            ];
          };
          extraSpecialArgs = {
            inherit inputs;
          };
          modules = [ ./hosts/work/john.nix ];
        };
      };

      formatter = nixpkgs.nixfmt-rfc-style;
    };
}
