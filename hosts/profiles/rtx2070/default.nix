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
    rtx2070 = nixosSystem {
      inherit specialArgs;

      modules = [
        # must have
        ./configuration.nix

        # must have at least config/nix
        ../../modules/config

        # environment
        ../../modules/environment

        # hardware
        ../../modules/hardware/bluetooth.nix
        ../../modules/hardware/nvidia.nix

        # programs
        ../../modules/programs

        # security
        ../../modules/security

        # services, should have at least services/networking
        ../../modules/services

        # virtualization
        ../../modules/virtualization/docker.nix
        ../../modules/virtualization/libvirtd.nix

        {
          home-manager = {
            users.duc.imports = homeImports."duc@rtx2070";
            extraSpecialArgs = specialArgs;
          };
        }
      ];
    };
  };
}