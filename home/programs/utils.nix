{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      android-tools
      ventoy
      cloudflare-warp
      usbutils
      yt-dlp
      unzip
      wget
      file
      htop
      scrcpy
      rsync
      pfetch
      showmethekey
      polkit_gnome
      findutils.locate
      linux-wifi-hotspot
    ];
  };
}
