{
  services.fprintd.enable = true;

  security = {
    # Don't ask for password for wheel group
    sudo.wheelNeedsPassword = false;

    # Enable Trusted Platform Module 2 support
    tpm2.enable = true;

    polkit = {
      enable = true;

      extraConfig = ''
        polkit.addRule(function(action, subject) {
          if (
            (action.id == "net.reactivated.fprint.device.enroll" ||
             action.id == "net.reactivated.fprint.device.verify" ||
             action.id == "net.reactivated.fprint.device.setusername") &&
            subject.isInGroup("wheel")
          ) {
            return polkit.Result.YES;
          }
        });
      '';
    };

    pam.services = {
      greetd.fprintAuth = true;
      sudo.fprintAuth = true;
      hyprlock.fprintAuth = true;
    };
  };
}
