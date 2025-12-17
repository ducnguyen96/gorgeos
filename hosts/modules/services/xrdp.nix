{
  services.xserver = {
    enable = true;
    windowManager.i3.enable = true;
  };

  services.xrdp = {
    enable = true;
    port = 3390;
    defaultWindowManager = "i3";
    openFirewall = true;
    audio.enable = true;
  };
}
