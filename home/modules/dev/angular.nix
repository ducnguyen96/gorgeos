{
  config,
  lib,
  pkgs,
  ...
}: let
  devLib = import ./mkDevOptions.nix {inherit lib;};
  cfg = config.dev.angular;
in {
  options.dev.angular = devLib.mkDevOptions "angular" {};

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs;
      lib.optionals (!cfg.useMasonLSP) []
      ++ lib.optionals cfg.asHomePkgs [];
  };
}
