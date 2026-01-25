{
  config,
  lib,
  pkgs,
  ...
}: let
  devLib = import ./mkDevOptions.nix {inherit lib;};
  cfg = config.dev.lua;
in {
  options.dev.lua = devLib.mkDevOptions "lua" {};

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs;
      lib.optionals (!cfg.useMasonLSP) [lua-language-server]
      ++ lib.optionals cfg.asHomePkgs [stylua lua];
  };
}
