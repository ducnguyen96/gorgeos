{inputs, ...}: {
  imports = [
    inputs.nh.nixosModules.default
  ];

  environment.variables.FLAKE = "/home/duc/Documents/Code/SideProjects/gorgeos";

  nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep-since 30d";
    };
  };
}
