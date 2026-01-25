{
  config,
  lib,
  pkgs,
  ...
}: let
  devLib = import ./mkDevOptions.nix {inherit lib;};
  cfg = config.dev.go;
in {
  options.dev.go = devLib.mkDevOptions "go" {};

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs;
      lib.optionals (!cfg.useMasonLSP) [gopls]
      ++ lib.optionals cfg.asHomePkgs [go air gcc15];
  };
}
