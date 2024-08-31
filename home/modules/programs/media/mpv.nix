{pkgs, ...}: let
  pythonPackages = pkgs.python3Packages;
  film-central = let
    pname = "film-central";
    version = "1.4";
    format = "wheel";
  in
    pythonPackages.buildPythonPackage {
      inherit pname version format;
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/22/a4/bbdba2ba88788bd52e6bcf89ff21d11d5001245d76eb51df7ab5fc13561d/film_central-1.4-py3-none-any.whl";
        sha256 = "sha256-HqZyA7cIlFeg6bJfyENab8O+iCfxZRmMqEnQpgsukC8=";
      };
    };
in {
  programs.mpv = {
    enable = true;
    config = {
      border = false;
      gpu-context = "wayland";
      hwdec = "auto";
      osc = false;
      profile = "gpu-hq";
      vo = "gpu";
    };
    scripts = with pkgs.mpvScripts; [mpris thumbnail sponsorblock];
  };

  home.packages = [
    pkgs.mov-cli
    film-central
    pkgs.yt-dlp
  ];

  home.sessionVariables = {
    PYTHONPATH = "${film-central}/lib/python3.12/site-packages";
  };
}
