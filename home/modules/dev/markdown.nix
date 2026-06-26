{
  config,
  lib,
  pkgs,
  ...
}: let
  devLib = import ./mkDevOptions.nix {inherit lib;};
  cfg = config.dev.markdown;
in {
  options.dev.markdown = devLib.mkDevOptions "markdown" {};

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs;
      lib.optionals (!cfg.useMasonLSP) [marksman]
      ++ lib.optionals cfg.asHomePkgs [markdownlint-cli2 markdown-toc];
  };
}
