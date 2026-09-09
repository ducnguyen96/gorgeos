{
  inputs,
  lib,
  pkgs,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) isDarwin system;

  toggleQueryHistory = "Ctrl-Y";

  # lazysql saves connections back into `config.toml`, so that file has to stay
  # writable. What we own declaratively goes into a read-only drop-in, which the
  # fork merges on top of `config.toml`.
  dropIn = (pkgs.formats.toml {}).generate "lazysql-nix.toml" {
    keymap = {
      home.ToggleQueryHistory = toggleQueryHistory;
      queryhistory.ToggleQueryHistory = toggleQueryHistory;
    };
  };
in {
  programs.lazysql = {
    enable = true;
    package = inputs.lazysql.packages.${system}.default;
  };

  xdg.configFile = lib.mkIf (!isDarwin) {
    "lazysql/config.d/10-nix.toml".source = dropIn;
  };

  # `os.UserConfigDir()` resolves to ~/Library/Application Support on darwin,
  # not to the XDG config home.
  home.file = lib.mkIf isDarwin {
    "Library/Application Support/lazysql/config.d/10-nix.toml".source = dropIn;
  };
}
