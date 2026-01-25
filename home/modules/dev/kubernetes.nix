{
  config,
  lib,
  pkgs,
  ...
}: let
  devLib = import ./mkDevOptions.nix {inherit lib;};
  cfg = config.dev.kubernetes;
in {
  options.dev.kubernetes = devLib.mkDevOptions "kubernetes" {};

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs;
      lib.optionals (!cfg.useMasonLSP) []
      ++ lib.optionals cfg.asHomePkgs [
        kubectl
        minikube
        skaffold
      ];
  };
}
