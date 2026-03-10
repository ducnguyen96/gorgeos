{
  services.skhd = {
    enable = true;

    skhdConfig = ''
      # ── Navigation ──────────────────────────────────────────────────────────────
      alt - h : skhd -k "left"
      alt - l : skhd -k "right"
      alt - j : skhd -k "down"
      alt - k : skhd -k "up"
      alt - b : skhd -k "home"
      alt - n : skhd -k "end"

      alt - return : skhd -k "alt - return"
      alt - space  : skhd -k "return"
      alt - x      : skhd -k "backspace"

      alt - r : skhd -k "shift - 2"             # @
      alt - q : skhd -k "0x27"                  # '
      alt - w : skhd -k "shift - 0x27"          # "
      alt - e : skhd -k "0x18"                  # =
      alt - p : skhd -k "shift - 0x18"          # +
      alt - m : skhd -k "0x1B"                  # -
      alt - f : skhd -k "0x1B"                  # -
      alt + shift - f : skhd -k "shift - 0x1B"  # _

      alt - 1 : skhd -k "shift - 9"    # (
      alt - 2 : skhd -k "shift - 0"    # )
      alt - 3 : skhd -k "shift - 0x21"    # {
      alt - 4 : skhd -k "shift - 0x1E"    # }
      alt - a : skhd -k "0x21"            # [
      alt - d : skhd -k "0x1E"            # ]
      alt - s : skhd -k "0x2C"            # /

      # ── Copy, paste, cut, save, find ──────────────────────────────────────────────────────────────
      ctrl - backspace : skhd -k "alt - backspace"
      ctrl - left : skhd -k "alt - left"
      ctrl - right : skhd -k "alt - right"
      ctrl - x : skhd -k "cmd - x"
      ctrl + alt - x : skhd -k "alt - backspace"
      ctrl + shift - c : skhd -k "cmd - c"
      ctrl + shift - v : skhd -k "cmd - v"
      ctrl - z : skhd -k "cmd - z"
      ctrl - f : skhd -k "cmd - f"
      alt - c : skhd -k "cmd - c"
      alt - v : skhd -k "cmd - v"
      ctrl - a : skhd -k "cmd - a"
      ctrl - b : skhd -k "cmd - b"
      ctrl - t : skhd -k "cmd - t"

      # ── Compositor / WM commands ──────────────────────────────────────────────────────────────
      ctrl + shift - f : yabai -m window --toggle float; yabai -m window --grid 4:4:1:1:2:2
      cmd + shift - f  : yabai -m window --toggle zoom-fullscreen

      # ── Focus ──────────────────────────────────────────────────────────────
      cmd - h     : yabai -m window --focus west  || yabai -m display --focus west
      # cmd - l     : yabai -m window --focus east  || yabai -m display --focus east
      cmd - k     : yabai -m window --focus north || yabai -m display --focus north
      # cmd - j     : yabai -m window --focus south || yabai -m display --focus south
      cmd - left  : yabai -m window --focus west  || yabai -m display --focus west
      cmd - right : yabai -m window --focus east  || yabai -m display --focus east
      cmd - up    : yabai -m window --focus north || yabai -m display --focus north
      cmd - down  : yabai -m window --focus south || yabai -m display --focus south

      # ── Tab cycling ──────────────────────────────────────────────────────────────
      cmd - tab  : yabai -m window --focus next || yabai -m window --focus first

      # ── Workspaces cycling ──────────────────────────────────────────────────────────────
      cmd + shift - tab : yabai -m space --focus next || yabai -m space --focus first

      # ── Move windows ──────────────────────────────────────────────────────────────
      cmd + shift - h     : yabai -m window --warp west
      cmd + shift - l     : yabai -m window --warp east
      cmd + shift - k     : yabai -m window --warp north
      cmd + shift - j     : yabai -m window --warp south
      cmd + shift - left  : yabai -m window --warp west
      cmd + shift - right : yabai -m window --warp east
      cmd + shift - up    : yabai -m window --warp north
      cmd + shift - down  : yabai -m window --warp south

      # ── Workspaces 1–10 ──────────────────────────────────────────────────────────────
      cmd - 1 : yabai -m space --focus 1
      cmd - 2 : yabai -m space --focus 2
      cmd - 3 : yabai -m space --focus 3
      cmd - 4 : yabai -m space --focus 4
      cmd - 5 : yabai -m space --focus 5
      cmd - 6 : yabai -m space --focus 6
      cmd - 7 : yabai -m space --focus 7
      cmd - 8 : yabai -m space --focus 8
      cmd - 9 : yabai -m space --focus 9
      cmd - 0 : yabai -m space --focus 10

      # ── Move window to space (follow) ──────────────────────────────────────────────────────────────
      cmd + shift - 1 : yabai -m window --space 1;  yabai -m space --focus 1
      cmd + shift - 2 : yabai -m window --space 2;  yabai -m space --focus 2
      cmd + shift - 3 : yabai -m window --space 3;  yabai -m space --focus 3
      cmd + shift - 4 : yabai -m window --space 4;  yabai -m space --focus 4
      cmd + shift - 5 : yabai -m window --space 5;  yabai -m space --focus 5
      cmd + shift - 6 : yabai -m window --space 6;  yabai -m space --focus 6
      cmd + shift - 7 : yabai -m window --space 7;  yabai -m space --focus 7
      cmd + shift - 8 : yabai -m window --space 8;  yabai -m space --focus 8
      cmd + shift - 9 : yabai -m window --space 9;  yabai -m space --focus 9
      cmd + shift - 0 : yabai -m window --space 10; yabai -m space --focus 10

      # ── Move window to space (silent) ──────────────────────────────────────────────────────────────
      shift + alt - 1 : yabai -m window --space 1
      shift + alt - 2 : yabai -m window --space 2
      shift + alt - 3 : yabai -m window --space 3
      shift + alt - 4 : yabai -m window --space 4
      shift + alt - 5 : yabai -m window --space 5
      shift + alt - 6 : yabai -m window --space 6
      shift + alt - 7 : yabai -m window --space 7
      shift + alt - 8 : yabai -m window --space 8
      shift + alt - 9 : yabai -m window --space 9
      shift + alt - 0 : yabai -m window --space 10

      # ── Send window to monitor ──────────────────────────────────────────────────────────────
      shift + ctrl + alt - 0x1A : yabai -m window --display prev; yabai -m display --focus prev
      shift + ctrl + alt - 0x1B : yabai -m window --display next; yabai -m display --focus next

      # ── Layout toggles ──────────────────────────────────────────────────────────────
      cmd + shift - s : yabai -m window --toggle split
      cmd + shift - g : yabai -m window --toggle sticky

      # ── App launchers ──────────────────────────────────────────────────────────────
      cmd - return         : open -na kitty
      cmd + shift - return : open -na kitty --args nvim --args 'terminal' -c 'startinsert'
      cmd - b              : open -na "Firefox"
      cmd - n              : open -na kitty --args nvim
      cmd - r              : open -na kitty --args ranger
      cmd - f10            : open -na kitty --args lazysql

      # ── Screenshots ──────────────────────────────────────────────────────────────
      cmd - f10       : screencapture -i -c
      cmd + ctrl - f10 : screencapture -T 2 -i -c
      cmd - 0x69       : screencapture -i -c

      # ── Volume ──────────────────────────────────────────────────────────────
      cmd - f11 : osascript -e 'set volume output volume (output volume of (get volume settings) - 5)'
      cmd - f12 : osascript -e 'set volume output volume (output volume of (get volume settings) + 5)'
    '';
  };
}
