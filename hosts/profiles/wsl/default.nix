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
      system = "x86_64-linux";

      modules = [
        inputs.nixos-wsl.nixosModules.default

        # must have
        ./configuration.nix

        # must have at least config/nix
        ../../modules/config/nix
        ../../modules/config/fonts
        ../../modules/config/console.nix
        ../../modules/config/i18n.nix
        ../../modules/config/locale.nix
        ../../modules/config/users.nix

        # environment

        # hardware

        # programs, must have at least programs/home-manager
        ../../modules/programs/home-manager.nix

        # security
        {
          security.sudo.wheelNeedsPassword = false;
        }

        # services, should have at least services/networking
        ../../modules/services/networking.nix
        ../../modules/services/openssh.nix
        ../../modules/services/keyd.nix

        {
          home-manager = {
            users.duc.imports = homeImports."wsl";
            extraSpecialArgs = specialArgs;
          };
        }
      ];
    };
  };
}
