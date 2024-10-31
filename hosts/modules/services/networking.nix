{
  networking = {
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
