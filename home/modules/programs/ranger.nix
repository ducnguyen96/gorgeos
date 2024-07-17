{
  config,
  pkgs,
  ...
}: {
  programs.ranger = {
    enable = true;

    settings = {
      column_ratios = "1,3,3";
      confirm_on_delete = "never";
      scroll_offset = 8;
      unicode_ellipsis = true;
    };

    extraConfig = ''
      set preview_images true
      set preview_images_method kitty
    '';
  };
}
