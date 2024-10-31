{pkgs, ...}: {
  imports = [
  ];

  home = {
    username = "duc";
    homeDirectory = "/home/duc";
    extraOutputsToInstall = [
      "doc"
      "devdoc"
    ];
  };

  manual = {
    html.enable = false;
    json.enable = false;
    manpages.enable = false;
  };

  programs.zsh.enable = true;
  programs.home-manager.enable = true;
}
