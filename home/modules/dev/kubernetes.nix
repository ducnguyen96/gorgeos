{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.dev.nix;
in {
  options.dev.kubernetes.enable = lib.mkEnableOption "kubernetes, enable kubernetes development toolkit";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      kubectl
      minikube
      skaffold
    ];
  };
}
