{pkgs, ...}: let
  wofi-remmina = pkgs.writeShellScriptBin "wofi-remmina" ''
    #!/usr/bin/env bash
    # Wofi window config (in %)
    WOFI_WIDTH=50
    WOFI_HEIGHT=20
    WOFI_COLUMNS=1

    wofi_command="wofi --show dmenu \
    	--prompt 'Remmina Profiles...' \
    	--width=$WOFI_WIDTH% --height=$WOFI_HEIGHT% --columns=$WOFI_COLUMNS \
    	--cache-file=/dev/null \
    	--hide-scroll --no-actions \
    	--matching=fuzzy"

    REMMINA_DIR="$HOME/.local/share/remmina"

    # Check if remmina directory exists
    if [ ! -d "$REMMINA_DIR" ]; then
      notify-send "Remmina" "Remmina directory not found: $REMMINA_DIR"
      exit 1
    fi

    # Extract profile names from .remmina files
    # Pattern: group_rdp_<profile>_<ip>.remmina -> extract <profile>
    profiles=""
    for file in "$REMMINA_DIR"/*.remmina; do
      if [ -f "$file" ]; then
        filename=$(basename "$file" .remmina)
        # Extract profile name (assumes format: group_rdp_<profile>_<rest>)
        # Split by underscore and get the 3rd field (index 2)
        profile=$(echo "$filename" | cut -d'_' -f3)
        if [ ! -z "$profile" ]; then
          profiles="$profiles$profile\n"
        fi
      fi
    done

    if [ -z "$profiles" ]; then
      notify-send "Remmina" "No profiles found in $REMMINA_DIR"
      exit 1
    fi

    # Remove trailing newline
    profiles=$(echo -e "$profiles" | sed '/^$/d')

    # Display profiles and get user selection
    selected_profile=$(echo -e "$profiles" | $wofi_command -i --dmenu)

    if [ -z "$selected_profile" ]; then
      exit 0
    fi

    # Find the remmina file for the selected profile
    profile_file=""
    for file in "$REMMINA_DIR"/*.remmina; do
      if [ -f "$file" ]; then
        filename=$(basename "$file" .remmina)
        profile=$(echo "$filename" | cut -d'_' -f3)
        if [ "$profile" = "$selected_profile" ]; then
          profile_file="$file"
          break
        fi
      fi
    done

    if [ -z "$profile_file" ]; then
      notify-send "Remmina" "Profile file not found for: $selected_profile"
      exit 1
    fi

    # Check if remmina is already running with this profile
    profile_basename=$(basename "$profile_file")
    is_running=$(pgrep -f "remmina.*$profile_basename" || true)

    if [ ! -z "$is_running" ]; then
      # Disconnect: kill the remmina process for this profile
      notify-send "Remmina" "Disconnecting from $selected_profile..."
      pkill -f "remmina.*$profile_basename"
      notify-send "Remmina" "Disconnected from $selected_profile"
      exit 0
    fi

    # Connect: check and start domain if needed
    domain_name="$selected_profile"
    
    # Check if domain exists in virsh
    domain_exists=$(sudo virsh list --all --name | grep -E "^$domain_name$" || true)
    
    if [ ! -z "$domain_exists" ]; then
      # Domain exists, check if it's running
      domain_running=$(sudo virsh list --state-running --name | grep -E "^$domain_name$" || true)
      
      if [ -z "$domain_running" ]; then
        # Check and start libvirt network if needed
        network_name="default"
        # Parse network state from virsh net-list --all output
        # Format: Name      State    Autostart   Persistent
        # Skip header lines and dashes, get the line with the network name
        # Use awk to match the network name (handles leading/trailing whitespace)
        network_state=$(sudo virsh net-list --all | awk -v name="$network_name" 'NF >= 2 && $1 == name {print $2; exit}' || true)
        
        if [ ! -z "$network_state" ]; then
          if [ "$network_state" != "active" ]; then
            notify-send "Remmina" "Starting libvirt network $network_name..."
            # Suppress stderr and check exit code
            if ! sudo virsh net-start "$network_name" 2>/dev/null; then
              # Check if network became active (might have been started by another process)
              network_state=$(sudo virsh net-list --all | awk -v name="$network_name" 'NF >= 2 && $1 == name {print $2; exit}' || true)
              if [ "$network_state" != "active" ]; then
                notify-send "Remmina" "Failed to start network $network_name"
                exit 1
              fi
            fi
            
            # Wait for network to be active (check every 1 second, max 10 seconds)
            max_network_wait=10
            network_waited=0
            while [ $network_waited -lt $max_network_wait ]; do
              sleep 1
              network_waited=$((network_waited + 1))
              network_state=$(sudo virsh net-list --all | awk -v name="$network_name" 'NF >= 2 && $1 == name {print $2; exit}' || true)
              if [ "$network_state" = "active" ]; then
                notify-send "Remmina" "Network $network_name is active"
                break
              fi
            done
            
            if [ $network_waited -ge $max_network_wait ]; then
              notify-send "Remmina" "Timeout waiting for network $network_name to start"
              exit 1
            fi
          fi
        fi
        
        # Domain exists but is not running, start it
        notify-send "Remmina" "Starting domain $domain_name..."
        if ! sudo virsh start "$domain_name"; then
          notify-send "Remmina" "Failed to start domain $domain_name"
          exit 1
        fi
        
        # Wait for domain to be ready (check every 2 seconds, max 60 seconds)
        max_wait=60
        waited=0
        while [ $waited -lt $max_wait ]; do
          sleep 2
          waited=$((waited + 2))
          domain_running=$(sudo virsh list --state-running --name | grep -E "^$domain_name$" || true)
          if [ ! -z "$domain_running" ]; then
            # Additional wait for domain to fully initialize (e.g., network, services)
            sleep 5
            notify-send "Remmina" "Domain $domain_name is ready"
            break
          fi
        done
        
        if [ $waited -ge $max_wait ]; then
          notify-send "Remmina" "Timeout waiting for domain $domain_name to start"
          exit 1
        fi
      fi
    fi

    # Connect using remmina
    notify-send "Remmina" "Connecting to $selected_profile..."
    remmina -c "$profile_file" &
    notify-send "Remmina" "Connected to $selected_profile"
  '';
in {
  home.packages = [wofi-remmina];
}

