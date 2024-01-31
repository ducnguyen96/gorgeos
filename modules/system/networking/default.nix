{lib, ...}: {
  networking = {
    networkmanager = {
      enable = true;
      wifi.powersave = true;
    };

    dhcpcd.enable = true;
  };

  systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;
}
