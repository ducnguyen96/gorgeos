{
  services.wayvnc = {
    enable = true;
    autoStart = true;

    settings = {
      address = "0.0.0.0";
      port = 5901;
    };
  };
}
