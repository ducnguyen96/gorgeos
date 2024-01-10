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

  programs.home-manager.enable = true;
}
