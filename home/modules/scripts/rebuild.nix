{pkgs, ...}: let
  rebuild = pkgs.writeShellScriptBin "rebuild" ''
    sudo nixos-rebuild switch --flake ~/gorgeos/.#$(hostname)
  '';
in {
  home.packages = [rebuild];
}
