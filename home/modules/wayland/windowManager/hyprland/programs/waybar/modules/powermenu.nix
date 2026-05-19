{pkgs}: {
  "custom/lock" = {
    format = "󰌾";
    tooltip = false;
    on-click = "${pkgs.systemd}/bin/loginctl lock-session";
  };

  "custom/suspend" = {
    format = "󰤄";
    tooltip = false;
    on-click = "${pkgs.systemd}/bin/systemctl suspend";
  };

  "custom/reboot" = {
    format = "󰜉";
    tooltip = false;
    on-click = "${pkgs.systemd}/bin/systemctl reboot";
  };

  "custom/power" = {
    format = "󰐥";
    tooltip = false;
    on-click = "${pkgs.systemd}/bin/systemctl poweroff";
  };

  "group/powermenu" = {
    orientation = "horizontal";

    modules = [
      "custom/lock"
      "custom/suspend"
      "custom/reboot"
      "custom/power"
    ];
  };
}
