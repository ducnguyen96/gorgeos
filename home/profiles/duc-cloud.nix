{pkgs, ...}: {
  imports = [
    ../modules/programs/neovim
    ../modules/dev/default.nix

    ../modules/shell
  ];

  dev = {
    angular = {
      enable = false;
      useMasonLSP = true;
      asHomePkgs = false;
    };
    clangd = {
      enable = false;
      useMasonLSP = false;
      asHomePkgs = true;
    };
    go = {
      enable = false;
      useMasonLSP = false;
      asHomePkgs = true;
    };
    lua = {
      enable = false;
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
      enable = false;
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
