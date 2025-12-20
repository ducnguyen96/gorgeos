{
  homeImports,
  inputs,
  self,
  ...
}: let
  inherit (inputs.nixpkgs.lib) nixosSystem;
  specialArgs = {inherit inputs self;};
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
        ../../modules/hardware/intel.nix
        inputs.disko.nixosModules.disko
        ./disko.nix

        ../../modules/hardware/bluetooth.nix

        # programs
        ../../modules/programs
        ../../modules/programs/hyprland.nix

        # security
        ../../modules/security

        # services, should have at least services/networking
        ../../modules/services
        ../../modules/services/greetd.nix
        ../../modules/services/i3.nix
        ../../modules/services/xrdp.nix
        ../../modules/services/cloudflared.nix

        # virtualization
        ../../modules/virtualization/docker.nix

        {programs.nix-ld.enable = true;}

        {
          home-manager = {
            users.duc.imports = homeImports."duc@desktop";
            extraSpecialArgs = specialArgs;
          };
        }
      ];
    };
  };
}
