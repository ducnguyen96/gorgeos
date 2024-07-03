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
        useOSProber = false;
        configurationLimit = 3;
        gfxmodeEfi = "1920x1080";
      };
    };
  };

  hardware = {
    enableAllFirmware = true;
    enableRedistributableFirmware = true;
  };

  environment = {
    variables = {
      MONITOR_LEFT = "DP-3, 1920x1080@60, 0x0, 1";
      MONITOR_RIGHT = "HDMI-A-1, 1920x1080@60, 1920x0, 1";
    };
  };

  security.polkit.enable = true;
}
