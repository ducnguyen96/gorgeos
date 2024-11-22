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
      "cloudflared"
    ];

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFGNbn8ULX8j+jDdAEUkn9++ol6QR57rrpTURo7FcaBF duc@master"
    ];
  };

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFGNbn8ULX8j+jDdAEUkn9++ol6QR57rrpTURo7FcaBF duc@master"
  ];
}
