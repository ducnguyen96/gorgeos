{
  inputs,
  lib,
  ...
}: let
  sharedModules = [
    ./modules/config/gtk.nix
    ./modules/config/home-cursor.nix

    ./modules/programs/gaming.nix

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
    "duc@hyprland" =
      [
        ./home.nix
        ./modules/wayland/windowManager/hyprland
        ./modules/wayland/statusBar/waybar
        ./modules/wayland/swaync
        ./modules/programs/wofi.nix
        ./modules/programs/wofi-power.nix
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
      "duc@hyprland" = homeManagerConfiguration {
        inherit pkgs;
        modules = homeImports."duc@hyprland";
      };

      "duc@sway" = homeManagerConfiguration {
        inherit pkgs;
        modules = homeImports."duc@sway";
      };
    };
  };
}
