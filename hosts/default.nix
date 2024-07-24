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

  sharedModules = [
    "${hardware}/bluetooth.nix"

    "${modules}/config"
    "${modules}/programs"
    "${modules}/security"
    "${modules}/services"
    "${profiles}/hyprland"

    "${modules}/virtualization/docker.nix"

    {
      hardware.i2c.enable = true;
      hardware.graphics = {
        enable = true;
        enable32Bit = true;
      };
    }
  ];
in {
  flake.nixosConfigurations = {
    rtx2070 = nixosSystem {
      inherit specialArgs;

      modules =
        sharedModules
        ++ [
          ./rtx2070

          "${hardware}/nvidia.nix"
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

      modules =
        sharedModules
        ++ [
          ./e14g2

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
