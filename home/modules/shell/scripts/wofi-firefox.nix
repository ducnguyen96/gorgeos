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

    FIREFOX_PROFILES_DIR="$HOME/.cache/mozilla/firefox"

    if [ ! -d "$FIREFOX_PROFILES_DIR" ]; then
      notify-send "Firefox" "Firefox profiles directory not found: $FIREFOX_PROFILES_DIR"
      exit 1
    fi

    # Profile folders are named like "abc123.default" or "abc123.my-profile"
    # We extract the part after the first dot as the profile name
    profiles=$(find "$FIREFOX_PROFILES_DIR" -mindepth 1 -maxdepth 1 -type d \
      -name "*.*" \
      | xargs -I{} basename {} \
      | sed 's/^[^.]*\.//' \
      | sort -u)

    if [ -z "$profiles" ]; then
      notify-send "Firefox" "No profiles found in $FIREFOX_PROFILES_DIR"
      exit 1
    fi

    selected_profile=$(echo -e "$profiles" | $wofi_command)

    if [ -z "$selected_profile" ]; then
      exit 0
    fi

    firefox -P "$selected_profile" &
  '';
in {
  home.packages = [wofi-firefox];
}
