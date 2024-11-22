{
  homeImports,
  inputs,
  self,
  themes,
  ...
}: let
  inherit (inputs) nixpkgs nix-on-droid home-manager;
  inherit (nix-on-droid.lib) nixOnDroidConfiguration;
  extraSpecialArgs = {inherit inputs self themes;};
in {
  flake.nixOnDroidConfigurations = {
    pixel5 = nixOnDroidConfiguration {
      modules = [
        ./configuration.nix
        ../../modules/nix-on-droid/environment.nix
        ../../modules/nix-on-droid/nix.nix

        ../../modules/nix-on-droid/services/openssh.nix

        {
          home-manager = {
            inherit extraSpecialArgs;
            config = homeImports."pixel5";
            backupFileExtension = "hm-bak";
            useGlobalPkgs = true;
          };
        }
      ];

      # set nixpkgs instance, it is recommended to apply `nix-on-droid.overlays.default`
      pkgs = import nixpkgs {
        system = "aarch64-linux";

        overlays = [
          nix-on-droid.overlays.default
          # add other overlays
        ];
      };

      home-manager-path = home-manager.outPath;
    };
  };
}
