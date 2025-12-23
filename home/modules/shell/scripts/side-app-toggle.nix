{pkgs, ...}: let
  side-app-toggle = pkgs.writeShellScriptBin "side-app-toggle" ''
    #!/usr/bin/env bash

    # Parse arguments
    APP_NAME=""
    while [[ $# -gt 0 ]]; do
      case $1 in
        --app)
          APP_NAME="$2"
          shift 2
          ;;
        *)
          echo "Unknown option: $1"
          exit 1
          ;;
      esac
    done

    # Check if app name is provided
    if [ -z "$APP_NAME" ]; then
      echo "Usage: special-app-toggle --app <Zalo|Youtube>"
      exit 1
    fi

    # Set URL and title pattern based on app
    case "$APP_NAME" in
      Zalo)
        APP_URL="https://chat.zalo.me"
        TITLE_PATTERN="Zalo"
        ;;
      Youtube)
        APP_URL="https://youtube.com"
        TITLE_PATTERN="YouTube"
        ;;
      *)
        echo "Unknown app: $APP_NAME"
        echo "Supported apps: Zalo, Youtube"
        exit 1
        ;;
    esac

    # Get current workspace
    current_workspace=$(hyprctl activeworkspace -j | jq -r '.id')

    # Find app client
    app_client=$(hyprctl clients -j | jq -r ".[] | select(.title | contains(\"$TITLE_PATTERN\"))")

    if [ -z "$app_client" ]; then
      # App not found, open Firefox with app URL
      firefox -new-window "$APP_URL"

      # Wait for window to open
      sleep 2

      new_window=$(hyprctl clients -j | jq -r ".[] | select(.title | contains(\"$TITLE_PATTERN\"))" | jq -r '.address')

      if [ -n "$new_window" ]; then
        # Toggle to floating mode
        hyprctl dispatch togglefloating "address:$new_window"

        # Get monitor info
        monitor_info=$(hyprctl monitors -j | jq -r ".[] | select(.id == $(hyprctl activeworkspace -j | jq -r '.monitorID'))")
        monitor_x=$(echo "$monitor_info" | jq -r '.x')
        monitor_y=$(echo "$monitor_info" | jq -r '.y')
        monitor_width=$(echo "$monitor_info" | jq -r '.width')
        monitor_height=$(echo "$monitor_info" | jq -r '.height')

        # padding
        pad_top=50
        pad_bottom=10
        pad_right=20

        # Calculate size (25% width, adjusted height)
        window_width=$(echo "$monitor_width * 0.25" | bc | cut -d. -f1)
        window_height=$(echo "$monitor_height - $pad_top - $pad_bottom" | bc)

        # Calculate position (right side of monitor)
        pos_x=$(echo "$monitor_x + $monitor_width - $window_width - $pad_right" | bc)
        pos_y=$(echo "$monitor_y + $pad_top" | bc)

        # Resize and move window
        hyprctl dispatch resizewindowpixel "exact $window_width $window_height,address:$new_window"
        hyprctl dispatch movewindowpixel "exact $pos_x $pos_y,address:$new_window"

        # Focus and bring to top
        hyprctl dispatch focuswindow "address:$new_window"
        hyprctl dispatch bringactivetotop
      fi
    else
      # App found, get its info
      app_address=$(echo "$app_client" | jq -r '.address')
      app_workspace=$(echo "$app_client" | jq -r '.workspace.id')

      if [ "$app_workspace" != "$current_workspace" ]; then
        # App is in different workspace, move it here
        hyprctl dispatch movetoworkspacesilent "$current_workspace,address:$app_address"
        hyprctl dispatch focuswindow "address:$app_address"
        hyprctl dispatch bringactivetotop
      else
        # App is in current workspace, move it to workspace 8
        hyprctl dispatch movetoworkspacesilent "8,address:$app_address"

        # Focus to another client
        another_client=$(hyprctl clients -j | jq -r ".[] | select(.workspace.id == $current_workspace)" | jq -r '.address' | head -n 1)
        hyprctl dispatch focuswindow "address:$another_client"
      fi
    fi
  '';
in {
  home.packages = [side-app-toggle];
}
