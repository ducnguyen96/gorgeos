{pkgs, ...}: let
  rebuild = pkgs.writeShellScriptBin "rebuild" ''
    sudo nixos-rebuild switch --flake ~/Documents/Code/SideProjects/gorgeos/.#$(hostname)
  '';
in {
  home.packages = [rebuild];
}
