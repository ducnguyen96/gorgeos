let
  pkgs = import (builtins.fetchTarball {
    # nodejs 16.12.2 - other version here: https://lazamar.co.uk/nix-versions/?channel=nixpkgs-unstable&package=nodejs
    url = "https://github.com/NixOS/nixpkgs/archive/d1c3fea7ecbed758168787fe4e4a3157e52bc808.tar.gz";
  }) {};

  NPM_CONFIG_PREFIX = toString ./npm_config_prefix;
in
  pkgs.mkShell {
    packages = with pkgs; [
      nodejs
      nodePackages.yarn
    ];

    inherit NPM_CONFIG_PREFIX;

    shellHook = ''
      export PATH="${NPM_CONFIG_PREFIX}/bin:$PATH"
    '';
  }
