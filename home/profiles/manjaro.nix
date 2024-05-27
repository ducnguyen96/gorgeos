{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../modules/dev

    ../modules/programs/neovim
    ../modules/programs/fcitx5.nix
    ../modules/programs/kitty.nix
    ../modules/programs/ranger.nix
    ../modules/programs/wofi.nix
    ../modules/programs/wofi-power.nix

    ../modules/programs/sway
  ];

  home = {
    packages = lib.attrValues {
      # Utilities
      inherit
        (pkgs)
        cloudflare-warp
        lshw
        ;
    };
  };
}
