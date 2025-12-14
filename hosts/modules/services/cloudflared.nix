{
  services.cloudflared = {
    enable = true;
    tunnels = {
      "e14g2" = {
        credentialsFile = "/root/cloudflared-credentials.json";
        default = "http_status:404";
        warp-routing.enabled = true;
        ingress = {
          "rdp.intellagent.online" = {
            service = "tcp://localhost:3389";
          };
        };
      };
    };
  };
}
