{
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  networking.hostName = "e14g2";

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    loader = {
      # Disable GRUB
      grub.enable = false;

      # Enable systemd-boot (UEFI only)
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  environment = {
    variables = {
      MONITOR_ONE = "eDP-1, 1920x1080@60, 0x0, 1";
      MONITOR_ONE_DISABLED = "eDP-1, disable";
      MONITOR_TWO = "HDMI-A-1, 1920x1080@60, 1920x0, 1";
      MONITOR_TWO_DISABLED = "HDMI-A-1, disable";
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
  system.stateVersion = "25.05"; # Did you read the comment?
}
