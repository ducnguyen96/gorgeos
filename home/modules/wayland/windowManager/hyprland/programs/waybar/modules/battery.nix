{
  battery = {
    interval = 30;

    states = {
      warning = 30;
      critical = 15;
    };

    format = "{icon}";
    format-charging = "󰂄";
    format-plugged = "󱘖";

    format-icons = [
      "󰁺"
      "󰁻"
      "󰁼"
      "󰁽"
      "󰁾"
      "󰁿"
      "󰂀"
      "󰂁"
      "󰂂"
      "󰁹"
    ];

    tooltip-format = "{capacity}%";
  };
}
