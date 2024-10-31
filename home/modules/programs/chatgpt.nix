{
  pkgs,
  config,
  ...
}: let
  chatgpt = "brave --class=ChatGPT --app=https://chatgpt.com --ozone-platform-hint=auto --enable-wayland-ime --wayland-text-input-version=3";

  toggle-chatgpt = pkgs.writeShellScriptBin "toggle-chatgpt" ''
    APP_CLASS="brave-chatgpt.com__-Default"

    active_workspace=$(hyprctl activeworkspace -j | jq -r ".id")
    current_workspace=$(hyprctl clients -j | jq -r ".[] | select(.class == \"$APP_CLASS\") | .workspace.id")

    if [ -z "$current_workspace" ]; then
      ${chatgpt}
      current_workspace = 10
    fi

    if [ "$current_workspace" -ne "$active_workspace" ]; then
      hyprctl dispatch movetoworkspacesilent $active_workspace,class:"^($APP_CLASS)$"
      hyprctl dispatch focuswindow class:"^($APP_CLASS)$"
    else
      hyprctl dispatch movetoworkspacesilent 10,class:"^($APP_CLASS)$"
    fi  '';
in {
  home.file."chatgpt.desktop" = {
    text = ''
      [Desktop Entry]
      Name=ChatGPT
      Comment=ChatGPT.com via brave
      Exec=${chatgpt}
      Terminal=false
      Type=Application
      Icon=chatgpt
      Categories=Utility;
    '';

    target = "${config.home.homeDirectory}/.local/share/applications/chatgpt.desktop";
  };

  home.packages = with pkgs; [brave toggle-chatgpt];
}
