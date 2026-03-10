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
  };
}
