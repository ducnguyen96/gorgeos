{lib, ...}: let
  # Helper function to create regex from list
  toRegex = list: let
    elements = lib.concatStringsSep "|" list;
  in "^(${elements})$";

  mkFloatCenterSizeRule = class: size: {
    match.class = "^(${class})$";
    float = true;
    center = true;
    size = size;
  };

  # Lists of applications
  floatingApps = [
    "wofi"
    "showmethekey"
    "imv"
    "io.bassi.Amberol"
    "io.github.celluloid_player.Celluloid"
    "nm-connection-editor"
    "org.gnome.Loupe"
    "pavucontrol"
    "thunar"
    "xdg-desktop-portal-gtk"
  ];

  dimAroundApps = [
    "gcr-prompter"
    "xdg-desktop-portal-gtk"
    "polkit-gnome-authentication-agent-1"
  ];

  idleInhibitApps = [
    "mpv"
    ".+exe"
    "celluloid"
  ];
in {
  wayland.windowManager.hyprland.settings = {
    # Window rules (v0.53+ syntax)
    window_rule =
      # Floating windows by class
      (map (app: {
          match.class = "^(${app})$";
          float = true;
        })
        floatingApps)
      # Floating windows by title
      ++ [
        {
          match.title = "^(Media viewer)$";
          float = true;
        }
        {
          match.title = "^(Picture-in-Picture)$";
          float = true;
        }
      ]
      # Pin rules
      ++ [
        {
          match.class = "^(showmethekey)$";
          pin = true;
        }
        {
          match.title = "^(Picture-in-Picture)$";
          pin = true;
        }
      ]
      # Dim around (authentication dialogs)
      ++ (map (app: {
          match.class = "^(${app})$";
          dim_around = true;
        })
        dimAroundApps)
      # Idle inhibit rules
      ++ [
        {
          match.class = toRegex idleInhibitApps;
          idle_inhibit = "focus";
        }
        {
          match.class = "^(firefox)$";
          match.title = "^(.*YouTube.*)$";
          idle_inhibit = "focus";
        }
        {
          match.class = "^(firefox)$";
          idle_inhibit = "fullscreen";
        }
      ]
      # Workspace rules for sharing indicators
      ++ [
        {
          match.title = "^(.*is sharing (your screen|a window)\\.)$";
          workspace = "special:silent";
        }
        {
          match.title = "^(Firefox — Sharing Indicator)$";
          workspace = "special:silent";
        }
      ]
      # Floating windows with custom size and center
      ++ [
        (mkFloatCenterSizeRule "numbat" "500 200")
        (mkFloatCenterSizeRule "ranger" "monitor_w*0.7 monitor_h*0.9")
        (mkFloatCenterSizeRule "posting" "monitor_w*0.9 monitor_h*0.9")
        (mkFloatCenterSizeRule "doxx" "monitor_w*0.7 monitor_h*0.9")
      ]
      # Pixel 5 (special positioning)
      ++ [
        {
          match.title = "^(Pixel 5)$";
          float = true;
          size = "570 256";
          pin = true;
          move = "1400 -139";
        }
      ];
  };
}
