{pkgs, ...}: {
  imports = [./hardware-configuration.nix];

  networking.hostName = "amd8700";

  boot = {
    initrd = {
      systemd.enable = true;
      supportedFilesystems = ["ext4"];
    };

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
    systemPackages = with pkgs; [
      acpi
      alsa-utils
      ffmpeg-full
      libva
      libva-utils
      mesa
      pciutils
      v4l-utils
      vulkan-tools
      vulkan-loader
      vulkan-validation-layers
      vulkan-extension-layer
    ];

    variables = {
      MONITOR_LEFT = "DP-2, 1920x1080@60, 0x0, 1";
      MONITOR_RIGHT = "HDMI-A-1, 1920x1080@60, 1920x0, 1";
    };
  };

  hardware = {
    # Enable all firmware regardless of license.
    enableAllFirmware = true;

    # Enable firmware with a license allowing redistribution.
    enableRedistributableFirmware = true;

    # update the CPU microcode for Intel processors.
    cpu.intel.updateMicrocode = true;

    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  services = {
    # Enable the ACPI daemon.
    acpid.enable = true;

    # Enable the auto-cpufreq daemon.
    auto-cpufreq.enable = true;

    # Enable periodic SSD TRIM of mounted partitions in background
    fstrim.enable = true;

    # Enable security levels for Thunderbolt 3 on GNU/Linux.
    hardware.bolt.enable = true;

    # Extra config options for systemd-logind.
    logind = {
      powerKey = "suspend";
      lidSwitch = "suspend";
      lidSwitchExternalPower = "lock";
    };

    # Enable the Profile Sync daemon.
    psd = {
      enable = true;
      resyncTimer = "10m";
    };

    # Enable power-profiles-daemon, a DBus daemon that allows changing system behavior based upon user-selected power profiles.
    power-profiles-daemon.enable = true;

    # Enable thermald, the temperature management daemon.
    thermald.enable = true;
  };

  # Enable in-memory compressed devices and swap space provided by the zram kernel module.
  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };
}
