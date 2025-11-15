{
  homeImports,
  inputs,
  ...
}: let
  inherit (inputs.nixpkgs.lib) nixosSystem;
  specialArgs = {inherit inputs;};
in {
  flake.nixosConfigurations = {
    cloud = nixosSystem {
      inherit specialArgs;

      modules = [
        # must have
        ./configuration.nix

        # must have at least config/nix
        ../../modules/config/nix
        ../../modules/config/users.nix

        # environment

        # hardware

        # programs, must have at least programs/home-manager
        ../../modules/programs/home-manager.nix

        # security

        # services, should have at least services/networking
        ../../modules/services/networking.nix
        ../../modules/services/openssh.nix

        ../../common/nginx.nix
        {
          home-manager = {
            users.duc.imports = homeImports."duc@cloud";
            extraSpecialArgs = specialArgs;
          };
        }
      ];
    };
  };
}
