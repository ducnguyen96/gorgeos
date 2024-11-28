let
  settings = {
    main = {
      capslock = "overload(control, esc)";
      leftalt = "layer(leftalt)";
      rightalt = "leftalt";
    };

    leftalt = {
      space = "enter";
      x = "backspace";

      tab = "A-tab";
      u = "A-k";
      d = "A-j";
      s = "/";
      c = "\\";

      h = "left";
      l = "right";
      j = "down";
      k = "up";
      b = "home";
      n = "end";

      e = "equal";
      p = "+";
      m = "-";
      q = "'";
      w = ''"'';

      "1" = "(";
      "2" = "[";
      "3" = "{";
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
