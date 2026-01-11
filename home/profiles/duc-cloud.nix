{pkgs, ...}: {
  imports = [
  ];

  home = {
    username = "duc";
    homeDirectory = "/home/duc";
    sessionVariables = {
    };

    packages = with pkgs; [
    ];
  };

  manual = {
    html.enable = false;
    json.enable = false;
    manpages.enable = false;
  };

  programs.home-manager.enable = true;
}
