{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../modules/programs/neovim
  ];

  home = {
    packages = lib.attrValues {
      # Utilities
      inherit
        (pkgs)
        ;
    };
  };
}
