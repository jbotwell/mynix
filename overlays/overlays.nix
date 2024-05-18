{inputs, ...}: {
  nixpkgs = {
    overlays = [
      (self: super: {
        unstable = import inputs.unstable {
          system = super.system;
          config = super.config;
        };
      })
      (self: super: {ihaskell = super.lowPrio super.ihaskell;})
    ];
  };
}
