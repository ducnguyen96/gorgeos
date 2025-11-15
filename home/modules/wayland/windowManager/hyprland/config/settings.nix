{
  pkgs,
  osConfig,
  ...
}: let
  cursorName = "Bibata-Modern-Ice";
  cursorSize = "24";

  monitor_one = osConfig.environment.variables."MONITOR_ONE";
  monitor_two = osConfig.environment.variables."MONITOR_TWO";

  monitor_one_name = builtins.elemAt (builtins.split "," monitor_one) 0;
  monitor_two_name = builtins.elemAt (builtins.split "," monitor_two) 0;

  workspace = [
    "1, monitor:${monitor_one_name}"
    "3, monitor:${monitor_one_name}"
    "5, monitor:${monitor_one_name}"
    "7, monitor:${monitor_one_name}"
    "9, monitor:${monitor_one_name}"

    "2, monitor:${monitor_two_name}"
    "4, monitor:${monitor_two_name}"
    "6, monitor:${monitor_two_name}"
    "8, monitor:${monitor_two_name}"
    "0, monitor:${monitor_two_name}"
  ];
in {
  # dependencies
  home.packages = with pkgs; [
    bibata-cursors
  ];

  wayland.windowManager.hyprland.settings = {
    env = [
      "GDK_SCALE,1"
      "HYPRCURSOR_THEME,${cursorName}"
      "HYPRCURSOR_SIZE,${cursorSize}"
    ];

    exec-once = [
      "hyprctl setcursor ${cursorName} ${cursorSize}"
    ];

    general = {
      gaps_in = 4;
      gaps_out = 8;

      border_size = 1;
      "col.active_border" = "rgb(AC87C5)";
      "col.inactive_border" = "rgba(00000088)";

      resize_on_border = true;
      allow_tearing = true;

      layout = "dwindle";
    };

    dwindle = {
      pseudotile = true;
      preserve_split = true;
    };

    master = {
      new_status = "master";
    };

    decoration = {
      rounding = 16;
      blur.enabled = true;
    };

    animations = {
      enabled = true;

      bezier = [
        "quart, 0.25, 1, 0.5, 1"
      ];

      animation = [
        "windows, 1, 5, quart, popin 75%"
        "windowsIn, 1, 5, quart, popin 75%"
        "windowsOut, 1, 5, quart, popin 75%"
        "windowsMove, 1, 5, default"
        "border, 1, 10, default"
        "fade, 1, 5, quart"
        "workspaces, 1, 5, quart, slide"
        "specialWorkspace, 1, 5, quart, slidevert"
      ];
    };

    input = {
      kb_layout = "us";
      kb_options = "caps:escape";

      follow_mouse = 1;
      accel_profile = "flat";

      touchpad = {
        disable_while_typing = true;
        scroll_factor = 0.5;
      };
    };

    # Custom gestures
    gesture = [
      "3, horizontal, workspace" # Swipe horizontally with 3 fingers to switch workspaces
      "3, down, mod: SUPER, close" # Swipe down with 3 fingers + ALT to close the active window
      "3, up, mod: SUPER, scale: 1.5, fullscreen" # Swipe up with 3 fingers + SUPER to toggle fullscreen
      "4, up, move" # Swipe up with 4 fingers to move the active window up
      "4, down, move" # Swipe down with 4 fingers to move the active window down
      "4, left, move" # Swipe left with 4 fingers to move the active window left
      "4, right, move" # Swipe right with 4 fingers to move the active window right
    ];

    group = {
      groupbar = {
        font_size = 16;
        gradients = false;
      };
    };

    misc = {
      focus_on_activate = true;
      disable_autoreload = true;
      disable_hyprland_logo = true;
      force_default_wallpaper = 0;
      vfr = true;
      vrr = 1;
    };

    workspace = workspace;

    monitor = [
      monitor_one
      monitor_two
    ];

    cursor.no_hardware_cursors = true;
    debug.disable_logs = false;
    # render.direct_scanout = true;
    xwayland.force_zero_scaling = true;
  };
}
