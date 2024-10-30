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
    "${modules}/virtualization/libvirtd.nix"

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
              users.duc.imports = homeImports."duc@rtx2070";
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
            imports = [inputs.aagl.nixosModules.default];
            nix.settings = inputs.aagl.nixConfig; # Set up Cachix
            programs.anime-game-launcher.enable = true;
          }

          {
            home-manager = {
              users.duc.imports = homeImports."duc@e14g2";
              extraSpecialArgs = specialArgs;
            };
          }
        ];
    };

    hetzner = nixosSystem {
      inherit specialArgs;

      modules = [
        ./hetzner
        {
          # config module
          imports = [
            "${modules}/config/nix"
            "${modules}/config/console.nix"
            "${modules}/config/i18n.nix"
            "${modules}/config/locale.nix"
            "${modules}/config/users-groups.nix"
            "${modules}/security"
          ];
        }
        {
          # program module
          imports = [
            "${modules}/programs/bash.nix"
            "${modules}/programs/home-manager.nix"
            "${modules}/programs/zsh.nix"
          ];
        }
        {
          # serivces module
          imports = [
            "${modules}/services/networking.nix"
            "${modules}/services/openssh.nix"
            "${modules}/services/mail-server.nix"
          ];
        }
        {
          home-manager = {
            users.duc.imports = homeImports."duc@hetzner";
            extraSpecialArgs = specialArgs;
          };
        }
      ];
    };
  };
}
