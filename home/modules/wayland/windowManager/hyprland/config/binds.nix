{
  config,
  lib,
  osConfig,
  pkgs,
  ...
}: let
  inline = lib.generators.mkLuaInline;

  # All classic bind/binde/bindr/bindl/bindle/bindm variants collapse into a
  # single hl.bind(keys, dispatcher, opts) call in Lua config; the variant is
  # expressed via opts (repeating/locked/release/mouse) instead of a
  # different top-level function.
  mkBind = keys: dispatcher: opts: {
    _args = [keys (inline dispatcher)] ++ lib.optional (opts != {}) opts;
  };

  workspaceBinds = builtins.concatLists (builtins.genList (
      x: let
        ws = let
          c = (x + 1) / 10;
        in
          builtins.toString (x + 1 - (c * 10));
        n = toString (x + 1);
      in [
        (mkBind "SUPER + ${ws}" "hl.dsp.focus({ workspace = ${n} })" {})
        (mkBind "SUPER + SHIFT + ${ws}" "hl.dsp.window.move({ workspace = ${n} })" {})
        (mkBind "ALT + SHIFT + ${ws}" "hl.dsp.window.move({ workspace = ${n}, follow = false })" {})
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
          (mkBind "SUPER + SHIFT + E" ''hl.dsp.exec_cmd("pkill Hyprland")'' {})
          (mkBind "SUPER + Q" "hl.dsp.window.close()" {})
          (mkBind "SUPER + S" ''hl.dsp.layout("togglesplit")'' {})
          (mkBind "SUPER + F" "hl.dsp.window.fullscreen()" {})
          (mkBind "SUPER + SHIFT + F" "hl.dsp.window.float()" {})
          (mkBind "SUPER + SHIFT + P" "hl.dsp.window.pin()" {})

          # grouped (tabbed) windows
          (mkBind "SUPER + G" "hl.dsp.group.toggle()" {})
          (mkBind "SUPER + SHIFT + TAB" "hl.dsp.group.prev()" {})

          # cycle through windows
          (mkBind "SUPER + ALT + Tab" "hl.dsp.window.cycle_next()" {})
          (mkBind "SUPER + ALT + Tab" "hl.dsp.window.bring_to_top()" {})
          (mkBind "ALT + SHIFT + Tab" "hl.dsp.window.cycle_next({ next = false })" {})
          (mkBind "ALT + SHIFT + Tab" "hl.dsp.window.bring_to_top()" {})
          (mkBind "SUPER + Tab" ''hl.dsp.exec_cmd("hyprctl --batch 'dispatch focuscurrentorlast f; dispatch bringactivetotop'")'' {})
          (mkBind "ALT + Tab" ''hl.dsp.exec_cmd("hyprctl --batch 'dispatch focuscurrentorlast f; dispatch bringactivetotop'")'' {})

          # move focus
          (mkBind "SUPER + left" ''hl.dsp.focus({ direction = "left" })'' {})
          (mkBind "SUPER + right" ''hl.dsp.focus({ direction = "right" })'' {})
          (mkBind "SUPER + up" ''hl.dsp.focus({ direction = "up" })'' {})
          (mkBind "SUPER + down" ''hl.dsp.focus({ direction = "down" })'' {})
          (mkBind "SUPER + H" ''hl.dsp.focus({ direction = "left" })'' {})
          (mkBind "SUPER + L" ''hl.dsp.focus({ direction = "right" })'' {})
          (mkBind "SUPER + K" ''hl.dsp.focus({ direction = "up" })'' {})
          (mkBind "SUPER + J" ''hl.dsp.focus({ direction = "down" })'' {})

          # move windows
          (mkBind "SUPER + SHIFT + left" ''hl.dsp.window.move({ direction = "left" })'' {})
          (mkBind "SUPER + SHIFT + right" ''hl.dsp.window.move({ direction = "right" })'' {})
          (mkBind "SUPER + SHIFT + up" ''hl.dsp.window.move({ direction = "up" })'' {})
          (mkBind "SUPER + SHIFT + down" ''hl.dsp.window.move({ direction = "down" })'' {})
          (mkBind "SUPER + SHIFT + H" ''hl.dsp.window.move({ direction = "left" })'' {})
          (mkBind "SUPER + SHIFT + L" ''hl.dsp.window.move({ direction = "right" })'' {})
          (mkBind "SUPER + SHIFT + K" ''hl.dsp.window.move({ direction = "up" })'' {})
          (mkBind "SUPER + SHIFT + J" ''hl.dsp.window.move({ direction = "down" })'' {})

          # Resize windows
          (mkBind "SUPER + CTRL + left" "hl.dsp.window.resize({ x = -20, y = 0, relative = true })" {})
          (mkBind "SUPER + CTRL + H" "hl.dsp.window.resize({ x = -20, y = 0, relative = true })" {})
          (mkBind "SUPER + CTRL + right" "hl.dsp.window.resize({ x = 20, y = 0, relative = true })" {})
          (mkBind "SUPER + CTRL + L" "hl.dsp.window.resize({ x = 20, y = 0, relative = true })" {})
          (mkBind "SUPER + CTRL + up" "hl.dsp.window.resize({ x = 0, y = -20, relative = true })" {})
          (mkBind "SUPER + CTRL + K" "hl.dsp.window.resize({ x = 0, y = -20, relative = true })" {})
          (mkBind "SUPER + CTRL + down" "hl.dsp.window.resize({ x = 0, y = 20, relative = true })" {})
          (mkBind "SUPER + CTRL + J" "hl.dsp.window.resize({ x = 0, y = 20, relative = true })" {})

          # special workspaces
          (mkBind "SUPER + grave" ''hl.dsp.exec_cmd("wofi-workspace-swap && hyprctl dispatch bringactivetotop")'' {})
          (mkBind "SUPER + SHIFT + grave" ''hl.dsp.exec_cmd("wofi-workspace-swap --force && hyprctl dispatch bringactivetotop")'' {})

          # cycle workspaces
          (mkBind "SUPER + bracketleft" ''hl.dsp.focus({ workspace = "m-1" })'' {})
          (mkBind "SUPER + bracketright" ''hl.dsp.focus({ workspace = "m+1" })'' {})

          # cycle monitors
          (mkBind "SUPER + SHIFT + bracketleft" ''hl.dsp.focus({ monitor = "l" })'' {})
          (mkBind "SUPER + SHIFT + bracketright" ''hl.dsp.focus({ monitor = "r" })'' {})

          # send focused workspace to left/right monitors
          (mkBind "SUPER + SHIFT + ALT + bracketleft" ''hl.dsp.workspace.move({ monitor = "l" })'' {})
          (mkBind "SUPER + SHIFT + ALT + bracketright" ''hl.dsp.workspace.move({ monitor = "r" })'' {})

          # utilities
          (mkBind "SUPER + Return" ''hl.dsp.exec_cmd("${terminal} --class terminal")'' {})
          (mkBind "SUPER + SHIFT + Return" ''hl.dsp.exec_cmd("${terminal} --class terminal -e nvim -c 'terminal' -c 'startinsert'")'' {})
          (mkBind "SUPER + SHIFT + T" ''hl.dsp.exec_cmd("toggle-touchpad")'' {})
          # make sure adb connect ip(eg:192.168.0.100) first. you might also need to adb kill-server. start-server
          (mkBind "SUPER + A" ''hl.dsp.exec_cmd("scrcpy --turn-screen-off --render-driver=opengles2")'' {})
          (mkBind "SUPER + B" ''hl.dsp.exec_cmd("wofi-firefox")'' {})
          (mkBind "SUPER + C" ''hl.dsp.exec_cmd("rofi -show calc -modi calc -no-show-match -no-sort")'' {})
          (mkBind "SUPER + E" ''hl.dsp.exec_cmd("bemoji")'' {})
          (mkBind "SUPER + R" ''hl.dsp.exec_cmd("${terminal} --class ranger -e ranger")'' {})
          (mkBind "SUPER + N" ''hl.dsp.exec_cmd("${terminal} --class nvim -e zsh -c nvim")'' {})
          (mkBind "SUPER + F1" ''hl.dsp.exec_cmd("${terminal} --class nvim -e lazysql")'' {})
          (mkBind "SUPER + O" ''hl.dsp.exec_cmd("wofi-ollama")'' {})
          (mkBind "SUPER + SHIFT + W" ''hl.dsp.exec_cmd("winrdp")'' {})
          # (mkBind "SUPER + Z" ''hl.dsp.exec_cmd("show-and-hide --app Zalo")'' {})
          # (mkBind "SUPER + W" ''hl.dsp.exec_cmd("show-and-hide --app Youtube")'' {})
          (mkBind "SUPER + SHIFT + X" ''hl.dsp.exec_cmd("xrdp")'' {})
          (mkBind "SUPER + ESCAPE" ''hl.dsp.exec_cmd("wofi-power")'' {})
          (mkBind "SUPER + F4" ''hl.dsp.exec_cmd("${terminal} --class terminal -e pulsemixer")'' {})
          (mkBind "SUPER + SHIFT + ALT + L" ''hl.dsp.exec_cmd("pgrep hyprlock || hyprlock")'' {})
          (mkBind "SUPER + Z" ''hl.dsp.exec_cmd("swaync-client -t -sw")'' {})
          (mkBind "SUPER + SHIFT + Z" ''hl.dsp.exec_cmd("swaync-client -d -sw")'' {})
          (mkBind "SUPER + P" ''hl.dsp.exec_cmd("${pkgs.hyprpicker}/bin/hyprpicker -a")'' {})

          # shaders
          (mkBind "SUPER + SHIFT + Up" ''hl.dsp.exec_cmd("hyprshade toggle ~/.config/hypr/shaders/brightness-boost.glsl")'' {})
          (mkBind "SUPER + SHIFT + Down" ''hl.dsp.exec_cmd("hyprshade off")'' {})

          # screenshot
          (mkBind "Print" ''hl.dsp.exec_cmd("${runOnce "grimblast"} --notify copysave area")'' {})
          (mkBind "CTRL + Print" ''hl.dsp.exec_cmd("${runOnce "grimblast"} --wait 2 --notify copysave area")'' {})
          (mkBind "F10" ''hl.dsp.exec_cmd("${runOnce "grimblast"} --notify copysave area")'' {})
          (mkBind "CTRL + F10" ''hl.dsp.exec_cmd("${runOnce "grimblast"} --wait 2 --notify copysave area")'' {})
          (mkBind "CTRL + Print" ''hl.dsp.exec_cmd("${runOnce "grimblast"} --notify --cursor copysave output")'' {})
          (mkBind "ALT + Print" ''hl.dsp.exec_cmd("${runOnce "grimblast"} --notify --cursor copysave screen")'' {})

          # clipboard
          (mkBind "SUPER + V" ''hl.dsp.exec_cmd("cliphist list | rofi -dmenu -display-columns 2 | cliphist decode | wl-copy")'' {})

          # mouse
          (mkBind "mouse:275" ''hl.dsp.focus({ workspace = "e-1" })'' {})
          (mkBind "mouse:276" ''hl.dsp.focus({ workspace = "e+1" })'' {})
        ]
        ++ workspaceBinds
        # launcher (fires on key release)
        ++ [(mkBind "SUPER + D" ''hl.dsp.exec_cmd("pkill rofi || rofi -show drun -show-icons")'' {release = true;})]
        # audio / brightness (fire while locked, and repeat while held)
        ++ [
          (mkBind "XF86AudioRaiseVolume" ''hl.dsp.exec_cmd("volumectl up 5")'' {
            locked = true;
            repeating = true;
          })
          (mkBind "XF86AudioLowerVolume" ''hl.dsp.exec_cmd("volumectl down 5")'' {
            locked = true;
            repeating = true;
          })
          (mkBind "XF86AudioMute" ''hl.dsp.exec_cmd("volumectl toggle-mute")'' {
            locked = true;
            repeating = true;
          })
          (mkBind "XF86AudioMicMute" ''hl.dsp.exec_cmd("${pkgs.pamixer}/bin/pamixer --default-source --toggle-mute")'' {
            locked = true;
            repeating = true;
          })
          (mkBind "F11" ''hl.dsp.exec_cmd("volumectl down 5")'' {
            locked = true;
            repeating = true;
          })
          (mkBind "F12" ''hl.dsp.exec_cmd("volumectl up 5")'' {
            locked = true;
            repeating = true;
          })
          (mkBind "F8" ''hl.dsp.exec_cmd("vcpctl up 5")'' {
            locked = true;
            repeating = true;
          })
          (mkBind "F7" ''hl.dsp.exec_cmd("vcpctl down 5")'' {
            locked = true;
            repeating = true;
          })
          (mkBind "XF86MonBrightnessUp" ''hl.dsp.exec_cmd("lightctl up 5")'' {
            locked = true;
            repeating = true;
          })
          (mkBind "XF86MonBrightnessDown" ''hl.dsp.exec_cmd("lightctl down 5")'' {
            locked = true;
            repeating = true;
          })
        ]
        # mouse bindings
        ++ [
          (mkBind "SUPER + mouse:272" "hl.dsp.window.drag()" {mouse = true;})
          (mkBind "SUPER + mouse:273" "hl.dsp.window.resize()" {mouse = true;})
          (mkBind "SUPER + ALT + mouse:272" "hl.dsp.window.resize()" {mouse = true;})
        ]
        ++ [
          (mkBind "switch:on:Lid Switch" ''hl.dsp.exec_cmd("hyprctl keyword monitor ${monitor_one_disabled}")'' {locked = true;})
          (mkBind "switch:off:Lid Switch" ''hl.dsp.exec_cmd("hyprctl keyword monitor ${monitor_one}")'' {locked = true;})
        ];
    };
  };

  home.packages = with pkgs; [
    grimblast
    hyprpicker
    pamixer
    numbat
    wl-clipboard
  ];
}
