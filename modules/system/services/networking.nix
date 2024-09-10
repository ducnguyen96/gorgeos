{
  networking = {
    firewall.enable = false;
    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
      wifi = {
        backend = "iwd";
        powersave = true;
      };
    };
  };

  systemd.services.NetworkManager-wait-online.enable = false;

  programs = {
    nm-applet.enable = true;
  };

  services = {
    gnome.glib-networking.enable = true;
    resolved.enable = true;
  };
}
