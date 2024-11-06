{
  lib,
  pkgs,
  ...
}: let
  _ = lib.getExe;

  vcpctl = let
    inherit (pkgs) ddcutil libnotify;
  in
    pkgs.writeShellScriptBin "vcpctl" ''
      #!/usr/bin/env bash
      current_mnt=$(($(hyprctl activewindow -j | jq ".monitor") + 1))

      read current_brn max_brn < <(ddcutil -d $current_mnt getvcp 10 | awk -F'current value = |, max value = ' '{print $2, $3}')
      read current_cts max_cts < <(ddcutil -d $current_mnt getvcp 12 | awk -F'current value = |, max value = ' '{print $2, $3}')

      percentage=0

      case "$1" in
      up)
        ${_ ddcutil} -d $current_mnt setvcp 10 $(( $current_brn + "$2" ))
        ${_ ddcutil} -d $current_mnt setvcp 12 $(( $current_cts + "$2" ))
        percentage=$(( $current_brn + "$2" ))
        ;;
      down)
        ${_ ddcutil} -d $current_mnt setvcp 10 $(( $current_brn - "$2" ))
        ${_ ddcutil} -d $current_mnt setvcp 12 $(( $current_cts - "$2" ))
        percentage=$(( $current_brn - "$2" ))
        ;;
      esac


      ${libnotify}/bin/notify-send --transient \
          -u normal \
          -a "vcpctl" \
          -h string:x-canonical-private-synchronous:vcpctl \
          -h int:value:"$percentage" \
          -i brightness-high-symbolic \
          "vcpctl" "Brightness: $percentage%"
    '';
in {
  home.packages = with pkgs; [
    pciutils
    ddcutil
    ddcui

    vcpctl
  ];
}
