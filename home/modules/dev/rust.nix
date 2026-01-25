{
  config,
  lib,
  pkgs,
  ...
}: let
  devLib = import ./mkDevOptions.nix {inherit lib;};
  cfg = config.dev.rust;
in {
  options.dev.rust = devLib.mkDevOptions "rust" {};

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs;
      lib.optionals (!cfg.useMasonLSP) [rust-analyzer]
      ++ lib.optionals cfg.asHomePkgs [cargo rustc lld rustfmt cargo-generate];
  };
}
