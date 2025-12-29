{
  config,
  osConfig,
  pkgs,
  ...
}: let
  workspaces = builtins.concatLists (builtins.genList (
      x: let
        ws = let
          c = (x + 1) / 10;
        in
          builtins.toString (x + 1 - (c * 10));
      in [
        "SUPER, ${ws}, workspace, ${toString (x + 1)}"
        "SUPER_SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
        "ALT_SHIFT, ${ws}, movetoworkspacesilent, ${toString (x + 1)}"
      ]
    )
    10);

  runOnce = program: "pgrep ${program} || ${program}";

  terminal = config.home.sessionVariables.TERMINAL;

  monitor_one = osConfig.environment.variables."MONITOR_ONE";
  monitor_one_disabled = osConfig.environment.variables."MONITOR_ONE_DISABLED";
in {
  wayland.windowManager.hyprland = {
    settings = {
      bind =
        [
          # compositor commands
          "SUPERSHIFT, E, exec, pkill Hyprland"
          "SUPER, Q, killactive"
          "SUPER, S, togglesplit"
          "SUPER, F, fullscreen"
          "SUPERSHIFT, F, togglefloating"
          "SUPERSHIFT, P, pin"

          # grouped (tabbed) windows
          "SUPER, G, togglegroup"
          "SUPERSHIFT, TAB, changegroupactive, b"

          # cycle through windows
          "SUPERALT, Tab, cyclenext"
          "SUPERALT, Tab, bringactivetotop"
          "ALTSHIFT, Tab, cyclenext, prev"
          "ALTSHIFT, Tab, bringactivetotop"
          "SUPER, Tab, exec, hyprctl --batch 'dispatch focuscurrentorlast f; dispatch bringactivetotop'"

          # move focus
          "SUPER, left, movefocus, l"
          "SUPER, right, movefocus, r"
          "SUPER, up, movefocus, u"
          "SUPER, down, movefocus, d"
          "SUPER, H, movefocus, l"
          "SUPER, L, movefocus, r"
          "SUPER, K, movefocus, u"
          "SUPER, J, movefocus, d"

          # move windows
          "SUPERSHIFT, left, movewindow, l"
          "SUPERSHIFT, right, movewindow, r"
          "SUPERSHIFT, up, movewindow, u"
          "SUPERSHIFT, down, movewindow, d"
          "SUPERSHIFT, H, movewindow, l"
          "SUPERSHIFT, L, movewindow, r"
          "SUPERSHIFT, K, movewindow, u"
          "SUPERSHIFT, J, movewindow, d"

          # Resize windows
          "SUPER_CTRL, left, resizeactive, -20 0"
          "SUPER_CTRL, H, resizeactive, -20 0"
          "SUPER_CTRL, right, resizeactive,  20 0"
          "SUPER_CTRL, L, resizeactive,  20 0"
          "SUPER_CTRL, up, resizeactive,  0 -20"
          "SUPER_CTRL, K, resizeactive,  0 -20"
          "SUPER_CTRL, down, resizeactive,  0 20"
          "SUPER_CTRL, J, resizeactive,  0 20"

          # special workspaces
          "SUPER, grave, exec, wofi-workspace-swap && hyprctl dispatch bringactivetotop"
          "SUPERSHIFT, grave, exec, wofi-workspace-swap --force && hyprctl dispatch bringactivetotop"

          # cycle workspaces
          "SUPER, bracketleft, workspace, m-1"
          "SUPER, bracketright, workspace, m+1"

          # cycle monitors
          "SUPERSHIFT, bracketleft, focusmonitor, l"
          "SUPERSHIFT, bracketright, focusmonitor, r"

          # send focused workspace to left/right monitors
          "SUPERSHIFT ALT, bracketleft, movecurrentworkspacetomonitor, l"
          "SUPERSHIFT ALT, bracketright, movecurrentworkspacetomonitor, r"

          # utilities
          "SUPER, Return, exec, ${terminal} --class terminal"
          "SUPERSHIFT, Return, exec, ${terminal} --class terminal -e nvim -c 'terminal' -c 'startinsert'"
          # make sure adb connect ip(eg:192.168.0.100) first. you might also need to adb kill-server. start-server
          "SUPER, A, exec, scrcpy --turn-screen-off --render-driver=opengles2"
          "SUPER, B, exec, wofi-firefox"
          "SUPER, C, exec, ${terminal} --class numbat -e numbat --intro-banner off"
          "SUPER, E, exec, bemoji"
          "SUPER, R, exec, ${terminal} --class ranger -e ranger"
          "SUPER, N, exec, ${terminal} --class nvim -e nvim"
          "SUPERSHIFT, W, exec, winrdp"
          "SUPER, Z, exec, show-and-hide --app Zalo"
          "SUPER, W, exec, show-and-hide --app Youtube"
          "SUPERSHIFT, X, exec, xrdp"
          "SUPER, ESCAPE, exec, wofi-power"
          "SUPER, F4, exec, ${terminal} --class terminal -e pulsemixer"
          "SUPERSHIFT ALT, L, exec, pgrep hyprlock || hyprlock"
          "SUPER, M, exec, ${pkgs.swaynotificationcenter}/bin/swaync-client -t -sw"
          "SUPERSHIFT, M, exec, ${pkgs.swaynotificationcenter}/bin/swaync-client -d -sw"
          "SUPER, P, exec, ${pkgs.hyprpicker}/bin/hyprpicker -a"

          # screenshot
          ", Print, exec, ${runOnce "grimblast"} --notify copysave area"
          "CTRL, Print, exec, ${runOnce "grimblast"} --wait 2 --notify copysave area"
          ", F10, exec, ${runOnce "grimblast"} --notify copysave area"
          "CTRL, F10, exec, ${runOnce "grimblast"} --wait 2 --notify copysave area"
          "CTRL, Print, exec, ${runOnce "grimblast"} --notify --cursor copysave output"
          "ALT, Print, exec, ${runOnce "grimblast"} --notify --cursor copysave screen"
        ]
        ++ workspaces;

      bindr = [
        # launcher
        "SUPER, D, exec, pkill wofi  || wofi -S drun"
      ];

      bindle = [
        # audio
        ",XF86AudioRaiseVolume, exec, volumectl up 5"
        ",XF86AudioLowerVolume, exec, volumectl down 5"
        ",XF86AudioMute, exec, volumectl toggle-mute"
        ",XF86AudioMicMute, exec, ${pkgs.pamixer}/bin/pamixer --default-source --toggle-mute"
        ", F11, exec, volumectl down 5"
        ", F12, exec, volumectl up 5"

        # brightness
        ",F8, exec, vcpctl up 5"
        ",F7, exec, vcpctl down 5"

        ",XF86MonBrightnessUp, exec, lightctl up 5"
        ",XF86MonBrightnessDown, exec, lightctl down 5"
      ];

      # mouse bindings
      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
        "SUPER ALT, mouse:272, resizewindow"
      ];

      bindl = [
        ",switch:on:Lid Switch, exec, hyprctl keyword monitor ${monitor_one_disabled}"
        ",switch:off:Lid Switch, exec, hyprctl keyword monitor ${monitor_one}"
      ];
    };
  };

  home.packages = with pkgs; [
    grimblast
    hyprpicker
    pamixer
    numbat
  ];
}
