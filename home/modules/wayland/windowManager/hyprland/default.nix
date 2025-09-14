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

    # hypr utils
    ./services/hypridle.nix
    ./services/hyprlock.nix
    ./services/hyprpaper.nix
  ];

  home.packages = with pkgs; [
    wl-clipboard
    grimblast
  ];

  home.sessionVariables = {
    # toolkit backend
    GDK_BACKEND = "wayland,x11,*";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";

    # XDG
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "Hyprland";

    # QT
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

    # firefox
    MOZ_ENABLE_WAYLAND = "1";
  };

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
