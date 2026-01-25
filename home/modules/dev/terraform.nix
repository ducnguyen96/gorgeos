{
  config,
  lib,
  pkgs,
  ...
}: let
  devLib = import ./mkDevOptions.nix {inherit lib;};
  cfg = config.dev.terraform;
in {
  options.dev.terraform = devLib.mkDevOptions "terraform" {};

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs;
      lib.optionals (!cfg.useMasonLSP) []
      ++ lib.optionals cfg.asHomePkgs [];
  };
}
