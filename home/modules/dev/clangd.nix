{
  config,
  lib,
  pkgs,
  ...
}: let
  devLib = import ./mkDevOptions.nix {inherit lib;};
  cfg = config.dev.clangd;
in {
  options.dev.clangd = devLib.mkDevOptions "clangd" {};
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs;
      lib.optionals (!cfg.useMasonLSP) []
      ++ lib.optionals cfg.asHomePkgs [gcc15 bear clang-tools];
  };
}
