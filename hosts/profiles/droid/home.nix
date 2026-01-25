{
  pkgs,
  lib,
  ...
}: {
  home-manager = {
    config = {
      imports = [
        ../../../home/modules/dev
        ../../../home/modules/programs/neovim
        ../../../home/modules/shell/programs
        ../../../home/modules/shell/services/ssh.nix
      ];

      dev = {
        clangd.enable = lib.mkForce false;
        go.enable = lib.mkForce false;
        lua.enable = lib.mkForce false;
        nix.enable = lib.mkForce false;
        rust.enable = lib.mkForce false;
        typescript.enable = lib.mkForce false;
      };

      home = {
        packages = with pkgs; [gawk];
        stateVersion = "24.05";
      };
    };
    backupFileExtension = "hm-bak";
    useGlobalPkgs = true;
  };
}
