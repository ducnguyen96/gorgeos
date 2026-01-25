{
  config,
  lib,
  pkgs,
  ...
}: let
  devLib = import ./mkDevOptions.nix {inherit lib;};
  cfg = config.dev.python;
in {
  options.dev.python = devLib.mkDevOptions "python" {};

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs;
      lib.optionals (!cfg.useMasonLSP) [ruff]
      ++ lib.optionals cfg.asHomePkgs [];
  };
}
