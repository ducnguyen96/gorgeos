{
  config,
  osConfig,
  ...
}: let
  pointer = config.home.pointerCursor;
  cursorName = "Bibata-Modern-Ice-Hyprcursor";

  monitor_left = osConfig.environment.variables."MONITOR_LEFT";
  monitor_right = osConfig.environment.variables."MONITOR_RIGHT";

  monitor_left_name = builtins.elemAt (builtins.split "," monitor_left) 0;
  monitor_right_name = builtins.elemAt (builtins.split "," monitor_right) 0;

  workspace = [
    "1, monitor:${monitor_right_name}"
    "3, monitor:${monitor_left_name}"
    "5, monitor:${monitor_left_name}"
    "7, monitor:${monitor_left_name}"
    "9, monitor:${monitor_left_name}"
    "2, monitor:${monitor_left_name}"
    "4, monitor:${monitor_left_name}"
    "6, monitor:${monitor_left_name}"
    "8, monitor:${monitor_left_name}"
    "0, monitor:${monitor_left_name}"
  ];
in {
  wayland.windowManager.hyprland.settings = {
    env = [
      "GDK_SCALE,1"
      "HYPRCURSOR_THEME,${cursorName}"
      "HYPRCURSOR_SIZE,${toString pointer.size}"
    ];

    exec-once = [
      "hyprctl setcursor ${cursorName} ${toString pointer.size}"
    ];

    general = {
      gaps_in = 2;
      gaps_out = 4;

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

    gestures = {
      workspace_swipe = true;
      workspace_swipe_forever = true;
    };

    group = {
      groupbar = {
        font_size = 16;
        gradients = false;
      };
    };

    misc = {
      disable_autoreload = true;
      disable_hyprland_logo = true;
      force_default_wallpaper = 0;
      vfr = true;
      vrr = 1;
    };

    workspace = workspace;

    monitor = [
      monitor_left
      monitor_right
    ];

    cursor.no_hardware_cursors = true;
    debug.disable_logs = false;
    # render.direct_scanout = true;
    xwayland.force_zero_scaling = true;
  };
}
