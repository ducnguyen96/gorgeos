{pkgs}: {
  network = {
    interval = 5;

    format-wifi = "󰤨";
    format-ethernet = "󰈀";
    format-disconnected = "󰤭";

    tooltip-format-wifi = "{essid} ({signalStrength}%)";
    tooltip-format-ethernet = "{ifname}";
    tooltip-format-disconnected = "Disconnected";

    on-click = "${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
  };

  bluetooth = {
    format = "";
    tooltip = false;
    on-click = "blueman-manager";
  };
}
