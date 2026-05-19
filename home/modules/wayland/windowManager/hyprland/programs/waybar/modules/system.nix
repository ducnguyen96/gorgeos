{
  cpu = {
    interval = 5;
    format = " {usage}%";
    tooltip = false;
  };

  memory = {
    interval = 10;
    format = " {}%";
    tooltip-format = "{used:0.1f}G / {total:0.1f}G";
  };

  temperature = {
    critical-threshold = 85;
    format = " {temperatureC}°C";
    format-critical = "󰸁 {temperatureC}°C";
  };
}
