{pkgs, ...}: let
  wofi-ollama = pkgs.writeShellScriptBin "wofi-ollama" ''
    #!/usr/bin/env bash
    WOFI_HEIGHT=130px
    WOFI_COLUMNS=5
    WOFI_LINES=1

    # Rofi config to mimic your Wofi settings
    # We use -theme-str to inject layout changes on the fly
    rofi_command="rofi -dmenu \
                -p Models \
                -i \
                -theme-str window{height:$WOFI_HEIGHT;} \
                -theme-str listview{columns:$WOFI_COLUMNS;lines:$WOFI_LINES;} \
                -matching fuzzy"

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
          echo "Stop Ollama"
        else
          # Add each model to menu, mark current one
          while IFS= read -r model; do
            if [ "$model" = "$current" ]; then
              echo "󰄬 $model"
            else
              echo "$model"
            fi
          done <<<"$models"
          echo "Stop Ollama"
        fi
      else
        echo "Start Ollama"
      fi
    }

    # Main menu
    choice=$(build_menu | $rofi_command)

    # Exit if no choice made
    [ -z "$choice" ] && exit 0

    # Extract just the model name (remove icon)
    model_name=$(echo "$choice" | sed 's/^[󰄬 ]* //')

    case "$choice" in
    "Start Ollama")
      # Start ollama serve in background
      systemctl --user start ollama.service
      sleep 1
      notify-send "Ollama" "Started"
      ;;

    "Stop Ollama")
      systemctl --user stop ollama.service
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
