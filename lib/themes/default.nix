lib: {
  colorscheme = rec {
    colors = {
      rosewater = "F5E0DC";
      flamingo = "F2CDCD";
      pink = "F5C2E7";
      mauve = "DDB6F2";
      red = "F28FAD";
      maroon = "E8A2AF";
      peach = "F8BD96";
      yellow = "FAE3B0";
      green = "ABE9B3";
      teal = "B5E8E0";
      sky = "89DCEB";
      blue = "96CDFB";
      lavender = "C9CBFF";
      white = "C5C8C9"; # text
      gray2 = "5C6262";
      gray1 = "4A5051"; # surface2
      gray0 = "363D3E"; # surface1
      black4 = "202729";
      black3 = "192022"; # surface0
      black2 = "131A1C"; # base
      black1 = "111719"; # mantle
      black0 = "0D1416"; # crust
    };

    xcolors = lib.mapAttrsRecursive (_: color: "#${color}") colors;
  };

  wallpaper = let
    url = "https://github.com/dharmx/walls/raw/main/anime/a_building_with_a_light_on_the_side.jpg";
    sha256 = "0q741ldnhyw23cxjymnjvwwh46n02dx122z2wsfs2hxzj1zf6m6y";
    ext = lib.last (lib.splitString "." url);
  in
    builtins.fetchurl {
      name = "wallpaper-${sha256}.${ext}";
      inherit url sha256;
    };

  wallpaper2 = let
    url = "https://raw.githubusercontent.com/dharmx/walls/main/anime/a_park_with_benches_and_trees_at_night.jpg";
    sha256 = "1nd3vbjx017qhcyshz349f3c2a1yvz546jvd9lspsciscc8j3czj";
    ext = lib.last (lib.splitString "." url);
  in
    builtins.fetchurl {
      name = "wallpaper-${sha256}.${ext}";
      inherit url sha256;
    };

  lockscreenimage = let
    url = "https://github.com/dharmx/walls/raw/main/anime/cartoon_characters_in_a_blue_background.png";
    sha256 = "1ylq8pg5x0x1n00q86mmf5jxhpbjx5ys4a7m6ag7ryj7zk3xpl8f";
    ext = lib.last (lib.splitString "." url);
  in
    builtins.fetchurl {
      name = "lockscreenimage-${sha256}.${ext}";
      inherit url sha256;
    };
}
