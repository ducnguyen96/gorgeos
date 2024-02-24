{
  home = {
    username = "duc";
    homeDirectory = "/home/duc";
    extraOutputsToInstall = ["doc" "devdoc"];
    stateVersion = "24.05";
  };

  manual = {
    html.enable = false;
    json.enable = false;
    manpages.enable = false;
  };

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };
  programs.home-manager.enable = true;
}
