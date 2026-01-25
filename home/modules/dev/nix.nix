{
  config,
  lib,
  pkgs,
  ...
}: let
  devLib = import ./mkDevOptions.nix {inherit lib;};
  cfg = config.dev.nix;
in {
  options.dev.nix = devLib.mkDevOptions "nix" {};

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs;
      lib.optionals (!cfg.useMasonLSP) [nil]
      ++ lib.optionals cfg.asHomePkgs [alejandra statix];
  };
}
