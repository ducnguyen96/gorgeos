{pkgs, ...}: {
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "ssh.duchue.homes" = {
        proxyCommand = "${pkgs.cloudflared}/bin/cloudflared access ssh --hostname %h";
      };
    };
  };
  services.ssh-agent.enable = true;
}
