{
  config,
  lib,
  pkgs,
  ...
}: let
  devLib = import ./mkDevOptions.nix {inherit lib;};
  cfg = config.dev.tex;
in {
  options.dev.tex = devLib.mkDevOptions "tex" {};

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs;
      lib.optionals (!cfg.useMasonLSP) [texlab]
      ++ lib.optionals cfg.asHomePkgs [texliveFull zathura];
  };
}
