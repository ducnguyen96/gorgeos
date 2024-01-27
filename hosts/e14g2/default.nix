{
  config,
  pkgs,
  ...
}: {
  imports = [./hardware-configuration.nix];

  networking.hostName = "e14g2";

  boot = {
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

  virtualisation.docker = {
    enable = true;
    storageDriver = "btrfs";

    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  environment.variables = {
    MONITOR_LEFT = "HDMI-A-1, 1920x1080@60, 0x0, 1";
    MONITOR_RIGHT = "eDP-1, 1920x1080@60, 1920x0, 1";
  };

  services = {
    upower = {
      enable = true;
      percentageLow = 30;
      percentageCritical = 20;
      percentageAction = 10;
      criticalPowerAction = "Hibernate";
    };
  };
  # networking.extraHosts = ''
  #   127.0.0.1 mapreport.dev.droopy.forwoodsafety.com
  # '';
}
