{inputs, ...}: {
  imports = [
    inputs.catppuccin.homeModules.catppuccin
  ];

  config.catppuccin = {
    enable = true;
    cache.enable = true;
    autoEnable = false; # Enrolls all supported apps/ports automatically

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
