{
  pkgs,
  config,
}: let
  terminal = config.home.sessionVariables.TERMINAL;
in {
  pulseaudio = {
    scroll-step = 2;

    format = "{icon}";
    format-muted = "󰖁";

    format-icons = {
      default = [
        "󰕿"
        "󰖀"
        "󰕾"
      ];
    };

    tooltip-format = "{volume}%";

    on-click = "${pkgs.pamixer}/bin/pamixer --toggle-mute";
    on-click-right = "${terminal} -e pulsemixer";

    on-scroll-up = "${pkgs.pamixer}/bin/pamixer -i 2";
    on-scroll-down = "${pkgs.pamixer}/bin/pamixer -d 2";
  };

  backlight = {
    format = "{icon}";

    format-icons = [
      "󰃞"
      "󰃟"
      "󰃠"
    ];

    tooltip-format = "{percent}%";

    on-scroll-up = "${pkgs.brightnessctl}/bin/brightnessctl set +2%";
    on-scroll-down = "${pkgs.brightnessctl}/bin/brightnessctl set 2%-";
  };
}
