{ inputs, ... }:

{
  nixpkgs = {
    overlays = [
      (self: super: {
        unstable = import inputs.unstable {
          system = super.system;
          config = super.config;
        };
      })
      (self: super: { ihaskell = super.lowPrio super.ihaskell; })
      (self: super:
        let
          ogpt-nvim = super.vimUtils.buildVimPlugin {
            name = "ogpt-nvim";
            src = inputs.ogpt-nvim;
          };
        in { vimPlugins = super.vimPlugins // { inherit ogpt-nvim; }; })
    ];
  };
}
