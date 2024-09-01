{
  inputs,
  lib,
  ...
}: let
  sharedModules = [
    ./modules/config/gtk.nix
    ./modules/config/home-cursor.nix

    ./modules/programs/fcitx5.nix
    ./modules/programs/firefox.nix
    ./modules/programs/kitty.nix
    ./modules/programs/starship.nix
    ./modules/programs/programming.nix
    ./modules/programs/ranger.nix
    ./modules/programs/utils.nix
    ./modules/programs/vscode.nix
    ./modules/programs/zsh.nix

    ./modules/programs/media
    ./modules/programs/neovim

    ./modules/dev/go.nix
  ];

  homeImports = {
    "duc@rtx2070" =
      [
        ./home.nix
        ./modules/wayland/windowManager/hyprland
        ./modules/wayland/statusBar/waybar
        ./modules/wayland/swaync
        ./modules/programs/wofi.nix
        ./modules/programs/wofi-power.nix
        ./modules/programs/wofi-wine.nix
      ]
      ++ lib.concatLists [sharedModules]
      ++ lib.concatLists [./modules/dev/react-native.nix];

    "duc@e14g2" =
      [
        ./home.nix
        ./modules/wayland/windowManager/hyprland
        ./modules/wayland/statusBar/waybar
        ./modules/wayland/swaync
        ./modules/programs/wofi.nix
        ./modules/programs/wofi-power.nix
        ./modules/programs/wofi-wine.nix
      ]
      ++ lib.concatLists [sharedModules];

    "duc@sway" =
      [
        ./home.nix
        ./modules/wayland/windowManager/sway
      ]
      ++ lib.concatLists [sharedModules];
  };

  inherit (inputs.home-manager.lib) homeManagerConfiguration;
  pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
in {
  _module.args = {inherit homeImports;};

  flake = {
    homeConfigurations = {
      "duc@rtx2070" = homeManagerConfiguration {
        inherit pkgs;
        modules = homeImports."duc@rtx2070";
      };

      "duc@e14g2" = homeManagerConfiguration {
        inherit pkgs;
        modules = homeImports."duc@e14g2";
      };

      "duc@sway" = homeManagerConfiguration {
        inherit pkgs;
        modules = homeImports."duc@sway";
      };
    };
  };
}
