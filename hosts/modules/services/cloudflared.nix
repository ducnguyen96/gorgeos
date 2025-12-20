{lib, config, ...}: let
  hostname = config.networking.hostName;
in {
  services.cloudflared = {
    enable = true;
    tunnels = {
      "${hostname}" = {
        credentialsFile = "/root/${hostname}-credentials.json";
        default = "http_status:404";
        warp-routing.enabled = true;
      };
    };
  };
  systemd.services."cloudflared-tunnel-${hostname}".wantedBy = lib.mkForce [];
}
