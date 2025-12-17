{
  services.cloudflared = {
    enable = true;
    tunnels = {
      "e14g2" = {
        credentialsFile = "/root/e14g2-credentials.json";
        default = "http_status:404";
        warp-routing.enabled = true;
      };
    };
  };
}
