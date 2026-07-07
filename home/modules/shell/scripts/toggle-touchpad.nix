{pkgs, ...}: let
  toggle-touchpad = pkgs.writeShellScriptBin "toggle-touchpad" ''
    STATE_FILE="$XDG_RUNTIME_DIR/touchpad_state"
    NAME=$(hyprctl devices -j | jq -r '.mice[] | select(.name | test("touchpad"; "i")) | .name')

    if [ -z "$NAME" ]; then
      notify-send "Touchpad" "No touchpad found"
      exit 1
    fi

    CURRENT=$(cat "$STATE_FILE" 2>/dev/null || echo true)
    if [ "$CURRENT" = true ]; then
      NEW=false
    else
      NEW=true
    fi

    hyprctl keyword "device[$NAME]:enabled" "$NEW"
    echo "$NEW" > "$STATE_FILE"
    notify-send "Touchpad" "Enabled: $NEW"
  '';
in {
  home.packages = [toggle-touchpad];
}
