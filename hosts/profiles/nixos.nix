{inputs, ...}: let
  inherit (inputs.nixpkgs.lib) nixosSystem;
  specialArgs = {inherit inputs;};

  defaultModules = [
    # must have at least config/nix
    ../modules/config

    # environment
    ../modules/environment

    # programs
    ../modules/programs/bash.nix
    ../modules/programs/hyprland.nix
    ../modules/programs/zsh.nix
    {programs.nix-ld.enable = true;}

    # security
    ../modules/security

    # services, should have at least services/networking
    ../modules/services/greetd.nix
    ../modules/services/keyd.nix
    ../modules/services/networking.nix
    ../modules/services/openssh.nix
    ../modules/services/pipewire.nix
    ../modules/services/gnome-keyring.nix

    # virtualization
    ../modules/virtualization/docker.nix
  ];
in {
  "5560" = nixosSystem {
    inherit specialArgs;
    system = "x86_64-linux";

    modules = [./5560/configuration.nix ./5560/hardware.nix ../modules/services/blueman.nix] ++ defaultModules;
  };

  "e14g2" = nixosSystem {
    inherit specialArgs;
    system = "x86_64-linux";

    modules = [./e14g2/configuration.nix ./e14g2/hardware.nix ../modules/services/blueman.nix] ++ defaultModules;
  };

  "rtx2070" = nixosSystem {
    inherit specialArgs;
    system = "x86_64-linux";

    modules = [./rtx2070/configuration.nix ./rtx2070/hardware.nix ../modules/services/blueman.nix] ++ defaultModules;
  };

  "mac" = nixosSystem {
    inherit specialArgs;
    system = "aarch64-linux";

    modules = [./mac/configuration.nix ./mac/hardware.nix] ++ defaultModules;
  };
}
