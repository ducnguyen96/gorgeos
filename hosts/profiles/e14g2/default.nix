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
    e14g2 = nixosSystem {
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

        # programs
        ../../modules/programs

        # security
        ../../modules/security

        # services, should have at least services/networking
        ../../modules/services

        # virtualization
        ../../modules/virtualization/podman.nix
        ../../modules/virtualization/libvirtd.nix
        ../../modules/virtualization/vagrant.nix

        {programs.nix-ld.enable = true;}

        {
          home-manager = {
            users.duc.imports = homeImports."duc@e14g2";
            extraSpecialArgs = specialArgs;
          };
        }
      ];
    };
  };
}
