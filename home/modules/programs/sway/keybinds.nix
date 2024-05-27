{config, ...}: {
  home.file."${config.home.homeDirectory}/.config/sway/config.d/keybinds.conf".text = ''
    $bindsym F10 mode $mode_screenshot
    $bindsym $mod+q kill
  '';
}
