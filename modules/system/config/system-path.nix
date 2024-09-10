{pkgs, ...}: {
  environment = {
    systemPackages = with pkgs; [
      git
      starship
      showmethekey
      ddcutil
      ddcui
      linux-wifi-hotspot
      mitmproxy
    ];
  };
}
