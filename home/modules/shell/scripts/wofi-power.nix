{pkgs, ...}: let
  wofi-power = pkgs.writeShellScriptBin "wofi-power" ''
    #!/usr/bin/env bash
    WOFI_HEIGHT=130px
    WOFI_COLUMNS=5
    WOFI_LINES=1

    # Rofi config to mimic your Wofi settings
    # We use -theme-str to inject layout changes on the fly
    rofi_command="rofi -dmenu \
            -p Menus \
            -i \
            -theme-str window{height:$WOFI_HEIGHT;} \
            -theme-str listview{columns:$WOFI_COLUMNS;lines:$WOFI_LINES;} \
            -matching fuzzy"

    # Input entries
    entries=" Poweroff\n Reboot\n Suspend\n Lock\n Logout"

    # Execute
    selected=$(echo -e "$entries" | $rofi_command | awk '{print tolower($2)}')

    case $selected in
    poweroff | reboot | suspend)
      systemctl $selected
      ;;
    lock)
      # Add your lock command here, e.g., swaylock or hyprlock
      ;;
    logout)
      hyprctl dispatch exit 0
      ;;
    esac
  '';
in {
  home.packages = [wofi-power];
}
