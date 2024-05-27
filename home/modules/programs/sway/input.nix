{config, ...}: {
  home.file."${config.home.homeDirectory}/.config/sway/config.d/input.conf".text = ''
    input * {
      xkb_options caps:escape
      xkb_layout "us"
    }
  '';
}
