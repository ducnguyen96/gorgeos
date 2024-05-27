{config, ...}: {
  home.file."${config.home.homeDirectory}/.config/sway/config.d/monitors.conf".text = ''
    workspace 1 output DP-2
    workspace 3 output DP-2
    workspace 5 output DP-2
    workspace 7 output DP-2
    workspace 9 output DP-2

    workspace 2 output HDMI-A-1
    workspace 4 output HDMI-A-1
    workspace 6 output HDMI-A-1
    workspace 8 output HDMI-A-1
    workspace 0 output HDMI-A-1

    output DP-2 pos 0 0 res 1920x1080
    output HDMI-A-1 pos 1920 0 res 1920x1080
  '';
}
