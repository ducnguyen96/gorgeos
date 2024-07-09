{
  config,
  osConfig,
  ...
}: let
  monitor_left = osConfig.environment.variables."MONITOR_LEFT";
  monitor_right = osConfig.environment.variables."MONITOR_RIGHT";

  monitor_left_name = builtins.elemAt (builtins.split "," monitor_left) 0;
  monitor_right_name = builtins.elemAt (builtins.split "," monitor_right) 0;

  workspace = [
    "1, monitor:${monitor_left_name}"
    "3, monitor:${monitor_left_name}"
    "5, monitor:${monitor_left_name}"
    "7, monitor:${monitor_left_name}"
    "9, monitor:${monitor_left_name}"
    "2, monitor:${monitor_right_name}"
    "4, monitor:${monitor_right_name}"
    "6, monitor:${monitor_right_name}"
    "8, monitor:${monitor_right_name}"
    "0, monitor:${monitor_right_name}"
  ];
in {
  wayland.windowManager.hyprland.settings = let
    pointer = config.home.pointerCursor;
  in {
    animations = {
      enabled = true;

      bezier = [
        "md3_decel, 0.05, 0.7, 0.1, 1"
      ];

      animation = [
        "border, 1, 2, default"
        "fade, 1, 2, md3_decel"
        "windows, 1, 4, md3_decel, popin 60%"
        "workspaces, 1, 4, md3_decel, slidevert"
      ];
    };

    decoration = {
      rounding = 16;

      active_opacity = 1.0;
      inactive_opacity = 1.0;
      fullscreen_opacity = 1.0;

      drop_shadow = true;
      shadow_ignore_window = true;
      shadow_offset = "0 2";
      shadow_range = 20;
      shadow_render_power = 3;
      "col.shadow" = "rgba(00000055)";

      blur = {
        enabled = true;
        brightness = 1.0;
        contrast = 1.0;
        noise = 0.02;
        passes = 3;
        popups = true;
        size = 10;
      };
    };

    dwindle = {
      pseudotile = true;
      preserve_split = true;
    };

    env = [
      "GDK_SCALE,2"
      "WLR_DRM_NO_ATOMIC,1"
    ];

    exec-once = [
      "hyprctl setcursor ${pointer.name} ${toString pointer.size}"
    ];

    general = {
      gaps_in = 2;
      gaps_out = 4;

      border_size = 1;
      "col.active_border" = "rgb(AC87C5)";
      "col.inactive_border" = "rgba(00000088)";

      resize_on_border = true;
      allow_tearing = true;
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

    input = {
      kb_layout = "us";

      accel_profile = "flat";
      follow_mouse = 1;

      touchpad = {
        disable_while_typing = true;
        natural_scroll = true;
        scroll_factor = 0.5;
      };
    };

    misc = {
      disable_autoreload = true;
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
      focus_on_activate = true;
      force_default_wallpaper = 0;
      no_direct_scanout = false;
      vfr = true;
      vrr = 1;
    };

    workspace = workspace;

    monitor = [monitor_left monitor_right];

    xwayland.force_zero_scaling = true;
  };
}
