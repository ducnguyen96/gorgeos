{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.dev.kubernetes;
in {
  options.dev.kubernetes = {
    enable = lib.mkEnableOption "kubernetes, enable kubernetes development toolkit";
    asHomePkgs = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Install development pkgs as home pkgs so that it can be reused anywhere without a dev shell";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs;
      []
      ++ lib.optionals (cfg.asHomePkgs) [
        kubectl
        minikube
        skaffold
      ];
  };
}
