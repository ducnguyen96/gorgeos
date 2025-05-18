{pkgs, ...}: let
  wofi-ollama = pkgs.writeShellScriptBin "wofi-ollama" ''
    #!/usr/bin/env bash
    # Wofi window config (in %)
    WOFI_WIDTH=60
    WOFI_HEIGHT=40
    WOFI_COLUMNS=1

    wofi_command="wofi --show dmenu \
    	--prompt 'Choose Ollama Model...' \
    	--width=$WOFI_WIDTH% --height=$WOFI_HEIGHT% --columns=$WOFI_COLUMNS \
    	--cache-file=/dev/null \
    	--hide-scroll --no-actions \
    	--matching=fuzzy"

    # Get list of models from ollama
    models=$(ollama list | awk 'NR>1 {print $1}')

    if [ -z "$models" ]; then
      notify-send "Ollama" "No models found. Please make sure ollama is installed and running."
      exit 1
    fi

    # Display models and get user selection
    selected_model=$(echo -e "$models" | $wofi_command -i --dmenu)

    if [ -z "$selected_model" ]; then
      notify-send "Ollama" "No model selected."
      exit 0
    fi

    # Stop all running models
    running_models=$(ollama ps | awk 'NR>1 {print $1}')
    if [ ! -z "$running_models" ]; then
      for model in $running_models; do
        notify-send "Ollama" "Stopping model $model..."
        ollama stop $model
        notify-send "Ollama" "$model stopped"
      done
    fi

    # Start the selected model
    notify-send "Ollama" "Starting model $selected_model..."
    ollama run $selected_model
    notify-send "Ollama" "$selected_model started"
  '';
in {
  home.packages = [wofi-ollama];
}
