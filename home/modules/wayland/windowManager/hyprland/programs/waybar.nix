{
  pkgs,
  config,
  ...
}: let
  terminal = config.home.sessionVariables.TERMINAL;

  fetchCryptoPrice = symbol: icon: {
    interval = 300;
    format = "{}";
    return-type = "plain";
    exec = pkgs.writeShellScript "crypto-${symbol}" ''
      ${pkgs.curl}/bin/curl -Lsf --max-time 5 \
        "https://api.binance.com/api/v3/ticker/price?symbol=${symbol}" \
        | ${pkgs.jq}/bin/jq -r '"${icon} " + (.price | tonumber | floor | tostring)' \
        || echo "${icon} N/A"
    '';
    tooltip = false;
  };
in {
  programs.waybar = {
    enable = true;

    systemd = {
      enable = true;
      target = "graphical-session.target";
    };

    settings = [
      {
        layer = "bottom";
        position = "bottom";

        margin = "0 10 5 10";
        spacing = 6;

        modules-left = [
          "hyprland/workspaces"
        ];

        modules-center = [
          "clock"
          "group/crypto"
        ];

        modules-right = [
          "cpu"
          "memory"
          "temperature"
          "network"
          "bluetooth"
          "pulseaudio"
          "backlight"
          "battery"
          "tray"
          "custom/notification"
          "group/powermenu"
        ];

        ########################################
        # WORKSPACES
        ########################################

        "hyprland/workspaces" = {
          format = "{id}";
          disable-scroll = true;
          all-outputs = false;
          show-special = false;
        };

        ########################################
        # CLOCK
        ########################################

        clock = {
          interval = 60;
          format = "{:%b %d %H:%M}";
          tooltip-format = "{:%A, %d %B %Y}";
        };

        ########################################
        # CRYPTO
        ########################################

        "custom/btc" = fetchCryptoPrice "BTCUSDT" "󰠓";
        "custom/eth" = fetchCryptoPrice "ETHUSDT" "󰡪";
        "custom/bnb" = fetchCryptoPrice "BNBUSDT" "❖";

        "group/crypto" = {
          orientation = "horizontal";
          modules = [
            "custom/btc"
            "custom/eth"
            "custom/bnb"
          ];
        };

        ########################################
        # CPU / MEMORY / TEMP
        ########################################

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

        ########################################
        # NETWORK
        ########################################

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

        ########################################
        # BLUETOOTH
        ########################################

        bluetooth = {
          format = "";
          tooltip = false;
          on-click = "blueman-manager";
        };

        ########################################
        # AUDIO
        ########################################

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

        ########################################
        # BACKLIGHT
        ########################################

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

        ########################################
        # BATTERY
        ########################################

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

        ########################################
        # TRAY
        ########################################

        tray = {
          icon-size = 14;
          spacing = 6;
          show-passive-items = false;
        };

        ########################################
        # NOTIFICATIONS
        ########################################

        "custom/notification" = {
          interval = 10;
          exec = "swaync-client -D";
          format = "";
          tooltip = false;
          on-click = "swaync-client -t";
        };

        ########################################
        # POWERMENU
        ########################################

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
    ];

    style = ''
      * {
        border: none;
        border-radius: 10px;
        min-height: 0;
        font-family: Inter, sans-serif;
        font-size: 11pt;
      }

      window#waybar {
        background: transparent;
      }

      #workspaces,
      #clock,
      #crypto,
      #cpu,
      #memory,
      #temperature,
      #network,
      #bluetooth,
      #pulseaudio,
      #backlight,
      #battery,
      #tray,
      #custom-notification,
      #powermenu {
        background: rgba(36, 49, 99, 0.85);
        padding: 0.35rem 0.6rem;
        margin: 0 2px;
      }

      #workspaces button {
        padding: 0 6px;
        min-width: 18px;
      }

      #workspaces button.active {
        background: rgba(255,255,255,0.15);
      }

      #custom-btc {
        color: #f9e2af;
      }

      #custom-eth {
        color: #cba6f7;
      }

      #custom-bnb {
        color: #fcd34d;
      }

      #cpu {
        color: #cba6f7;
      }

      #memory {
        color: #f5c2e7;
      }

      #temperature {
        color: #89b4fa;
      }

      #network {
        color: #89dceb;
      }

      #bluetooth {
        color: #94e2d5;
      }

      #pulseaudio {
        color: #fab387;
      }

      #battery {
        color: #a6e3a1;
      }

      #battery.warning {
        color: #f9e2af;
      }

      #battery.critical {
        color: #f38ba8;
      }

      #custom-power {
        color: #f38ba8;
      }
    '';
  };
}
