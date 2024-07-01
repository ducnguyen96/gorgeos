{pkgs, ...}: {
  environment = {
    systemPackages = with pkgs; [
      git
      starship
    ];
  };
}
