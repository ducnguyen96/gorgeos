{lib, ...}: let
  # Helper function to create regex from list
  toRegex = list: let
    elements = lib.concatStringsSep "|" list;
  in "^(${elements})$";

  # Helper to generate window rules for a class/title
  mkFloatRule = matcher: value: [
    "float on, ${matcher} ${value}"
  ];

  mkFloatCenterSizeRule = matcher: value: size: [
    "float on, ${matcher} ${value}"
    "center on, ${matcher} ${value}"
    "size ${size}, ${matcher} ${value}"
  ];

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
    # Layer rules
    layerrule = let
      layers = [
        "gtk-layer-shell"
        "swaync-control-center"
        "swaync-notification-window"
        "waybar"
      ];
    in [
      "blur on, match:class ${toRegex layers}"
      "ignore_alpha 0.5, match:class ${toRegex layers}"
    ];

    # Window rules (v0.53+ syntax)
    windowrule =
      # Floating windows by class
      (map (app: "float on, match:class ^(${app})$") floatingApps)
      # Floating windows by title
      ++ [
        "float on, match:title ^(Media viewer)$"
        "float on, match:title ^(Picture-in-Picture)$"
      ]
      # Pin rules
      ++ [
        "pin on, match:class ^(showmethekey)$"
        "pin on, match:title ^(Picture-in-Picture)$"
      ]
      # Dim around (authentication dialogs)
      ++ (map (app: "dim_around on, match:class ^(${app})$") dimAroundApps)
      # Idle inhibit rules
      ++ [
        "idle_inhibit focus, match:class ${toRegex idleInhibitApps}"
        "idle_inhibit focus, match:class ^(firefox)$, match:title ^(.*YouTube.*)$"
        "idle_inhibit fullscreen, match:class ^(firefox)$"
      ]
      # Workspace rules for sharing indicators
      ++ [
        "workspace special:silent, match:title ^(.*is sharing (your screen|a window)\\.)$"
        "workspace special:silent, match:title ^(Firefox — Sharing Indicator)$"
      ]
      # Floating windows with custom size and center
      ++ (mkFloatCenterSizeRule "match:class" "^(numbat)$" "500 200")
      ++ (mkFloatCenterSizeRule "match:class" "^(ranger)$" "monitor_w*0.7 monitor_h*0.9")
      ++ (mkFloatCenterSizeRule "match:class" "^(terminal)$" "monitor_w*0.7 monitor_h*0.9")
      ++ (mkFloatCenterSizeRule "match:class" "^(doxx)$" "monitor_w*0.7 monitor_h*0.9")
      # Pixel 5 (special positioning)
      ++ [
        "float on, match:title ^(Pixel 5)$"
        "size 570 256, match:title ^(Pixel 5)$"
        "pin on, match:title ^(Pixel 5)$"
        "move 1400 -139, match:title ^(Pixel 5)$"
      ];
  };
}
