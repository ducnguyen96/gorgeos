{
  homeImports,
  inputs,
  self,
  themes,
  ...
}: let
  inherit (inputs.nixpkgs.lib) nixosSystem;
  specialArgs = {inherit inputs self themes;};
in {
  flake.nixosConfigurations = {
    rpi4 = nixosSystem {
      inherit specialArgs;
      system = "aarch64-linux";

      modules = [
        inputs.raspberry-pi-nix.nixosModules.raspberry-pi
        inputs.raspberry-pi-nix.nixosModules.sd-image

        # must have
        ./configuration.nix

        # must have at least config/nix
        ../../modules/config/nix
        ../../modules/config/users.nix

        # environment

        # hardware
        ../../modules/hardware/raspberry-pi.nix

        # programs, must have at least programs/home-manager
        ../../modules/programs/home-manager.nix

        # security

        # services, should have at least services/networking
        ../../modules/services/networking.nix
        ../../modules/services/wifi.nix
        {
          networking.wireless.networks = {
            "Nguyen Van Phuoc_5G" = {psk = "1234567890a";};
            "SamNgaos" = {psk = "matkhaula00";};
          };
        }
        ../../modules/services/openssh.nix

        {
          home-manager = {
            users.duc.imports = homeImports."duc@rpi4";
            extraSpecialArgs = specialArgs;
          };
        }
      ];
    };
  };
}
