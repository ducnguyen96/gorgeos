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
          self.nixosModules.hyprland
          {home-manager.users.duc.imports = homeImports."gorgeos";}
        ]
        ++ sharedModules;
    };
  };
}
