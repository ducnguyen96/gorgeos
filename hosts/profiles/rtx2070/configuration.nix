{pkgs, ...}: {
  imports = [./hardware-configuration.nix];

  networking.hostName = "rtx2070";

  boot = {
    kernelParams = ["nvidia-drm.fbdev=1"];
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
        configurationLimit = 3;
        gfxmodeEfi = "1920x1080";
      };
    };
  };

  hardware = {
    enableAllFirmware = true;

    i2c.enable = true;
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  environment = {
    variables = {
      MONITOR_LEFT = "HDMI-A-1, 1920x1080@60, 0x0, 1";
      MONITOR_RIGHT = "DP-3, 1080x1920@60, 1920x0, 1, transform, 1"; # https://wiki.hyprland.org/Configuring/Monitors/#rotating
    };
  };

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?
}
