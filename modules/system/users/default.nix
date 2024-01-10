{pkgs, ...}: {
  users.users.duc = {
    isNormalUser = true;
    shell = pkgs.zsh;
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
    ];
  };
}
