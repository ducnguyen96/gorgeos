let
  settings = {
    main = {
      capslock = "overload(control, esc)";
      leftalt = "layer(leftalt)";
      rightalt = "leftalt";
    };

    leftalt = {
      space = "enter";
      c = "backspace";

      tab = "A-tab";

      h = "left";
      l = "right";
      j = "down";
      k = "up";
      e = "equal";
      p = "+";
      m = "-";
      b = "home";
      n = "end";
      u = "A-k";
      d = "A-j";
      f = "_";
      q = "'";
      w = ''"'';

      r = "(";
      t = ")";
      a = "[";
      s = "]";
      z = "{";
      x = "}";
      "1" = "A-a";
      "2" = "A-s";
      "3" = "A-d";
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
