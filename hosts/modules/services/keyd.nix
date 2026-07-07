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
      r = "@";

      q = "'";
      a = "left";
      w = "up";
      s = "down";
      d = "right";
      e = "equal";
      p = "+";
      m = "-";
      u = "A-u";
      i = "A-i";
      c = "C-S-c";
      v = "C-S-v";

      "1" = "(";
      "2" = "[";
      "3" = "{";

      f = "-";

      x = "backspace";
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
