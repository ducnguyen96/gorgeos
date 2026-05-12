{
  pkgs,
  lib,
  ...
}: {
  home = {
    username = "duc";
    homeDirectory = "/data/data/com.termux.nix/files/home";

    packages = with pkgs; [gawk ncurses5 posting];
  };

  dev = {
    angular.enable = lib.mkForce false;
    clangd.enable = lib.mkForce false;
    go.enable = lib.mkForce false;
    lua.enable = lib.mkForce false;
    python.enable = lib.mkForce false;
    rust.enable = lib.mkForce false;
    typescript.enable = lib.mkForce false;
    tex.enable = lib.mkForce false;
    tailwind.enable = lib.mkForce false;
    sql.enable = lib.mkForce false;
    aws.enable = lib.mkForce false;
    terraform.enable = lib.mkForce false;
  };

  manual = {
    html.enable = false;
    json.enable = false;
    manpages.enable = false;
  };

  programs.home-manager.enable = true;

  home.stateVersion = "26.05";
}
