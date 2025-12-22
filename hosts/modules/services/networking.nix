{
  networking = {
    firewall.enable = false;
    networkmanager = {
      enable = true;
    };
  };

  systemd.services.NetworkManager-wait-online.enable = false;
}
