{pkgs, ...}: let
  rebuild = pkgs.writeShellScriptBin "rebuild" ''
    sudo nixos-rebuild switch --flake ~/Documents/code/gorgeos/.#$(hostname)
  '';
in {
  home.packages = [rebuild];
}
