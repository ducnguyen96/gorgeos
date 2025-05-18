let
  settings = {
    main = {
      capslock = "overload(control, esc)";
      leftalt = "layer(leftalt)";
      rightcontrol = "leftalt";
      rightalt = "leftalt";
    };

    leftalt = {
      enter = "A-enter";
      space = "enter";
      tab = "A-tab";

      h = "A-h";
      l = "A-l";
      j = "A-j";
      k = "A-k";
      b = "home";
      n = "end";
      R = "@";

      q = "'";
      Q = ''"'';
      e = "equal";
      p = "+";
      m = "-";
      u = "_";

      "1" = "(";
      "2" = "[";
      "3" = "{";
      "!" = ")";
      "@" = "]";
      "#" = "}";

      a = "left";
      w = "up";
      d = "right";
      s = "down";

      x = "backspace";
      z = "/";
      c = "\\";
    };
  };
in {
  services.keyd = {
    enable = true;

    keyboards = {
      default = {
        ids = ["*"];
        settings = settings;
      };
      externalKeyboars = {
        ids = ["*"];
        settings = settings;
      };
    };
  };
}
