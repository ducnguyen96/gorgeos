{
  services.glpiAgent = {
    enable = true;
    settings = {
      server = "https://asset.nscsoftware.com/plugins/fusioninventory/";
      interval = 3600; # Run every hour
      debug = false;
    };
  };
}
