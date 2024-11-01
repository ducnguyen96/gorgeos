{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.dev.nix;
in {
  options.dev.nix.enable = lib.mkEnableOption "nix, enable nix development toolkit";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      # nix formatter
      alejandra

      # nix language server
      nil
    ];
  };
}
