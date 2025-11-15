{
  # Mở firewall cho HTTP và HTTPS
  networking.firewall.allowedTCPPorts = [80 443];

  # Cấu hình ACME (Let's Encrypt)
  security.acme = {
    acceptTerms = true;
    defaults.email = "levinguyen.dl@gmail.com";
  };

  # Cấu hình Nginx
  services.nginx = {
    enable = true;

    # Recommended settings
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    # Virtual hosts
    virtualHosts = {
      "intellagent.online" = {
        enableACME = true;
        forceSSL = true;

        # Cấu hình root directory
        root = "/var/www/intellagent.online";

        # Locations
        locations."/" = {
          index = "index.html index.htm";
          tryFiles = "$uri $uri/ =404";
        };

        # Thêm headers bảo mật
        extraConfig = ''
          add_header X-Frame-Options "SAMEORIGIN" always;
          add_header X-Content-Type-Options "nosniff" always;
          add_header X-XSS-Protection "1; mode=block" always;
        '';
      };

      # Subdomain example - www
      "www.intellagent.online" = {
        enableACME = true;
        forceSSL = true;
        globalRedirect = "intellagent.online";
      };
    };
  };

  # Tạo thư mục web root
  systemd.tmpfiles.rules = [
    "d /var/www 0755 root root -"
    "d /var/www/intellagent.online 0755 root root -"
  ];

  # Tạo file index.html mẫu
  environment.etc."nginx-sample-index.html" = {
    text = ''
      <!DOCTYPE html>
      <html lang="vi">
      <head>
          <meta charset="UTF-8">
          <meta name="viewport" content="width=device-width, initial-scale=1.0">
          <title>Welcome to intellagent.online</title>
          <style>
              body {
                  font-family: Arial, sans-serif;
                  display: flex;
                  justify-content: center;
                  align-items: center;
                  height: 100vh;
                  margin: 0;
                  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                  color: white;
              }
              .container {
                  text-align: center;
                  padding: 2rem;
                  background: rgba(255, 255, 255, 0.1);
                  border-radius: 10px;
                  backdrop-filter: blur(10px);
              }
              h1 {
                  font-size: 3rem;
                  margin-bottom: 1rem;
              }
              p {
                  font-size: 1.2rem;
              }
          </style>
      </head>
      <body>
          <div class="container">
              <h1>🚀 Welcome!</h1>
              <p>Your NixOS server with Nginx is running successfully!</p>
              <p><strong>intellagent.online</strong></p>
          </div>
      </body>
      </html>
    '';
  };
}
