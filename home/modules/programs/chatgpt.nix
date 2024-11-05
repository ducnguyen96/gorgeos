{pkgs, ...}: let
  toggle-chatgpt = pkgs.writeShellScriptBin "toggle-chatgpt" ''
    TITLE="ChatGPT — Mozilla Firefox"

    active_workspace=$(hyprctl activeworkspace -j | jq -r ".id")
    current_workspace=$(hyprctl clients -j | jq -r ".[] | select(.title == \"$TITLE\") | .workspace.id")

    PID=$(hyprctl clients -j | jq -r ".[] | select(.title == \"$TITLE\") | .pid")

    if [ -z "$current_workspace" ]; then
      nohup firefox https://chatgpt.com -P chatgpt &

      sleep 3

      PID=$(hyprctl clients -j | jq -r ".[] | select(.title == \"$TITLE\") | .pid")

      hyprctl dispatch movetoworkspacesilent 10,pid:$PID
      current_workspace = 10
      hyprctl dispatch setfloating pid:$PID
      # TODO: improve hardcoded numbers
      hyprctl dispatch resizewindowpixel exact 30% 95%,pid:$PID
      hyprctl dispatch movewindowpixel exact 1340 50,pid:$PID
    fi

    if [ "$current_workspace" -ne "$active_workspace" ]; then
      hyprctl dispatch movetoworkspacesilent $active_workspace,pid:$PID
      hyprctl dispatch focuswindow pid:$PID
    else
      hyprctl dispatch movetoworkspacesilent 10,pid:$PID
    fi  '';
in {
  home.packages = [toggle-chatgpt];
}
