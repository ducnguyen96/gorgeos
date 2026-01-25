{inputs, ...}: let
  inherit (inputs) nix-on-droid home-manager;
in {
  flake.nixOnDroidConfigurations = {
    droid = nix-on-droid.lib.nixOnDroidConfiguration {
      pkgs = import inputs.nixpkgs {
        system = "aarch64-linux";

        overlays = [
          nix-on-droid.overlays.default
          # add other overlays
        ];
      };

      modules = [
        ./config.nix
        ./environment.nix
        ./home.nix
        ./nix.nix
        ./user.nix
      ];

      home-manager-path = home-manager.outPath;
    };
  };
}
