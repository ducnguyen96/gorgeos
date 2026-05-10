{inputs, ...}: let
  inherit (inputs.nix-on-droid.lib) nixOnDroidConfiguration;
in {
  droid = nixOnDroidConfiguration {
    pkgs = import inputs.nixpkgs {
      system = "aarch64-linux";

      overlays = [inputs.nix-on-droid.overlays.default];
    };

    modules = [
      ./nix.nix
      ./configuration.nix
      ./environment.nix
      ./user.nix
    ];
  };
}
