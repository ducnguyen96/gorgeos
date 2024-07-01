{pkgs, ...}: {
  imports = [./hardware-configuration.nix];

  networking.hostName = "e14g2";

  boot = {
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

  environment = {
    variables = {
      MONITOR_LEFT = "eDP-1, 1920x1080@60, 0x0, 1";
      MONITOR_RIGHT = "HDMI-A-1, 1920x1080@60, 1920x0, 1";
    };
  };

  security.polkit.enable = true;
}
