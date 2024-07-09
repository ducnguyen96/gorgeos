let
  settings = {
    main = {
      shift = "oneshot(shift)";
      meta = "oneshot(meta)";
      control = "oneshot(control)";
      capslock = "overload(control, esc)";
      insert = "S-insert";

      leftalt = "layer(leftalt)";
      rightalt = "layer(rightalt)";
    };

    leftalt = {
      j = "down";
      k = "up";
      h = "left";
      l = "right";
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
