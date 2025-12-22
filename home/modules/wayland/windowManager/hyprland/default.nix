{pkgs, ...}: let
in {
  imports = [
    ./config

    # launcher
    ./programs/wofi.nix

    # bar
    ./programs/waybar.nix

    # notifications daemon
    # ./services/dunst.nix
    ./services/swaync.nix
    ./services/wayvnc.nix

    # hypr utils
    ./services/hypridle.nix
    ./services/hyprlock.nix
    ./services/hyprpaper.nix
  ];

  home.packages = with pkgs; [
    grimblast
    hyprpicker
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    systemd = {
      variables = ["--all"];
      extraCommands = [
        "systemctl --user stop graphical-session.target"
        "systemctl --user start hyprland-session.target"
      ];
    };
  };
}
