{inputs, ...}: {
  programs.nh = {
    package = inputs.nh.packages.x86_64-linux.default;
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep-since 30d";
    };
  };
}
