{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.dev.sql;
in {
  options.dev.sql.enable = lib.mkEnableOption "sql, enable sql development toolkit";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      sqlfluff
    ];
  };
}
