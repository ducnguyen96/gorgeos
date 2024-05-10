{
  homeImports,
  inputs,
  self,
  themes,
  ...
}: let
  inherit (inputs.nixpkgs.lib) nixosSystem;

  modules = "${self}/modules/system";
  hardware = modules + "/hardware";
  profiles = "${self}/hosts/profiles";

  specialArgs = {inherit inputs self themes;};
in {
  flake.nixosConfigurations = {
    amd8700 = nixosSystem {
      inherit specialArgs;

      modules = [
        ./amd8700

        "${modules}/config"
        "${modules}/programs"
        "${modules}/security"
        "${modules}/services"
        "${modules}/virtualization/docker.nix"
        "${hardware}/bluetooth.nix"
        "${hardware}/intel.nix"
        "${hardware}/amd.nix"
        "${profiles}/hyprland"

        {
          home-manager = {
            users.duc.imports = homeImports."duc@hyprland";
            extraSpecialArgs = specialArgs;
          };
        }
      ];
    };
  };
}
