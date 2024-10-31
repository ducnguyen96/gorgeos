{pkgs, ...}: {
  users.users.duc = {
    isNormalUser = true;
    initialPassword = "1";
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
    uid = 1000;

    extraGroups = [
      "adbusers"
      "audio"
      "docker"
      "input"
      "libvirtd"
      "qemu-libvirtd"
      "networkmanager"
      "plugdev"
      "video"
      "ydotool"
      "wheel"
      "i2c"
      "wireshark"
    ];

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINuuBrTcxqxvYyug48HCwzba2W+1veFO823Znlidbrrh levinguyen.dl@gmail"
    ];
  };
}
