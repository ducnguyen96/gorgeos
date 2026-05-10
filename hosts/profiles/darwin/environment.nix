{pkgs, ...}: {
  environment = {
    pathsToLink = ["/share/zsh"];
    systemPackages = with pkgs; [vim];
  };
}
