{pkgs, ...}: let
  xrdp = pkgs.writeShellScriptBin "xrdp" ''
    # Get hostname for cloudflared tunnel service name
    hostname=$(hostname)
    cloudflared_service="cloudflared-tunnel-$hostname"
    
    # Check if xrdp service is running
    xrdp_running=$(systemctl is-active --quiet xrdp && echo "active" || echo "inactive")
    
    # Check if cloudflared tunnel service is running
    cloudflared_running=$(systemctl is-active --quiet "$cloudflared_service" && echo "active" || echo "inactive")
    
    # Consider services running if at least one is active
    if [ "$xrdp_running" = "active" ] || [ "$cloudflared_running" = "active" ]; then
      # Services are running
      notify-send "xrdp" "Disconnecting from xrdp..."
      
      # Stop the services
      if [ "$xrdp_running" = "active" ]; then
        notify-send "xrdp" "Stopping xrdp service..."
        if sudo systemctl stop xrdp; then
          notify-send "xrdp" "xrdp service stopped"
        else
          notify-send "xrdp" "Failed to stop xrdp service"
          exit 1
        fi
      fi
      
      if [ "$cloudflared_running" = "active" ]; then
        notify-send "xrdp" "Stopping $cloudflared_service service..."
        if sudo systemctl stop "$cloudflared_service"; then
          notify-send "xrdp" "$cloudflared_service service stopped"
        else
          notify-send "xrdp" "Failed to stop $cloudflared_service service"
          exit 1
        fi
      fi
    else
      # Services are not running, start them
      notify-send "xrdp" "Starting xrdp service..."
      if ! sudo systemctl start xrdp; then
        notify-send "xrdp" "Failed to start xrdp service"
        exit 1
      fi
      
      notify-send "xrdp" "Starting $cloudflared_service service..."
      if ! sudo systemctl start "$cloudflared_service"; then
        notify-send "xrdp" "Failed to start $cloudflared_service service"
        # Try to stop xrdp if cloudflared failed
        sudo systemctl stop xrdp || true
        exit 1
      fi
      
      # Wait for services to be ready (check every 2 seconds, max 30 seconds)
      max_wait=30
      waited=0
      while [ $waited -lt $max_wait ]; do
        sleep 2
        waited=$((waited + 2))
        xrdp_running=$(systemctl is-active --quiet xrdp && echo "active" || echo "inactive")
        cloudflared_running=$(systemctl is-active --quiet "$cloudflared_service" && echo "active" || echo "inactive")
        if [ "$xrdp_running" = "active" ] && [ "$cloudflared_running" = "active" ]; then
          # Additional wait for services to fully initialize
          sleep 3
          notify-send "xrdp" "Services are ready"
          break
        fi
      done
      
      if [ $waited -ge $max_wait ]; then
        notify-send "xrdp" "Timeout waiting for services to start"
        exit 1
      fi
    fi
  '';
in {
  home.packages = [xrdp];
}

