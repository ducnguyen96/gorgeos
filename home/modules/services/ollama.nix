{
  osConfig,
  lib,
  ...
}: let
  hostname = osConfig.networking.hostName;
in {
  services.ollama = {
    enable = true;
    acceleration =
      if hostname == "rtx2070"
      then "cuda"
      else null;
  };

  systemd.user.services.ollama = {
    Install.WantedBy = lib.mkForce [];
  };
}
