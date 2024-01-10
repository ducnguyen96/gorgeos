{
  self,
  inputs,
  homeImports,
  sharedModules,
  ...
}: {
  flake.nixosConfigurations = let
    inherit (inputs.nixpkgs.lib) nixosSystem;
  in {
    e14g2 = nixosSystem {
      modules =
        [
          ./e14g2
        ]
        ++ sharedModules;
    };
  };
}
