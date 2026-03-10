{
  services.openssh = {
    enable = true;
    settings = {
      KbdInteractiveAuthentication = false;
      PasswordAuthentication = false;
      PermitRootLogin = "yes";
      UseDns = true;
      X11Forwarding = false;
    };
  };
  users.users.duc.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFGNbn8ULX8j+jDdAEUkn9++ol6QR57rrpTURo7FcaBF duc@master"
  ];
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFGNbn8ULX8j+jDdAEUkn9++ol6QR57rrpTURo7FcaBF duc@master"
  ];
}
