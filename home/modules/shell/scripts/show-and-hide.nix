{pkgs, ...}: let
  show-and-hide = pkgs.writeShellScriptBin "show-and-hide" ''
    #!/usr/bin/env bash
    APP_NAME=""
    while [[ $# -gt 0 ]]; do
      case $1 in
        --app) APP_NAME="$2"; shift 2 ;;
        *) echo "Unknown option: $1"; exit 1 ;;
      esac
    done
    if [ -z "$APP_NAME" ]; then
      echo "Usage: show-and-hide --app <Zalo|Youtube>"
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
    position_window() {
      local addr=$1
      local show=$2  # "show" or "hide"
      local pad_top=50 pad_bottom=10 pad=10
      local w_width=$(echo "$mW - 2 * $pad" | bc)
      local w_height=$(echo "$mH - $pad_top - $pad_bottom" | bc)
      local p_x=$(echo "$mX + $pad" | bc)
      local p_y

      if [ "$show" = "show" ]; then
        p_y=$(echo "$mY + $pad_top" | bc)
        hyprctl --batch "
          dispatch setfloating address:$addr;
          dispatch resizewindowpixel exact $w_width $w_height,address:$addr;
          dispatch movewindowpixel exact $p_x $p_y,address:$addr;
          dispatch focuswindow address:$addr;
          dispatch bringactivetotop"
      else
        p_y=$(echo "$mY + $mH + 100" | bc)  # Move below monitor (out of view)
        hyprctl --batch "
          dispatch setfloating address:$addr;
          dispatch resizewindowpixel exact $w_width $w_height,address:$addr;
          dispatch movewindowpixel exact $p_x $p_y,address:$addr"
      fi
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
        position_window "$addr" "show"
      fi
    else
      # APP FOUND: Toggle based on focus and position
      addr=$(echo "$app_client" | jq -r '.address')
      p_y=$(echo "$app_client" | jq -r '.at[1]')
      is_focused=$(echo "$app_client" | jq -r '.focusHistoryID == 0')

      # Check if window is hidden (y position is below monitor)
      hidden_threshold=$(echo "$mY + $mH" | bc)
      is_hidden=$([[ "$p_y" -gt "$hidden_threshold" ]] && echo "true" || echo "false")

      if [ "$is_hidden" = "true" ] || [ "$is_focused" = "false" ]; then
        # Window is hidden or not focused -> Show it on side
        hyprctl dispatch movetoworkspacesilent "$current_workspace,address:$addr"
        position_window "$addr" "show"
      else
        # Window is visible and focused -> Hide it below monitor
        position_window "$addr" "hide"
        another_client=$(
          hyprctl clients -j | jq -r "
            .[]
            | select(
                .workspace.id == $current_workspace
                and .address != \"$addr\"
                and .mapped == true
                and .at[1] <= $hidden_threshold
              )
            | .address
          " | head -n 1
        )
        if [ -n "$another_client" ]; then
          hyprctl dispatch focuswindow "address:$another_client"
        fi
      fi
    fi
    hyprctl dispatch bringactivetotop
  '';
in {
  home.packages = [show-and-hide];
}
