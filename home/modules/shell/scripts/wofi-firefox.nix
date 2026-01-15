{pkgs, ...}: let
  wofi-firefox = pkgs.writeShellScriptBin "wofi-firefox" ''
    #!/usr/bin/env bash
    WOFI_HEIGHT=130px
    WOFI_COLUMNS=5
    WOFI_LINES=1

    wofi_command="rofi -i -dmenu \
        -p Profiles \
        -theme-str window{height:$WOFI_HEIGHT;} \
        -theme-str listview{columns:$WOFI_COLUMNS;lines:$WOFI_LINES;} \
        -matching fuzzy"

    FIREFOX_PROFILES_DIR="$HOME/.mozilla/firefox"
    PROFILES_INI="$FIREFOX_PROFILES_DIR/profiles.ini"

    # Check if profiles.ini exists
    if [ ! -f "$PROFILES_INI" ]; then
      notify-send "Firefox" "Firefox profiles not found: $PROFILES_INI"
      exit 1
    fi

    # Extract profile names from profiles.ini
    # Format: [Profile0], Name=profile_name, Path=profile_path
    # Use awk to parse profiles.ini more reliably
    profiles=$(awk '
          /^\[Profile[0-9]+\]$/ {
            in_profile = 1
            name = ""
            path = ""
          }
          /^\[Install/ {
            in_profile = 0
          }
          in_profile && /^Name=/ {
            name = substr($0, 6)
          }
          in_profile && /^Path=/ {
            path = substr($0, 6)
            # Use name if available, otherwise use path
            if (name != "") {
              print name
            } else if (path != "") {
              print path
            }
            in_profile = 0
          }
        ' "$PROFILES_INI" | sort -u)

    if [ -z "$profiles" ]; then
      notify-send "Firefox" "No profiles found in $PROFILES_INI"
      exit 1
    fi

    # Display profiles and get user selection
    selected_profile=$(echo -e "$profiles" | $wofi_command)

    if [ -z "$selected_profile" ]; then
      exit 0
    fi

    firefox -P "$selected_profile" &
  '';
in {
  home.packages = [wofi-firefox];
}
