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
        KdbInteractiveAuthentication = false;
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
    };
  };
}
