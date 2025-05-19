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

      h = "left";
      l = "right";
      j = "down";
      k = "up";
      b = "home";
      n = "end";
      r = "@";

      q = "'";
      Q = ''"'';
      w = ''"'';
      e = "equal";
      E = "+";
      p = "+";
      m = "-";
      u = "A-j";
      i = "A-k";
      v = "C-S-v";

      "1" = "(";
      "2" = "[";
      "3" = "{";
      "!" = ")";
      "@" = "]";
      "#" = "}";

      f = "-";
      F = "_";
      a = ",";
      A = "<";
      d = ".";
      D = ">";

      s = "/";
      S = "?";
      x = "backspace";
      z = "/";
      Z = "?";
      c = "\\";
      C = "|";
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
