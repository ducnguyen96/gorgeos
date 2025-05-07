{
  pkgs,
  config,
  ...
}: let
  themeName = config.custom.theme.name;
  themeVariant = config.custom.theme.variant;

  themePath = ../../../../../../lib/themes/${themeName};
in {
  home.file.".config/waybar/${themeVariant}.css".source = "${themePath}/waybar/${themeVariant}.css";

  home.packages = with pkgs; [papirus-icon-theme];

  programs.waybar = {
    enable = true;
    systemd.enable = true;
    systemd.target = "graphical-session.target";

    settings = [
      {
        layer = "top";
        position = "top";
        margin = "10 10 0 10";
        spacing = 8;
        modules-left = ["hyprland/workspaces"];
        modules-center = ["custom/weather" "group/crypto" "clock"];
        modules-right = ["tray" "custom/notification" "group/network-pulseaudio-backlight-battery" "group/powermenu"];

        "hyprland/workspaces" = {
          format = "";
          on-click = "activate";
          disable-scroll = true;
          all-outputs = true;
          show-special = true;
          persistent-workspaces = {
            "*" = 5;
          };
        };

        "custom/weather" = {
          format = "{}°";
          tooltip = true;
          interval = 3600;
          exec = "${pkgs.wttrbar}/bin/wttrbar  --hide-conditions --location Hanoi";
          return-type = "json";
        };

        "custom/btc" = {
          format = "󰠓: {}";
          interval = 60;
          exec = "curl -s https://api.binance.com/api/v1/ticker/price?symbol=BTCUSDT | jq .price | xargs | awk -F. '{print $1}'";
          tooltip = false;
        };

        "custom/eth" = {
          format = "󰡪: {}";
          interval = 60;
          exec = "curl -s https://api.binance.com/api/v1/ticker/price?symbol=ETHUSDT | jq .price | xargs | awk -F. '{print $1}'";
          tooltip = false;
        };

        "custom/link" = {
          format = "Ł: {}";
          interval = 60;
          exec = ''
            curl -s https://api.binance.com/api/v1/ticker/price?symbol=LINKUSDT | jq .price | xargs | awk '{printf "%.2f\n", $1}'
          '';
          tooltip = false;
        };

        "custom/ada" = {
          format = "₳:: {}";
          interval = 60;
          exec = ''
            curl -s https://api.binance.com/api/v1/ticker/price?symbol=ADAUSDT | jq .price | xargs | awk '{printf "%.2f\n", $1}'
          '';
          tooltip = false;
        };

        "group/crypto" = {
          modules = [
            "custom/btc"
            "custom/eth"
            "custom/link"
            "custom/ada"
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

        tray = {
          icon-size = 16;
          show-passive-items = true;
          spacing = 8;
        };

        "custom/notification" = {
          exec = "${pkgs.swaynotificationcenter}/bin/swaync-client -swb";
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
          on-click = "${pkgs.swaynotificationcenter}/bin/swaync-client -t -sw";
          on-click-right = "${pkgs.swaynotificationcenter}/bin/swaync-client -d -sw";
          tooltip = true;
          escape = true;
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

        "group/network-pulseaudio-backlight-battery" = {
          modules = [
            "network"
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
      @import "${themeVariant}.css";

      * {
        all: unset;
        color: @white;
        font:
          11pt "Material Design Icons",
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
      #tray,
      #custom-notification,
      #network-pulseaudio-backlight-battery,
      #powermenu {
        padding: 0.4rem 0.5rem;
        background-color: @surface0;
        border-radius: 1rem;
      }

      #workspaces button {
        background: @subtext0;
        border-radius: 100%;
        min-width: 1rem;
        margin-right: 0.75rem;
        transition: 200ms linear;
      }

      #workspaces button:last-child {
        margin-right: 0;
      }

      #workspaces button:hover {
        background: lighter(@white);
      }

      #workspaces button.empty {
        background: @surface2;
      }

      #workspaces button.empty:hover {
        background: lighter(@gray);
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
        background: @blue;
      }

      #workspaces button.active:hover {
        background: lighter(@blue);
      }

      #custom-weather {
        color: @sky;
      }

      #custom-btc,
      #custom-eth,
      #custom-link {
        margin-right: 0.35rem;
      }

      #custom-btc {
        color: @yellow;
      }

      #custom-eth {
        color: @lavender;
      }

      #custom-link {
        color: @blue;
      }

      #custom-ada {
        color: @sapphire;
      }

      #clock {
        color: @sky;
      }

      #custom-notification {
        color: @yellow;
      }

      #network,
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
