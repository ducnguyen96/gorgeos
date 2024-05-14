{pkgs, ...}: {
  environment = {
    systemPackages = with pkgs; [
      git
      neovim
      tree-sitter
      starship
      vim
    ];
  };
}
