{
  pkgs,
  config,
}: let
  workspaces = import ./modules/workspaces.nix;

  clock = import ./modules/clock.nix;

  crypto = import ./modules/crypto.nix {
    inherit pkgs;
  };

  system = import ./modules/system.nix;

  network = import ./modules/network.nix {
    inherit pkgs;
  };

  audio = import ./modules/audio.nix {
    inherit pkgs config;
  };

  battery = import ./modules/battery.nix;

  tray = import ./modules/tray.nix;

  notifications = import ./modules/notifications.nix;

  powermenu = import ./modules/powermenu.nix {
    inherit pkgs;
  };
in [
  ({
      layer = "bottom";

      position = "bottom";

      margin = "0 10 5 10";

      spacing = 6;

      modules-left = [
        "hyprland/workspaces"
      ];

      modules-center = [
        "clock"
        "group/crypto"
      ];

      modules-right = [
        "cpu"
        "memory"
        "temperature"
        "network"
        "bluetooth"
        "pulseaudio"
        "backlight"
        "battery"
        "tray"
        "custom/notification"
        "group/powermenu"
      ];
    }
    // workspaces
    // clock
    // crypto
    // system
    // network
    // audio
    // battery
    // tray
    // notifications
    // powermenu)
]
