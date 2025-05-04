{
  homeImports,
  inputs,
  ...
}: let
  inherit (inputs) nixpkgs nix-on-droid home-manager;
  inherit (nix-on-droid.lib) nixOnDroidConfiguration;
  extraSpecialArgs = {inherit inputs;};
in {
  flake.nixOnDroidConfigurations = {
    droid = nixOnDroidConfiguration {
      modules = [
        ./configuration.nix
        ../../modules/nix-on-droid/environment.nix
        ../../modules/nix-on-droid/nix.nix

        {
          home-manager = {
            inherit extraSpecialArgs;
            config = homeImports."droid";
            backupFileExtension = "hm-bak";
            useGlobalPkgs = true;
          };
        }
      ];

      # set nixpkgs instance, it is recommended to apply `nix-on-droid.overlays.default`
      pkgs = import nixpkgs {
        system = "aarch64-linux";

        config.allowUnfree = true;

        overlays = [
          nix-on-droid.overlays.default
          (self: super: {
            direnv = super.direnv.overrideAttrs (oldAttrs: {
              doCheck = false;
            });
          })
          # add other overlays
        ];
      };

      home-manager-path = home-manager.outPath;
    };
  };
}
