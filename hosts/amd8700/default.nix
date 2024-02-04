{
  config,
  pkgs,
  ...
}: {
  imports = [./hardware-configuration.nix];

  networking.hostName = "amd8700";

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
    #storageDriver = "btrfs";

    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  environment.variables = {
    MONITOR_LEFT = "DP-2, 1920x1080@60, 0x0, 1";
    MONITOR_RIGHT = "HDMI-A-1, 1920x1080@60, 1920x0, 1";
  };

  # networking.extraHosts = ''
  #   127.0.0.1 mapreport.dev.droopy.forwoodsafety.com
  # '';
}
