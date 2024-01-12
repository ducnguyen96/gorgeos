{
  lib,
  config,
  pkgs,
  ...
}: let
  screenshotarea = "hyprctl keyword animation 'fadeOut,0,0,default'; grimblast --notify copysave area; hyprctl keyword animation 'fadeOut,1,4,default'";

  workspaces = builtins.concatLists (builtins.genList (
      x: let
        ws = let
          c = (x + 1) / 10;
        in
          builtins.toString (x + 1 - (c * 10));
      in [
        "SUPER, ${ws}, workspace, ${toString (x + 1)}"
        "SUPERSHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
      ]
    )
    10);

  gtk-launch = "${pkgs.gtk3}/bin/gtk-launch";
  xdg-mime = "${pkgs.xdg-utils}/bin/xdg-mime";
  defaultApp = type: "${gtk-launch} $(${xdg-mime} query default ${type})";

  terminal = config.home.sessionVariables.TERMINAL;
  browser = defaultApp "x-scheme-handler/https";
  editor = defaultApp "text/plain";
in {
  wayland.windowManager.hyprland = {
    settings = {
      bind = let
        monocle = "dwindle:no_gaps_when_only";
      in
        [
          "SUPERSHIFT, Q, exec, pkill Hyprland"
          "SUPER, Q, killactive,"

          "SUPER, S, togglesplit,"
          "SUPER, F, fullscreen,"
          "SUPER, P, pseudo,"
          "SUPER, M, exec, hyprctl keyword ${monocle} $(($(hyprctl getoption ${monocle} -j | jaq -r '.int') ^ 1))"
          "SUPER, Space, togglefloating,"
          "SUPERALT, ,resizeactive,"
          "SUPER, tab, exec, hyprctl dispatch focuscurrentorlast"

          "SUPER, G, togglegroup,"
          "SUPERSHIFT, N, changegroupactive, f"
          "SUPERSHIFT, P, changegroupactive, b"

          "SUPER, left, movefocus, l"
          "SUPER, right, movefocus, r"
          "SUPER, up, movefocus, u"
          "SUPER, down, movefocus, d"

          "$SUPER, H, movefocus, l"
          "$SUPER, L, movefocus, r"
          "$SUPER, J, movefocus, u"
          "$SUPER, K, movefocus, d"
          "ALT, Tab, movefocus, d"

          "SUPERSHIFT, grave, movetoworkspace, special"
          "SUPER, grave, togglespecialworkspace, eDP-1"

          "SUPER, bracketleft, workspace, m-1"
          "SUPER, bracketright, workspace, m+1"

          "SUPER, Return, exec, run-as-service ${terminal}"
          "SUPER, B, exec, ${browser}"
          "SUPER, E, exec, ${editor}"
          "SUPER, R, exec, ${terminal} -e ranger"
          "SUPERSHIFT, L, exec, ${pkgs.swaylock-effects}/bin/swaylock -S --grace 2"
          "SUPER, D, exec, pkill wofi  || wofi -S drun"
          "SUPER, ESCAPE, exec, wofi-power"

          ", Print, exec, ${screenshotarea}"
          "CTRL, Print, exec, grimblast --notify --cursor copysave output"
          "ALT, Print, exec, grimblast --notify --cursor copysave screen"
        ]
        ++ workspaces;

      binde = [
        ",XF86AudioRaiseVolume, exec, volumectl up 5"
        ",XF86AudioLowerVolume, exec, volumectl down 5"

        ", F3, exec, volumectl down 5"
        ", F4, exec, volumectl up 5"
        "SUPER, F4, exec, ${terminal} -e pulsemixer"

        ",XF86AudioMute, exec, volumectl toggle-mute"

        ",XF86MonBrightnessUp, exec, lightctl up 5"
        ",XF86MonBrightnessDown, exec, lightctl down 5"

        ", F5, exec, lightctl down 5"
        ", F6, exec, lightctl up 5"
      ];

      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
        "SUPER ALT, mouse:272, resizewindow"
      ];
    };

    extraConfig = ''
      bind = SUPERSHIFT, S, submap, resize

      submap=resize
      binde=,right,resizeactive,10 0
      binde=,left,resizeactive,-10 0
      binde=,up,resizeactive,0 -10
      binde=,down,resizeactive,0 10
      bind=,escape,submap,reset
      submap=reset
    '';
  };
}
