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
    rtx2070 = nixosSystem {
      inherit specialArgs;

      modules = [
        ./rtx2070

        "${hardware}/nvidia.nix"
        "${hardware}/bluetooth.nix"

        "${modules}/config"
        "${modules}/programs"
        "${modules}/security"
        "${modules}/services"
        "${profiles}/hyprland"

        "${modules}/virtualization/docker.nix"
        {
          home-manager = {
            users.duc.imports = homeImports."duc@hyprland";
            extraSpecialArgs = specialArgs;
          };
        }
      ];
    };

    e14g2 = nixosSystem {
      inherit specialArgs;

      modules = [
        ./e14g2

        "${hardware}/bluetooth.nix"

        "${modules}/config"
        "${modules}/programs"
        "${modules}/security"
        "${modules}/services"
        "${profiles}/hyprland"

        "${modules}/virtualization/docker.nix"

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
