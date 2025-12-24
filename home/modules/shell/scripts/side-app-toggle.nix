{pkgs, ...}: let
  side-app-toggle = pkgs.writeShellScriptBin "side-app-toggle" ''
    #!/usr/bin/env bash
    APP_NAME=""
    while [[ $# -gt 0 ]]; do
      case $1 in
        --app) APP_NAME="$2"; shift 2 ;;
        *) echo "Unknown option: $1"; exit 1 ;;
      esac
    done

    if [ -z "$APP_NAME" ]; then
      echo "Usage: side-app-toggle --app <Zalo|Youtube>"
      exit 1
    fi

    case "$APP_NAME" in
      Zalo) APP_URL="https://chat.zalo.me"; TITLE_PATTERN="Zalo" ;;
      Youtube) APP_URL="https://youtube.com"; TITLE_PATTERN="YouTube" ;;
      *) echo "Unknown app: $APP_NAME"; exit 1 ;;
    esac

    # 1. Get Environment State
    active_info=$(hyprctl activeworkspace -j)
    current_workspace=$(echo "$active_info" | jq -r '.id')
    monitor_id=$(echo "$active_info" | jq -r '.monitorID')

    # Get Monitor Geometry
    monitor_info=$(hyprctl monitors -j | jq -r ".[] | select(.id == $monitor_id)")
    read -r mX mY mW mH <<< "$(echo "$monitor_info" | jq -r '.x, .y, .width, .height' | xargs)"

    # 2. Define Positioning Logic
    apply_side_geometry() {
      local addr=$1
      local pad_top=50 pad_bottom=10 pad_left=20
      local w_width=$(echo "$mW * 0.25" | bc | cut -d. -f1)
      local w_height=$(echo "$mH - $pad_top - $pad_bottom" | bc)
      local p_x=$(echo "$mX + $pad_left" | bc)
      local p_y=$(echo "$mY + $pad_top" | bc)

      hyprctl --batch "
        dispatch setfloating address:$addr;
        dispatch resizewindowpixel exact $w_width $w_height,address:$addr;
        dispatch movewindowpixel exact $p_x $p_y,address:$addr;
        dispatch focuswindow address:$addr;
        dispatch bringactivetotop"
    }

    # 3. Find app client
    app_client=$(hyprctl clients -j | jq -r ".[] | select(.title | contains(\"$TITLE_PATTERN\"))")

    if [ -z "$app_client" ]; then
      # APP NOT FOUND: Launch and Wait
      firefox -new-window "$APP_URL" &
      addr=""
      for i in {1..50}; do # 10 seconds max (50 * 0.2)
        addr=$(hyprctl clients -j | jq -r ".[] | select(.title | contains(\"$TITLE_PATTERN\")) | .address" | head -n 1)
        [ -n "$addr" ] && break
        sleep 0.2
      done

      if [ -n "$addr" ]; then
        apply_side_geometry "$addr"
      fi
    else
      # APP FOUND: Toggle based on workspace
      read -r addr app_ws <<< "$(echo "$app_client" | jq -r '.address, .workspace.id' | xargs)"

      if [ "$app_ws" = "$current_workspace" ]; then
        # On current workspace -> Move to workspace 8
        hyprctl dispatch movetoworkspacesilent "8,address:$addr"
        another_client=$(hyprctl clients -j | jq -r ".[] | select(.workspace.id == $current_workspace)" | jq -r '.address' | head -n 1)
        hyprctl dispatch focuswindow "address:$another_client"
      else
        # Not on current workspace -> Move here, fix geometry and focus
        hyprctl dispatch movetoworkspacesilent "$current_workspace,address:$addr"
        apply_side_geometry "$addr"
      fi
    fi
  '';
in {
  home.packages = [side-app-toggle];
}
