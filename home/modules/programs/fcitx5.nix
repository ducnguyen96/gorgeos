{pkgs, ...}: {
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      addons = with pkgs; [
        fcitx5-bamboo
        fcitx5-gtk
      ];
      waylandFrontend = true;

      # Configure input methods and settings
      settings = {
        inputMethod = {
          "Groups/0" = {
            Name = "Default";
            "Default Layout" = "us";
            DefaultIM = "bamboo";
          };
          "Groups/0/Items/0" = {
            Name = "keyboard-us";
            Layout = "";
          };
          "Groups/0/Items/1" = {
            Name = "bamboo";
            Layout = "";
          };
          GroupOrder = {
            "0" = "Default";
          };
        };

        globalOptions = {
          Hotkey = {
            EnumerateWithTriggerKeys = true;
            AltTriggerKeys = "";
            EnumerateForwardKeys = "";
            EnumerateBackwardKeys = "";
            EnumerateSkipFirst = false;
          };
          "Hotkey/TriggerKeys" = {
            "0" = "Control+Shift+space";
          };
          "Hotkey/ActivateKeys" = {
            "0" = "Control+Shift+space";
          };
          Behavior = {
            ActiveByDefault = false;
            ShareInputState = "No";
            PreeditEnabledByDefault = true;
            ShowInputMethodInformation = true;
            showInputMethodInformationWhenFocusIn = false;
            CompactInputMethodInformation = true;
            ShowFirstInputMethodInformation = true;
            DefaultPageSize = 5;
            OverrideXkbOption = false;
            CustomXkbOption = "";
            EnabledAddons = "";
            DisabledAddons = "";
            PreloadInputMethod = true;
          };
        };
      };
    };
  };
}
