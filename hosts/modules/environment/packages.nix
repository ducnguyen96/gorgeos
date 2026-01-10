{pkgs, ...}: {
  environment = {
    systemPackages = with pkgs; [
      vim
      ventoy-full
    ];
  };
}
