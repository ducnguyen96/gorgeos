{pkgs, ...}: {
  programs = {
    ssh.startAgent = false;
  };

  services = {
    dbus = {
      enable = true;
      packages = with pkgs; [dconf udisks2];
    };

    openssh = {
      enable = true;
      settings = {
        KbdInteractiveAuthentication = false;
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
    };
  };
}
