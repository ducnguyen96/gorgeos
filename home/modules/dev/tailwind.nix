{
  config,
  lib,
  pkgs,
  ...
}: let
  devLib = import ./mkDevOptions.nix {inherit lib;};
  cfg = config.dev.tailwind;
in {
  options.dev.tailwind = devLib.mkDevOptions "tailwind" {};

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs;
      lib.optionals (!cfg.useMasonLSP) [tailwindcss-language-server]
      ++ lib.optionals cfg.asHomePkgs [];
  };
}
