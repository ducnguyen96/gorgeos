{
  description = "legacy nodejs-16_x devShell";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import (builtins.fetchTarball {
          url = "https://github.com/NixOS/nixpkgs/archive/53951c0c1444e500585205e8b2510270b2ad188f.tar.gz";
          sha256 = "1zybhkqf9smga3px6fcbhxqzfn1d5l1x30zjg4l9nqgn3419f4r2";
        }) {system = system;};
      in rec {
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            nodejs-16_x
            nodePackages.yarn
          ];

          shellHook = ''
            export PATH="./node_modules/.bin:$PATH"
          '';
        };
      }
    );
}
