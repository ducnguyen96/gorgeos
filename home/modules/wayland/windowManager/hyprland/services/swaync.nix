{
  services.swaync = {
    enable = true;
    # systemd.enable = true;
    # systemd.target = "graphical-session.target";
    # schema = "${pkgs.swaynotificationcenter}/etc/xdg/swaync/configSchema.json";

    settings = {
      # General settings
      cssPriority = "user";
      image-visibility = "when-available";
      keyboard-shortcut = true;
      relative-timestamps = true;
      timeout = 10;
      timeout-low = 5;
      timeout-critical = 0;
      script-fail-notify = true;
      transition-time = 200;

      # Layer settings
      layer-shell = true;
      layer = "overlay";
      control-center-layer = "overlay";

      # Notification settings
      positionX = "center";
      positionY = "top";
      notification-2fa-action = true;
      notification-inline-replies = false;
      notification-icon-size = 64;
      notification-body-image-height = 100;
      notification-body-image-width = 200;
      notification-window-width = 300;

      # Control center settings
      control-center-positionX = "right";
      control-center-positionY = "top";
      control-center-margin-top = 4;
      control-center-margin-bottom = 4;
      control-center-margin-left = 0;
      control-center-margin-right = 4;
      control-center-width = 500;
      control-center-exclusive-zone = true;
      fit-to-screen = true;
      hide-on-action = true;
      hide-on-clear = false;

      # Widget settings
      widgets = [
        "title"
        "dnd"
        "notifications"
        "mpris"
      ];

      # Widget config
      widget-config = {
        title = {
          text = "Notifications";
          clear-all-button = true;
          button-text = "Clear All";
        };
        dnd = {
          text = "Do Not Disturb";
        };
        mpris = {
          image-size = 96;
          image-radius = 12;
          blur = true;
        };
      };
    };

    style = ''
      @define-color background rgba(0, 0, 0, 0.5);
      @define-color background-alt rgba(255, 255, 255, 0.05);
      @define-color background-focus rgba(255, 255, 255, 0.1);
      @define-color border rgba(255, 255, 255, 0.1);
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
        font:
          11pt Inter,
          sans-serif;
        transition: 200ms;
      }

      /*** Global ***/
      progress,
      progressbar,
      trough {
        border: 1px solid @border;
        border-radius: 16px;
      }

      trough {
        background: @background-alt;
      }

      .notification.low,
      .notification.normal {
        border: 1px solid @border;
      }

      .notification.low progress,
      .notification.normal progress {
        background: @blue;
      }

      .notification.critical {
        border: 1px solid @red;
      }

      .notification.critical progress {
        background: @red;
      }

      .summary {
        color: @white;
      }

      .body {
        color: alpha(@white, 0.7);
      }

      .time {
        color: alpha(@white, 0.7);
      }

      .app-icon,
      .image {
        -gtk-icon-effect: none;
        margin: 0.25rem;
      }

      .notification-action {
        color: @white;
        background: @background-alt;
        border: 1px solid @border;
        border-radius: 8px;
        margin: 0.5rem;
      }

      .notification-action:hover {
        background: @background-focus;
        color: @white;
      }

      .notification-action:active {
        background: @blue;
        color: @white;
      }

      .close-button {
        margin: 0.5rem;
        padding: 0.25rem;
        border-radius: 8px;
        color: @black;
        background: @red;
      }

      .close-button:hover {
        background: lighter(@red);
        color: lighter(@black);
      }

      .close-button:active {
        background: @red;
        color: @background;
      }

      /*** Notifications ***/
      .floating-notifications.background .notification-row .notification-background {
        background: @background;
        border-radius: 16px;
        color: @white;
        margin: 0.25rem;
        padding: 0;
      }

      .floating-notifications.background
        .notification-row
        .notification-background
        .notification {
        padding: 0.5rem;
        border-radius: 16px;
      }

      .floating-notifications.background
        .notification-row
        .notification-background
        .notification
        .notification-content {
        margin: 0.5rem;
      }

      /*** Notifications Group ***/
      .notification-group {
        /* Styling only for Grouped Notifications */
      }

      .notification-group.low {
        /* Low Priority Group */
      }

      .notification-group.normal {
        /* Low Priority Group */
      }

      .notification-group.critical {
        /* Low Priority Group */
      }

      .notification-group .notification-group-buttons,
      .notification-group .notification-group-headers {
        margin: 0.5rem;
        color: @white;
      }

      .notification-group .notification-group-headers {
        /* Notification Group Headers */
      }

      .notification-group .notification-group-headers .notification-group-icon {
        color: @white;
      }

      .notification-group .notification-group-headers .notification-group-header {
        color: @white;
      }

      .notification-group .notification-group-buttons {
        /* Notification Group Buttons */
      }

      .notification-group.collapsed .notification-row .notification {
        background: @background-alt;
      }

      .notification-group.collapsed .notification-row:not(:last-child) {
        /* Top notification in stack */
        /* Set lower stacked notifications opacity to 0 */
      }

      .notification-group.collapsed
        .notification-row:not(:last-child)
        .notification-action,
      .notification-group.collapsed
        .notification-row:not(:last-child)
        .notification-default-action {
        opacity: 0;
      }

      .notification-group.collapsed:hover
        .notification-row:not(:only-child)
        .notification {
        background: @background-focus;
      }

      /*** Control Center ***/
      .control-center {
        background: @background;
        border: 1px solid @border;
        border-radius: 16px;
        color: @white;
        padding: 1rem;
      }

      .control-center-list {
        background: transparent;
      }

      .control-center .notification-row .notification-background {
        background: @background-alt;
        border-radius: 8px;
        color: @white;
        margin: 0.5rem;
      }

      .control-center .notification-row .notification-background .notification {
        border-radius: 8px;
        padding: 0.5rem;
      }

      .control-center
        .notification-row
        .notification-background
        .notification
        .notification-content {
        margin: 0.5rem;
      }

      .control-center
        .notification-row
        .notification-background
        .notification
        .notification-content
        .time {
        margin-right: 0.75rem;
      }

      .control-center .notification-row .notification-background:hover {
        background: @background-focus;
        color: @white;
      }

      .control-center .notification-row .notification-background:active {
        background: @blue;
        color: @white;
      }

      /*** Widgets ***/
      /* Title widget */
      .widget-title {
        color: @white;
        margin: 0.5rem;
      }

      .widget-title > label {
        font-weight: bold;
      }

      .widget-title > button {
        background: @background-alt;
        border: 1px solid @border;
        border-radius: 8px;
        color: @white;
        padding: 0.5rem;
      }

      .widget-title > button:hover {
        background: @background-focus;
      }

      /* DND Widget */
      .widget-dnd {
        color: @white;
        margin: 0.5rem;
      }

      .widget-dnd > label {
        font-weight: bold;
      }

      .widget-dnd > switch {
        background: @background-alt;
        border: 1px solid @border;
        border-radius: 8px;
      }

      .widget-dnd > switch:hover {
        background: @background-focus;
      }

      .widget-dnd > switch:checked {
        background: @blue;
      }

      .widget-dnd > switch slider {
        background: @background-focus;
        border-radius: 8px;
        padding: 0.25rem;
      }

      /* Mpris widget */
      .widget-mpris {
        color: @white;
      }

      .widget-mpris .widget-mpris-player {
        background: @background-alt;
        border: 1px solid @border;
        border-radius: 8px;
        margin: 0.5rem;
        padding: 0.5rem;
      }

      .widget-mpris .widget-mpris-player button:hover {
        background: @background-focus;
      }

      .widget-mpris .widget-mpris-player .widget-mpris-album-art {
        border-radius: 16px;
      }

      .widget-mpris .widget-mpris-player .widget-mpris-title {
        font-weight: bold;
      }

      .widget-mpris .widget-mpris-player .widget-mpris-subtitle {
        font-weight: normal;
      }

      .widget-mpris .widget-mpris-player > box > button {
        border: 1px solid transparent;
        border-radius: 8px;
        padding: 0.25rem;
      }

      .widget-mpris .widget-mpris-player > box > button:hover {
        background: @background-focus;
        border: 1px solid @border;
      }

      .widget-mpris > box > button {
        /* Change player side buttons */
      }

      .widget-mpris > box > button:disabled {
        /* Change player side buttons insensitive */
      }
    '';
  };
}
