{ inputs, system, ... }:

{
  nixpkgs = {
    overlays = [
      (self: super: {
        unstable = import inputs.unstable {
          inherit system;
          config = super.config;
        };
      })
      (self: super: { ihaskell = super.lowPrio super.ihaskell; })
    ];
  };
}
