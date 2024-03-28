{
  config,
  pkgs,
  ...
}: let
  # fullpage.pkgs = [
  #   (pkgs.stdenv.mkDerivation rec {
  #     version = "2024-03-28";
  #     pname = "eqexam";
  #     name = "${pname}-${version}";
  #     tlType = "run";
  #
  #     src = pkgs.fetchurl {
  #       url = "http://www.math.uakron.edu/~dpstory/eqexam/eqexam_pack.zip";
  #       sha256 = "0g4w9ma6cr277li5b8dps9fm9jkjlwzwjc6ix01mw4kva4h5fdrj";
  #     };
  #
  #     buildInputs = [pkgs.unzip pkgs.texlive.combined.scheme-basic];
  #
  #     buildPhase = "
  #       latex eqexam.ins
  #     ";
  #
  #     installPhase = "
  #       mkdir -p $out/tex/latex/eqexam
  #       cp -va *.sty *.cfg *.def $out/tex/latex/eqexam
  #       mkdir -p $out/doc/latex/eqexam
  #       cp -va doc/* $out/doc/latex/eqexam
  #     ";
  #
  #     meta = {
  #       branch = "3";
  #       platforms = pkgs.stdenv.lib.platforms.unix;
  #     };
  #   })
  # ];
  tex = pkgs.texlive.combine {
    inherit
      (pkgs.texlive)
      scheme-minimal
      latex-bin
      latexmk
      preprint
      titlesec
      marvosym
      tools
      enumitem
      kvoptions
      ltxcmds
      refcount
      hyperref
      fancyhdr
      infwarerr
      pdftexcmds
      etoolbox
      babel-english
      bookmark
      ec
      ;
  };
in {
  home.packages = with pkgs; [
    tex
  ];
}
