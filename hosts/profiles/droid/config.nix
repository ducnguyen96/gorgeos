{pkgs, ...}: {
  # Set your time zone
  time.timeZone = "Asia/Ho_Chi_Minh";

  # Read the changelog before changing this value
  system.stateVersion = "24.05";

  terminal.font = "${pkgs.jetbrains-mono}/share/fonts/truetype/JetBrainsMono-Medium.ttf";
}
