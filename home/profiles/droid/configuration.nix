{pkgs, ...}: {
  home = {
    username = "duc";
    homeDirectory = "/home/duc";

    packages = with pkgs; [gawk ncurses5 posting];
  };

  manual = {
    html.enable = false;
    json.enable = false;
    manpages.enable = false;
  };

  programs.home-manager.enable = true;

  home.stateVersion = "26.05";
}
