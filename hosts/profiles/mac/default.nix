{
  inputs,
  self,
  ...
}: let
  inherit (inputs.nix-darwin.lib) darwinSystem;
  specialArgs = {inherit inputs self;};
in {
  flake.darwinConfigurations = {
    mac = darwinSystem {
      inherit specialArgs;

      modules = [
        ./nix.nix
        ./environment.nix
        ./programs.nix

        ../../modules/services/skhd.nix
        ../../modules/services/yabai.nix
      ];
    };
  };
}
