let
  settings = {
    main = {
      shift = "oneshot(shift)";
      meta = "oneshot(meta)";
      control = "oneshot(control)";
      capslock = "overload(control, esc)";
      leftalt = "layer(leftalt)";
    };

    leftalt = {
      space = "enter";
      c = "backspace";

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
