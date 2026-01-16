{
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
        ./hardware.nix

        # programs
        ../../modules/programs/bash.nix
        ../../modules/programs/home-manager.nix
        ../../modules/programs/hyprland.nix
        ../../modules/programs/zsh.nix

        # security
        ../../modules/security

        # services, should have at least services/networking
        ../../modules/services/blueman.nix
        ../../modules/services/greetd.nix
        ../../modules/services/keyd.nix
        ../../modules/services/networking.nix
        ../../modules/services/openssh.nix
        ../../modules/services/pipewire.nix

        # virtualization
        ../../modules/virtualization/docker.nix
      ];
    };
  };
}
