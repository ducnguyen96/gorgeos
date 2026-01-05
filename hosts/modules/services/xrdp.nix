{lib, ...}: {
  services.xrdp = {
    enable = true;
    port = 3390;
    defaultWindowManager = "i3";
    openFirewall = true;
    audio.enable = true;
  };

  # systemd.services.xrdp.wantedBy = lib.mkForce [];
}
