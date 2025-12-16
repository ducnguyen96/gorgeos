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
    e14g2-minimal = nixosSystem {
      inherit specialArgs;

      modules = [
        # must have
        ./configuration.nix

        # must have at least config/nix
        ../../modules/config/nix
        ../../modules/config/users.nix

        # environment

        # hardware
        inputs.disko.nixosModules.disko
        ../../modules/disko/e14g2.nix

        # programs, must have at least programs/home-manager
        ../../modules/programs/home-manager.nix

        # security

        # services, should have at least services/networking
        ../../modules/services/networking.nix
        ../../modules/services/openssh.nix

        {
          home-manager = {
            users.duc.imports = homeImports."duc@minimal";
            extraSpecialArgs = specialArgs;
          };
        }
      ];
    };
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
        inputs.disko.nixosModules.disko
        ../../modules/hardware/bluetooth.nix

        # programs
        ../../modules/programs
        ../../modules/programs/hyprland.nix

        # security
        ../../modules/security

        # services, should have at least services/networking
        ../../modules/services
        ../../modules/services/greetd.nix
        ../../modules/services/cloudflared.nix
        ../../modules/services/xrdp.nix
        ../../modules/services/gnome.nix
        {services.intune.enable = true;}

        # virtualization
        ../../modules/virtualization/docker.nix
        ../../modules/virtualization/libvirtd.nix
        # ../../modules/virtualization/vagrant.nix

        {programs.nix-ld.enable = true;}
        {services.xrdp.enable = true;}

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
