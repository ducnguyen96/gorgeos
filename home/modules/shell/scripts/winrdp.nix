{pkgs, ...}: let
  winrdp = pkgs.writeShellScriptBin "winrdp" ''
    container_name="windows"
    REMMINA_DIR="$HOME/.local/share/remmina"

    # Check if docker container is running
    container_running=$(docker ps --format "{{.Names}}" | grep -E "^$container_name$" || true)

    if [ -z "$container_running" ]; then
      # Container is not running, start it
      notify-send "winrdp" "Starting container $container_name..."
      if ! docker start "$container_name"; then
        notify-send "winrdp" "Failed to start container $container_name"
        exit 1
      fi

      # Wait for container to be ready (check every 2 seconds, max 60 seconds)
      max_wait=60
      waited=0
      while [ $waited -lt $max_wait ]; do
        sleep 2
        waited=$((waited + 2))
        container_running=$(docker ps --format "{{.Names}}" | grep -E "^$container_name$" || true)
        if [ ! -z "$container_running" ]; then
          # Additional wait for container to fully initialize
          sleep 5
          notify-send "winrdp" "Container $container_name is ready"
          break
        fi
      done

      if [ $waited -ge $max_wait ]; then
        notify-send "winrdp" "Timeout waiting for container $container_name to start"
        exit 1
      fi

      # Find remmina profile with "win10" in the name
      profile_file=""
      if [ -d "$REMMINA_DIR" ]; then
        for file in "$REMMINA_DIR"/*.remmina; do
          if [ -f "$file" ]; then
            filename=$(basename "$file")
            if echo "$filename" | grep -qi "win10"; then
              profile_file="$file"
              break
            fi
          fi
        done
      fi

      if [ -z "$profile_file" ]; then
        notify-send "winrdp" "Remmina profile with 'win10' not found in $REMMINA_DIR"
        exit 1
      fi

      # Open remmina with the profile
      notify-send "winrdp" "Connecting to Windows..."
      remmina -c "$profile_file" &
      notify-send "winrdp" "Connected to Windows"
    else
      # Container is running, close remmina and stop container
      notify-send "winrdp" "Disconnecting from Windows..."

      # Kill all remmina processes
      pkill remmina || true

      # Stop the container
      notify-send "winrdp" "Stopping container $container_name..."
      if docker stop "$container_name"; then
        notify-send "winrdp" "Container $container_name stopped"
      else
        notify-send "winrdp" "Failed to stop container $container_name"
        exit 1
      fi
    fi
  '';
in {
  home.packages = [winrdp];
}
