{pkgs, ...}: let
  clean = pkgs.writeShellScriptBin "clean" ''
    nix-collect-garbage -d
    sudo nix-collect-garbage -d
  '';
in {
  home.packages = [clean];
}
