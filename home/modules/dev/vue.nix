{
  config,
  lib,
  pkgs,
  ...
}: let
  devLib = import ./mkDevOptions.nix {inherit lib;};
  cfg = config.dev.vue;
in {
  options.dev.vue = devLib.mkDevOptions "vue" {};

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs;
      lib.optionals (!cfg.useMasonLSP) []
      ++ lib.optionals cfg.asHomePkgs [];
  };
}
