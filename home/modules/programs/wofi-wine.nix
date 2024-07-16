{pkgs, ...}: let
  wofi-wine = pkgs.writeShellScriptBin "wofi-wine" ''
    #!/usr/bin/env bash

    # Define the directory to search
    WINE_DIR="$HOME/.wine"

    # Use find to locate all .exe files in the specified directory
    EXE_FILES=$(find "$WINE_DIR" -type f -name "*.exe")

    # If no .exe files are found, notify the user and exit
    if [ -z "$EXE_FILES" ]; then
      echo "No .exe files found in $WINE_DIR."
      exit 1
    fi

    # Use wofi to display the .exe files and capture the selected file
    SELECTED_FILE=$(echo "$EXE_FILES" | wofi --show dmenu -i --prompt "Select an .exe file:")

    # If a file was selected, run it with wine
    if [ -n "$SELECTED_FILE" ]; then
      wine "$SELECTED_FILE"
    else
      echo "No file selected."
    fi

  '';
in {
  home.packages = [wofi-wine];
}
