{
  config,
  lib,
  pkgs,
  ...
}: let
  devLib = import ./mkDevOptions.nix {inherit lib;};
  cfg = config.dev.php;
in {
  options.dev.php = devLib.mkDevOptions "php" {};

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs;
      lib.optionals (!cfg.useMasonLSP) [intelephense]
      ++ lib.optionals cfg.asHomePkgs [php];
  };
}
