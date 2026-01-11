{pkgs, ...}: let
  wofi-ollama = pkgs.writeShellScriptBin "wofi-ollama" ''
    #!/usr/bin/env bash

    # Wofi window config (in %)
    WOFI_WIDTH=50
    WOFI_HEIGHT=30
    WOFI_COLUMNS=1

    wofi_command="wofi --show dmenu \
        --prompt 'Ollama...' \
        --width=$WOFI_WIDTH% --height=$WOFI_HEIGHT% --columns=$WOFI_COLUMNS \
        --cache-file=/dev/null \
        --hide-scroll --no-actions \
        --matching=fuzzy"

    # Check if ollama is running
    is_running() {
        ollama list &>/dev/null
        return $?
    }

    # Get currently running model
    get_current_model() {
        ollama ps 2>/dev/null | tail -n +2 | awk '{print $1}' | head -n 1
    }

    # Build menu options based on service status
    build_menu() {
        if is_running; then
            # Get list of available models
            models=$(ollama list 2>/dev/null | tail -n +2 | awk '{print $1}')

            current=$(get_current_model)

            if [ -z "$models" ]; then
                echo " Stop Ollama"
            else
                # Add each model to menu, mark current one
                while IFS= read -r model; do
                    if [ "$model" = "$current" ]; then
                        echo "󰄬 $model"
                    else
                        echo " $model"
                    fi
                done <<< "$models"
                echo " Stop Ollama"
            fi
        else
            echo " Start Ollama"
        fi
    }

    # Main menu
    choice=$(build_menu | $wofi_command -i --dmenu)

    # Exit if no choice made
    [ -z "$choice" ] && exit 0

    # Extract just the model name (remove icon)
    model_name=$(echo "$choice" | sed 's/^[󰄬 ]* //')

    case "$choice" in
        " Start Ollama")
            # Start ollama serve in background
            nohup ollama serve &>/dev/null &
            sleep 1
            notify-send "Ollama" "Started"
            ;;

        " Stop Ollama")
            pkill ollama
            notify-send "Ollama" "Stopped"
            ;;

        *)
            # User selected a model
            notify-send "Ollama" "Switching to: $model_name"

            # Stop any running models by running a simple command with the new model
            # This will automatically unload the previous model and load the new one
            echo "" | ollama run "$model_name" &>/dev/null &

            notify-send "Ollama" "Now running: $model_name"
            ;;
    esac
  '';
in {
  home.packages = [wofi-ollama];
}
