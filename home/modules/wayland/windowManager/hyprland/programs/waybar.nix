{
  pkgs,
  config,
  ...
}: let
  terminal = config.home.sessionVariables.TERMINAL;

  fetchCryptoPrice = {
    symbol,
    format,
  }: {
    format = format;
    interval = 60;
    exec = ''
      curl -s https://api.binance.com/api/v3/ticker/price?symbol=${symbol} | jq .price | xargs | awk '{printf "%.2f\n", $1}'
    '';
    tooltip = false;
  };

  fetchAlphaPrice = {
    symbol,
    format,
  }: {
    format = format;
    interval = 60;
    exec = ''
      curl -s 'https://www.binance.com/bapi/defi/v1/public/alpha-trade/agg-trades?limit=1&symbol=${symbol}' | jq '.data[0].p' | xargs | awk '{printf "%.5f\n", $1}'
    '';
    tooltip = false;
  };
in {
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    systemd.target = "graphical-session.target";

    settings = [
      {
        layer = "bottom";
        position = "bottom";
        margin = "0 10 5 10";
        spacing = 8;
        modules-left = ["hyprland/workspaces"];
        modules-center = ["custom/weather" "group/crypto" "clock"];
        modules-right = ["group/cpu-temperature-memory" "group/network-bluetooth-pulseaudio-backlight-battery" "group/tray-notification" "group/powermenu"];

        "hyprland/workspaces" = {
          format = "{id}";
          on-click = "activate";
          disable-scroll = true;
          all-outputs = false;
          show-special = true;
        };

        "custom/weather" = {
          format = "{}°";
          tooltip = true;
          interval = 3600;
          exec = "${pkgs.wttrbar}/bin/wttrbar  --hide-conditions --location Hanoi";
          return-type = "json";
        };

        "custom/btc" = fetchCryptoPrice {
          symbol = "BTCUSDT";
          format = "󰠓: {}";
        };

        "custom/eth" = fetchCryptoPrice {
          symbol = "ETHUSDT";
          format = "󰡪: {}";
        };

        "custom/bnb" = fetchCryptoPrice {
          symbol = "BNBUSDT";
          format = "❖: {}";
        };

        "custom/link" = fetchCryptoPrice {
          symbol = "LINKUSDT";
          format = "Ł: {}";
        };

        "custom/ada" = fetchCryptoPrice {
          symbol = "ADAUSDT";
          format = "₳: {}";
        };

        "custom/cdl" = fetchAlphaPrice {
          symbol = "ALPHA_423USDT";
          format = "CDL: {}";
        };

        "group/crypto" = {
          modules = [
            "custom/btc"
            "custom/eth"
            "custom/bnb"
            "custom/link"
            "custom/ada"
            "custom/cdl"
          ];
          orientation = "inherit";
        };

        clock = {
          format = "{:%b %d %H:%M}";
          actions = {
            on-scroll-down = "shift_down";
            on-scroll-up = "shift_up";
          };
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            format = {
              days = "<span color='#98989d'><b>{}</b></span>";
              months = "<span color='#ffffff'><b>{}</b></span>";
              today = "<span color='#ffffff'><b><u>{}</u></b></span>";
              weekdays = "<span color='#0a84ff'><b>{}</b></span>";
            };
            mode = "month";
            on-scroll = 1;
          };
        };

        cpu = {
          interval = 1;
          format = "{}%  {icon0}{icon1}{icon2}{icon3}{icon4}{icon5}{icon6}{icon7}";
          "format-icons" = [
            "<span color='#a6e3a1'>▁</span>"
            "<span color='#b4dd9c'>▂</span>"
            "<span color='#d5db95'>▃</span>"
            "<span color='#f9e2af'>▄</span>"
            "<span color='#fab387'>▅</span>"
            "<span color='#f59ca5'>▆</span>"
            "<span color='#f38ba8'>▇</span>"
            "<span color='#eba0ac'>█</span>"
          ];
        };

        "temperature" = {
          "critical-threshold" = 80;
          "hwmon-path" = "/sys/devices/platform/thinkpad_hwmon/hwmon/hwmon4/temp1_input";
          "format-critical" = "{temperatureC}°C ";
          "format" = "{temperatureC}°C ";
        };

        "memory" = {
          "interval" = 5;
          "format" = "{used:0.1f}Gb ";
        };

        "custom/nvidia" = {
          exec = "nvidia-smi --query-gpu=utilization.gpu,temperature.gpu --format=csv,nounits,noheader | sed 's/\\([0-9]\\+\\), \\([0-9]\\+\\)/\\1%  \\2°C /g'";
          format = "{}";
          interval = 5;
        };

        "group/cpu-temperature-memory" = {
          "modules" = [
            "cpu"
            "temperature"
            "memory"
            # "custom/nvidia"
          ];
          "orientation" = "inherit";
        };

        tray = {
          icon-size = 16;
          show-passive-items = true;
          spacing = 8;
        };

        "custom/notification" = {
          exec = "swaync-client -swb";
          return-type = "json";
          format = "{icon}";
          format-icons = {
            notification = "󰂚";
            none = "󰂜";
            dnd-notification = "󰂛";
            dnd-none = "󰪑";
            inhibited-notification = "󰂛";
            inhibited-none = "󰪑";
            dnd-inhibited-notification = "󰂛";
            dnd-inhibited-none = "󰪑";
          };
          on-click = "swaync-client -t -sw";
          on-click-right = "swaync-client -d -sw";
          tooltip = true;
          escape = true;
        };

        "group/tray-notification" = {
          "modules" = [
            "tray"
            "custom/notification"
          ];
          "orientation" = "inherit";
        };

        "bluetooth" = {
          "format" = "";
          "tooltip-format" = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
          "tooltip-format-connected" = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
          "tooltip-format-enumerate-connected" = "{device_alias}\t{device_address}";
          "tooltip-format-enumerate-connected-battery" = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
          "on-click" = "blueman-manager";
        };

        network = {
          format-wifi = "󰤨";
          format-ethernet = "󰈀";
          format-disconnected = "";
          tooltip-format-wifi = "WiFi: {essid} ({signalStrength}%)\n󰅃 {bandwidthUpBytes} 󰅀 {bandwidthDownBytes}";
          tooltip-format-ethernet = "Ethernet: {ifname}\n󰅃 {bandwidthUpBytes} 󰅀 {bandwidthDownBytes}";
          tooltip-format-disconnected = "Disconnected";
          on-click = "${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
        };

        pulseaudio = {
          format = "{icon}";
          format-bluetooth = "󰂯";
          format-muted = "󰖁";
          format-icons = {
            hands-free = "󱡏";
            headphone = "󰋋";
            headset = "󰋎";
            default = ["󰕿" "󰖀" "󰕾"];
          };
          tooltip-format = "Volume: {volume}%";
          on-click = "${pkgs.pamixer}/bin/pamixer --toggle-mute";
          on-click-right = "${terminal} -e pulsemixer";
          on-scroll-up = "${pkgs.pamixer}/bin/pamixer --decrease 1";
          on-scroll-down = "${pkgs.pamixer}/bin/pamixer --increase 1";
        };
        "pulseaudio/slider" = {
          min = 0;
          max = 100;
          orientation = "horizontal";
        };
        "group/audio-slider" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 300;
            children-class = "audio-slider-child";
            transition-left-to-right = true;
          };
          modules = ["pulseaudio" "pulseaudio/slider"];
        };

        backlight = {
          format = "{icon}";
          format-icons = ["󰝦" "󰪞" "󰪟" "󰪠" "󰪡" "󰪢" "󰪣" "󰪤" "󰪥"];
          tooltip-format = "Backlight: {percent}%";
          on-scroll-up = "${pkgs.brightnessctl}/bin/brightnessctl set 1%-";
          on-scroll-down = "${pkgs.brightnessctl}/bin/brightnessctl set +1%";
        };

        "backlight/slider" = {
          min = 0;
          max = 100;
          orientation = "horizontal";
        };

        "group/light-slider" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 300;
            children-class = "light-slider-child";
            transition-left-to-right = true;
          };
          modules = ["backlight" "backlight/slider"];
        };

        battery = {
          format = "{icon}";
          format-charging = "󱐋";
          format-icons = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
          format-plugged = "󰚥";
          states = {
            warning = 30;
            critical = 20;
          };
          tooltip-format = "{timeTo}, {capacity}%";
        };

        "group/network-bluetooth-pulseaudio-backlight-battery" = {
          modules = [
            "network"
            "bluetooth"
            "group/audio-slider"
            "group/light-slider"
            "battery"
          ];
          orientation = "inherit";
        };

        "custom/power" = {
          format = "󰐥";
          on-click = "${pkgs.systemd}/bin/systemctl poweroff";
          tooltip = false;
        };
        "custom/exit" = {
          format = "󰈆";
          on-click = "${pkgs.systemd}/bin/loginctl terminate-user $USER";
          tooltip = false;
        };
        "custom/lock" = {
          format = "󰌾";
          on-click = "${pkgs.systemd}/bin/loginctl lock-session";
          tooltip = false;
        };
        "custom/suspend" = {
          format = "󰤄";
          on-click = "${pkgs.systemd}/bin/systemctl suspend";
          tooltip = false;
        };
        "custom/reboot" = {
          format = "󰜉";
          on-click = "${pkgs.systemd}/bin/systemctl reboot";
          tooltip = false;
        };

        "group/powermenu" = {
          drawer = {
            children-class = "powermenu-child";
            transition-duration = 300;
            transition-left-to-right = false;
          };
          modules = [
            "custom/power"
            "custom/exit"
            "custom/lock"
            "custom/suspend"
            "custom/reboot"
          ];
          orientation = "inherit";
        };
      }
    ];

    style = ''
      * {
        all: unset;
        color: @white;
        font:
          11pt "Inter",
          Inter,
          sans-serif;
      }

      #waybar {
        background: transparent;
      }

      #workspaces,
      #custom-weather,
      #crypto,
      #clock,
      #cpu-temperature-memory,
      #tray-notification,
      #network-bluetooth-pulseaudio-backlight-battery,
      #powermenu {
        padding: 0.4rem 0.5rem;
        background-color: rgba(36, 49, 99, 0.85);
        border-radius: 1rem;
      }

      #workspaces button {
        border-radius: 100%;
        min-width: 1.25rem;
        margin-right: 0.35rem;
        transition: 200ms linear;
      }

      #workspaces button:last-child {
        margin-right: 0;
      }

      #workspaces button:hover {
        background: @lavender;
      }

      #workspaces button.empty {
        background: @surface2;
      }

      #workspaces button.empty:hover {
        background: @lavender;
      }

      #workspaces button.urgent {
        background: @red;
      }

      #workspaces button.urgent:hover {
        background: lighter(@red);
      }

      #workspaces button.special {
        background: @yellow;
      }

      #workspaces button.special:hover {
        background: lighter(@yellow);
      }

      #workspaces button.active {
        background: @mauve;
      }

      #workspaces button.active:hover {
        background: @lavender;
      }

      #custom-weather {
        color: @sky;
      }

      #custom-btc,
      #custom-eth,
      #custom-bnb,
      #custom-link,
      #custom-ada {
        margin-right: 0.35rem;
      }

      #custom-btc {
        color: @yellow;
      }

      #custom-eth {
        color: @lavender;
      }

      #custom-bnb {
        color: @yellow;
      }

      #custom-link {
        color: @blue;
      }

      #custom-ada {
        color: @sapphire;
      }

      #custom-cdl {
        color: @blue;
      }

      #clock {
        color: @sky;
      }

      #cpu,
      #temperature,
      #memory {
        margin-right: 0.5rem;
      }

      #cpu {
        color: @mauve;
      }

      #temperature {
        color: @blue;
      }

      #temperature.critical {
        color: @blue;
      }

      #memory {
        color: @pink;
      }

      #custom-nvidia {
        color: @blue;
      }

      #tray {
        margin-right: 0.35rem;
      }

      #custom-notification {
        color: @yellow;
      }

      #bluetooth.off {
        color: @red;
      }

      #bluetooth.on {
        color: @blue;
      }

      #bluetooth.connected {
        color: @green;
      }

      #bluetooth.discoverable {
        color: @sky;
      }

      #bluetooth.discovering {
        color: @yellow;
      }

      #bluetooth.pairable {
        color: @lavender;
      }

      #bluetooth.no-controller {
        color: @red;
      }

      #network,
      #bluetooth,
      #pulseaudio,
      #pulseaudio-slier,
      #backlight {
        margin-right: 0.35rem;
      }

      #network {
        color: @blue;
      }

      #network.disconnected {
        color: @red;
      }

      #pulseaudio {
        color: @mauve;
      }

      #pulseaudio.muted {
        color: @red;
      }

      #pulseaudio-slider trough {
        min-height: 8px;
        min-width: 80px;
        border-radius: 5px;
        background-color: black;
        margin-right: 0.35rem;
      }
      #pulseaudio-slider highlight {
        min-width: 10px;
        border-radius: 5px;
        background-color: @mauve;
      }

      #backlight {
        color: @rosewater;
      }

      #backlight-slider trough {
        min-height: 8px;
        min-width: 80px;
        border-radius: 5px;
        background-color: black;
        margin-right: 0.35rem;
      }
      #backlight-slider highlight {
        min-width: 10px;
        border-radius: 5px;
        background-color: @rosewater;
      }

      #battery {
        color: @green;
      }

      #battery.critical:not(.charging) {
        color: @red;
        animation: blink 0.5s steps(12) infinite alternate;
      }

      #custom-exit,
      #custom-lock,
      #custom-suspend,
      #custom-reboot {
        margin-right: 0.35rem;
      }

      #custom-exit {
        color: @blue;
      }

      #custom-lock {
        color: @green;
      }

      #custom-suspend {
        color: @yellow;
      }

      #custom-reboot {
        color: @orange;
      }

      #custom-power {
        color: @red;
      }
    '';
  };
}
