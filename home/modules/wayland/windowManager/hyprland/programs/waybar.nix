{pkgs, ...}: {
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    systemd.target = "graphical-session.target";

    settings = [
      {
        layer = "top";
        position = "top";
        exclusive = true;
        fixed-center = true;
        gtk-layer-shell = true;
        spacing = 0;
        margin-top = 0;
        margin-bottom = 0;
        margin-left = 0;
        margin-right = 0;
        modules-left = ["custom/ghost" "hyprland/workspaces" "hyprland/window"];
        modules-center = ["custom/weather" "clock" "custom/btc" "custom/eth" "custom/link" "custom/ada"];
        modules-right = ["tray" "custom/notification" "group/network-pulseaudio-backlight-battery" "group/powermenu"];

        # Ghost
        "custom/ghost" = {
          format = "󱙝";
          tooltip = false;
        };

        # Workspaces
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

        # Window
        "hyprland/window" = {
          format = "{}";
          separate-outputs = true;
        };

        # Weather
        "custom/weather" = {
          format = "{}°";
          tooltip = true;
          interval = 3600;
          exec = "${pkgs.wttrbar}/bin/wttrbar  --hide-conditions --location Jakarta";
          return-type = "json";
        };

        # BTC
        "custom/btc" = {
          format = "󰠓: {}";
          interval = 60;
          exec = "curl -s https://api.binance.com/api/v1/ticker/price?symbol=BTCUSDT | jq .price | xargs | awk -F. '{print $1}'";
          tooltip = false;
        };

        # ETH
        "custom/eth" = {
          format = "󰡪: {}";
          interval = 60;
          exec = "curl -s https://api.binance.com/api/v1/ticker/price?symbol=ETHUSDT | jq .price | xargs | awk -F. '{print $1}'";
          tooltip = false;
        };

        # LINK
        "custom/link" = {
          format = "󰌹: {}";
          interval = 60;
          exec = ''
            curl -s https://api.binance.com/api/v1/ticker/price?symbol=LINKUSDT | jq .price | xargs | awk '{printf "%.2f\n", $1}'
          '';
          tooltip = false;
        };

        # ADA
        "custom/ada" = {
          format = "ADA: {}";
          interval = 60;
          exec = ''
            curl -s https://api.binance.com/api/v1/ticker/price?symbol=ADAUSDT | jq .price | xargs | awk '{printf "%.2f\n", $1}'
          '';
          tooltip = false;
        };

        # Clock & Calendar
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

        # Tray
        tray = {
          icon-size = 16;
          show-passive-items = true;
          spacing = 8;
        };

        # Notifications
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

        # Group
        "group/network-pulseaudio-backlight-battery" = {
          modules = [
            "network"
            "group/audio-slider"
            "group/light-slider"
            "battery"
          ];
          orientation = "inherit";
        };

        # Network
        network = {
          format-wifi = "󰤨";
          format-ethernet = "󰈀";
          format-disconnected = "";
          tooltip-format-wifi = "WiFi: {essid} ({signalStrength}%)\n󰅃 {bandwidthUpBytes} 󰅀 {bandwidthDownBytes}";
          tooltip-format-ethernet = "Ethernet: {ifname}\n󰅃 {bandwidthUpBytes} 󰅀 {bandwidthDownBytes}";
          tooltip-format-disconnected = "Disconnected";
          on-click = "${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
        };

        # Pulseaudio
        "group/audio-slider" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 300;
            children-class = "audio-slider-child";
            transition-left-to-right = true;
          };
          modules = ["pulseaudio" "pulseaudio/slider"];
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

        # Backlight
        "group/light-slider" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 300;
            children-class = "light-slider-child";
            transition-left-to-right = true;
          };
          modules = ["backlight" "backlight/slider"];
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

        # Battery
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

        # Powermenu
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
      }
    ];

    style = ''
      @define-color background rgba(0, 0, 0, 0.0);
      @define-color background-alt rgba(255, 255, 255, 0.0);
      @define-color background-focus rgba(255, 255, 255, 0.0);
      @define-color border rgba(255, 255, 255, 0.0);
      @define-color red rgb(255, 69, 58);
      @define-color orange rgb(255, 159, 10);
      @define-color yellow rgb(255, 214, 10);
      @define-color green rgb(50, 215, 75);
      @define-color blue rgb(10, 132, 255);
      @define-color gray rgb(152, 152, 157);
      @define-color black rgb(28, 28, 30);
      @define-color white rgb(255, 255, 255);

      * {
        all: unset;
        color: @white;
        font:
          11pt "Material Design Icons",
          Inter,
          sans-serif;
      }

      /* Button */
      button {
        box-shadow: inset 0 -0.25rem transparent;
        border: none;
      }

      button:hover {
        box-shadow: inherit;
        text-shadow: inherit;
      }

      /* Scales & progress bars */
      scale trough,
      progressbar trough {
        background: @background;
        border-radius: 16px;
        min-width: 5rem;
      }

      scale highlight,
      scale progress,
      progressbar highlight,
      progressbar progress {
        background: @background-alt;
        border-radius: 16px;
        min-height: 0.5rem;
      }

      /* Tooltip */
      tooltip {
        background: @background;
        border: 1px solid @border;
        border-radius: 16px;
      }

      tooltip label {
        margin: 0.5rem;
      }

      /*  Waybar window */
      window#waybar {
        background: @background;
      }

      /* Left Modules */
      .modules-left {
        padding-left: 0.5rem;
      }

      /* Right Modules */
      .modules-right {
        padding-right: 0.5rem;
      }

      /* Modules */
      #custom-ghost,
      #workspaces,
      #window,
      #tray,
      #custom-weather,
      #custom-notification,
      #network-pulseaudio-backlight-battery,
      #clock,
      #custom-exit,
      #custom-lock,
      #custom-suspend,
      #custom-reboot,
      #custom-btc,
      #custom-eth,
      #custom-link,
      #custom-power {
        background: @background-alt;
        border: 1px solid @border;
        border-radius: 100px;
        margin: 0.5rem 0.25rem;
      }

      #custom-ghost,
      #window,
      #custom-weather,
      #custom-btc,
      #custom-eth,
      #custom-link,
      #tray,
      #custom-notification,
      #network-pulseaudio-backlight-battery,
      #clock {
        padding: 0 0.5rem;
      }

      #network,
      #pulseaudio,
      #pulseaudio-slider,
      #backlight,
      #backlight-slider,
      #battery {
        background: transparent;
        padding: 0.5rem 0.25rem;
      }

      #custom-exit,
      #custom-lock,
      #custom-suspend,
      #custom-reboot,
      #custom-power {
        min-width: 1rem;
        padding: 0.5rem;
      }

      /* Ghost */
      #custom-ghost {
        min-width: 1rem;
      }

      /* Hyprland workspaces */
      #workspaces {
        padding: 0.5rem 0.75rem;
      }

      #workspaces button {
        background: @white;
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
        background: @gray;
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

      /* Hyprland window */
      #window {
        min-width: 1rem;
      }

      window#waybar.empty #window {
        background: transparent;
        border: none;
      }

      /* Systray */
      #tray > .passive {
        -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
        -gtk-icon-effect: highlight;
        background: @red;
      }

      menu {
        background: @background;
        border: 1px solid @border;
        border-radius: 8px;
      }

      menu separator {
        background: @border;
      }

      menu menuitem {
        background: transparent;
        padding: 0.5rem;
        transition: 200ms;
      }

      menu menuitem:hover {
        background: @background-focus;
      }

      menu menuitem:first-child {
        border-radius: 8px 8px 0 0;
      }

      menu menuitem:last-child {
        border-radius: 0 0 8px 8px;
      }

      menu menuitem:only-child {
        border-radius: 8px;
      }

      /* Notification */
      #custom-notification {
        color: @yellow;
      }

      /* Network */
      #network.disconnected {
        color: @red;
      }

      /* Pulseaudio  */
      #pulseaudio.muted {
        color: @red;
      }

      #pulseaudio-slider highlight {
        background: @white;
        border: 1px solid @border;
      }

      /* Backlight */
      #backlight-slider highlight {
        background: @white;
        border: 1px solid @border;
      }

      /* Battery */
      #battery.charging,
      #battery.plugged {
        color: @green;
      }

      #battery.critical:not(.charging) {
        color: @red;
        animation: blink 0.5s steps(12) infinite alternate;
      }

      /* Powermenu */
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

      /* Keyframes */
      @keyframes blink {
        to {
          color: @white;
        }
      }
    '';
  };
}
