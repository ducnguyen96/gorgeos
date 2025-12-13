{pkgs, ...}: {
  imports = [
    ../modules/programs/neovim
    ../modules/dev/default.nix

    ../modules/shell

    # i3 window manager for xrdp
    ../modules/x11/i3
  ];

  dev = {
    angular = {
      enable = false;
      useMasonLSP = true;
      asHomePkgs = false;
    };
    clangd = {
      enable = true;
      useMasonLSP = false;
      asHomePkgs = true;
    };
    go = {
      enable = false;
      useMasonLSP = false;
      asHomePkgs = true;
    };
    lua = {
      enable = true;
      useMasonLSP = false;
      asHomePkgs = false;
    };
    nix = {
      enable = true;
      useMasonLSP = false;
      asHomePkgs = true;
    };
    python = {
      enable = false;
      useMasonLSP = false;
      asHomePkgs = true;
    };
    rust = {
      enable = false;
      useMasonLSP = false;
      asHomePkgs = true;
    };
    typescript = {
      enable = true;
      useMasonLSP = false;
      asHomePkgs = true;
    };
    tex = {
      enable = false;
      useMasonLSP = false;
      asHomePkgs = true;
    };
    tailwind.enable = false;
  };

  home = {
    username = "duc";
    homeDirectory = "/home/duc";
    extraOutputsToInstall = [
      "doc"
      "devdoc"
    ];

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
