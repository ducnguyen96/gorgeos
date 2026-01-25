{pkgs, ...}: {
  home-manager = {
    config = {
      imports = [
        # ../../../home/modules/dev
        # ../../../home/modules/programs/neovim
        ../../../home/modules/shell/programs
        ../../../home/modules/shell/services/ssh.nix
      ];

      # dev = {
      #   clangd.enable = false;
      #   go.enable = false;
      #   lua.enable = false;
      #   nix.enable = false;
      #   rust.enable = false;
      #   typescript.enable = false;
      # };

      home = {
        packages = with pkgs; [];
        stateVersion = "24.05";
      };
    };
    backupFileExtension = "hm-bak";
    useGlobalPkgs = true;
  };
}
