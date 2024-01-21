{pkgs, ...}: let
  rebuild = pkgs.writeShellScriptBin "rebuild" ''
    sudo nixos-rebuild switch --flake ~/Documents/Code/gorgeos/.#$(hostname)
  '';
in {
  home.packages = [rebuild];
}
