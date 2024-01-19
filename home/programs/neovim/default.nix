{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    cmake
    gnumake
    gcc
    lazygit
    fd
    ripgrep
    wl-clipboard
    tree-sitter
    stylua
    shfmt
    fish
    alejandra

    nodejs
    nodePackages.prettier
  ];

  programs.neovim = {enable = true;};

  home.file."${config.home.homeDirectory}/.config/nvim/init.lua" = {
    source = ./config/init.lua;
  };

  home.file."${config.home.homeDirectory}/.config/nvim/lua" = {
    source = ./config/lua;
  };
}
