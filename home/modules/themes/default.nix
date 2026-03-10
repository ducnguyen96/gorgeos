{inputs, ...}: {
  imports = [
    inputs.catppuccin.homeModules.catppuccin
  ];

  config.catppuccin = {
    enable = true;

    nvim.enable = false;
    kitty.enable = false;
    cursors = {
      enable = true;
      accent = "light";
    };
    waybar.enable = true;
    rofi.enable = true;
  };
}
