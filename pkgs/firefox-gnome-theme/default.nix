{
  lib,
  stdenv,
  fetchFromGitHub,
}:
stdenv.mkDerivation rec {
  pname = "firefox-gnome-theme";
  version = "126";

  src = fetchFromGitHub {
    repo = pname;
    owner = "rafaelmardojai";
    rev = "v${version}";
    sha256 = "sha256-jVbj2JD5GRkP8s3vKBtd9PDpftf3kjLR0ZA/ND/c2+Q=";
  };

  dontConfigure = true;
  dontBuild = true;
  doCheck = false;

  installPhase = ''
    mkdir -p $out/share/firefox-gnome-theme
    cp -r $src/* $out/share/firefox-gnome-theme
  '';

  meta = with lib; {
    description = "A GNOME theme for Firefox";
    homepage = "https://github.com/rafaelmardojai/firefox-gnome-theme";
    license = licenses.unlicense;
  };
}
