{
  config,
  lib,
  pkgs,
  ...
}: let
  devLib = import ./mkDevOptions.nix {inherit lib;};
  cfg = config.dev.php;
in {
  options.dev.php = devLib.mkDevOptions "php" {
    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.php;
      defaultText = lib.literalExpression "pkgs.php";
      description = ''
        PHP interpreter to install. Use `pkgs.php74` (from the php74 overlay)
        for projects that still require "php": "~7.4".
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages =
      lib.optionals (!cfg.useMasonLSP) [pkgs.intelephense]
      # composer comes from the same package set so it runs on the chosen PHP
      ++ lib.optionals cfg.asHomePkgs [cfg.package cfg.package.packages.composer];
  };
}
