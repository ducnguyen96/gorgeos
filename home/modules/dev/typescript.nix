{
  config,
  lib,
  pkgs,
  ...
}: let
  devLib = import ./mkDevOptions.nix {inherit lib;};
  cfg = config.dev.typescript;
in {
  options.dev.typescript = devLib.mkDevOptions "typescript" {};

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs;
      lib.optionals (!cfg.useMasonLSP) [vtsls]
      ++ lib.optionals cfg.asHomePkgs [
        fnm
        yarn
        prettier
        eslint
        eslint_d
      ];
  };
}
