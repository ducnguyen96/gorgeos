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
          ../modules/hardware/audio
          ../modules/hardware/gpu/intel.nix
          self.nixosModules.hyprland
          {home-manager.users.duc.imports = homeImports."gorgeos";}
        ]
        ++ sharedModules;
    };

    amd8700 = nixosSystem {
      modules =
        [
          ./amd8700
          ../modules/hardware/audio
          ../modules/hardware/gpu/amd.nix
          self.nixosModules.hyprland
          {home-manager.users.duc.imports = homeImports."gorgeos";}
        ]
        ++ sharedModules;
    };
  };
}
