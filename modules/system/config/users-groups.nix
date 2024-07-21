{pkgs, ...}: {
  users.users.duc = {
    isNormalUser = true;
    initialPassword = "NixOS";
    shell = pkgs.zsh;
    uid = 1000;

    extraGroups = [
      "adbusers"
      "audio"
      "docker"
      "input"
      "libvirtd"
      "networkmanager"
      "plugdev"
      "video"
      "wheel"
      "i2c"
    ];

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINuuBrTcxqxvYyug48HCwzba2W+1veFO823Znlidbrrh levinguyen.dl@gmail"
    ];
  };
}
