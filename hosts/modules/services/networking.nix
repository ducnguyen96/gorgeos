{lib, ...}: {
  networking = {
    useDHCP = lib.mkDefault true;

    firewall.enable = false;
    networkmanager = {
      enable = true;
      wifi = {
        backend = "iwd";
        powersave = true;
      };
    };
  };

  systemd.services.NetworkManager-wait-online.enable = false;
}
