{inputs, ...}: {
  imports = [
    inputs.catppuccin.homeModules.catppuccin
  ];

  config.catppuccin = {
    enable = true;

    nvim.enable = false;
    kitty.enable = true;
    cursors.enable = true;
    waybar.enable = true;
    rofi.enable = true;
  };
}
