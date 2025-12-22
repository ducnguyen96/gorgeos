{pkgs, ...}: let
  wofi-workspace-swap = pkgs.writeShellScriptBin "wofi-workspace-swap" ''
    #!/usr/bin/env bash

    # Wofi window config (in %)
    WOFI_WIDTH=60
    WOFI_HEIGHT=40

    # Check for --force flag
    FORCE_MODE=false
    if [ "$1" == "--force" ]; then
      FORCE_MODE=true
    fi

    wofi_command="wofi --show dmenu \
      --prompt 'Select window to move here...' \
      --width=$WOFI_WIDTH% --height=$WOFI_HEIGHT% \
      --cache-file=/dev/null \
      --hide-scroll --no-actions \
      --matching=fuzzy"

    # Get current workspace
    current_workspace=$(hyprctl activeworkspace -j | jq -r '.id')

    # Get clients in workspace 10
    clients_json=$(hyprctl clients -j | jq "[.[] | select(.workspace.id == 10)]")
    client_count=$(echo "$clients_json" | jq 'length')

    if [ "$FORCE_MODE" == "true" ] || [ "$client_count" -eq 0 ]; then
      # Force mode or workspace 10 is empty, move focused window there
      hyprctl dispatch movetoworkspacesilent 10
    elif [ "$client_count" -eq 1 ]; then
      # Only one client, move it directly without menu
      selected_address=$(echo "$clients_json" | jq -r '.[0].address')
      hyprctl dispatch movetoworkspacesilent "$current_workspace,address:$selected_address"
      hyprctl dispatch focuswindow "address:$selected_address"
    elif [ "$client_count" -gt 1 ]; then
      # Multiple clients in workspace 10, show wofi menu
      entries=""
      declare -A address_map

      while IFS= read -r line; do
        address=$(echo "$line" | jq -r '.address')
        class=$(echo "$line" | jq -r '.class')
        title=$(echo "$line" | jq -r '.title')

        # Truncate title if too long
        if [ ''${#title} -gt 50 ]; then
          title="''${title:0:47}..."
        fi

        display_text="[$class] $title"
        entries="$entries$display_text\n"
        address_map["$display_text"]="$address"
      done < <(echo "$clients_json" | jq -c '.[]')

      # Show wofi menu and get selection
      selected=$(echo -e "$entries" | head -n -1 | $wofi_command)

      if [ -n "$selected" ]; then
        selected_address="''${address_map[$selected]}"
        if [ -n "$selected_address" ]; then
          # Move selected window to current workspace
          hyprctl dispatch movetoworkspacesilent "$current_workspace,address:$selected_address"
          # Focus the moved window
          hyprctl dispatch focuswindow "address:$selected_address"
        fi
      fi
    fi
  '';
in {
  home.packages = [wofi-workspace-swap];
}
