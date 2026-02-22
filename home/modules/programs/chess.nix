{pkgs, ...}: {
  home.packages = with pkgs; [
    stockfish # The engine
    scid-vs-pc # Professional database tool
  ];
}
