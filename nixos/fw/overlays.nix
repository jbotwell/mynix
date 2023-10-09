{ inputs, ... }:

{
  nixpkgs = {
    overlays = [
      (self: super: {
        unstable = import inputs.unstable {
          system = "x86_64-linux";
          config = super.config;
        };
      })
      (self: super: {
        neovim = super.neovim.override {
          viAlias = true;
          vimAlias = true;
        };
      })
    ];
  };
}
