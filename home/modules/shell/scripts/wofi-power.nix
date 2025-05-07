{pkgs, ...}: let
  wofi-power = pkgs.writeShellScriptBin "wofi-power" ''
    #!/usr/bin/env bash
    # Wofi window config (in %)
    WOFI_WIDTH=50
    WOFI_HEIGHT=11
    WOFI_COLUMNS=5
    wofi_command="wofi --show dmenu \
    	--prompt choose... \
    	--width=$WOFI_WIDTH% --height=$WOFI_HEIGHT% --columns=$WOFI_COLUMNS \
    	--cache-file=/dev/null \
    	--hide-scroll --no-actions \
    	--matching=fuzzy"
    entries=$(echo -e " Poweroff\n Reboot\n Suspend\n Lock\n Logout" | $wofi_command -i --dmenu | awk '{print tolower($2)}')
    case $entries in
    	poweroff|reboot|suspend)
    		systemctl $entries
    		;;
    lock)
    	;;
    logout)
    	hyprctl dispatch exit 0
    	;;
    esac
  '';
in {
  home.packages = [wofi-power];
}
