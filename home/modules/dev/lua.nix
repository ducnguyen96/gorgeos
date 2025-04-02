{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.dev.nix;
in {
  options.dev.lua = {
    enable = lib.mkEnableOption "lua, enable lua development toolkit";
    useMasonLSP = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Whether to use Mason to install lsp package";
    };
    asHomePkgs = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Install development pkgs as home pkgs so that it can be reused anywhere without a dev shell";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs;
      []
      ++ lib.optionals (!cfg.useMasonLSP) [lua-language-server]
      ++ lib.optionals (cfg.asHomePkgs) [lua];
  };
}
