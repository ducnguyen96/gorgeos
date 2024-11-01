{
  config,
  pkgs,
  ...
}: {
  # NOTE: enable nixos's nix-ld to be able to use mason packages.
  # add below config to your nixos config module(eg: hosts/profiles/rtx2070/default.nix)
  # programs.nix-ld.enable = true;

  home.packages = with pkgs; [
    # dependencies
    gcc
    ripgrep
    fd
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  home.file."${config.home.homeDirectory}/.config/nvim/init.lua" = {
    source = ./config/init.lua;
  };

  home.file."${config.home.homeDirectory}/.config/nvim/lua" = {
    source = ./config/lua;
  };
}
