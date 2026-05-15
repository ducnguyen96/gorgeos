{pkgs, ...}: {
  # Set your time zone
  time.timeZone = "Asia/Ho_Chi_Minh";

  # Read the changelog before changing this value
  system.stateVersion = "24.05";

  terminal.font = "${pkgs.nerd-fonts.jetbrains-mono}/share/fonts/truetype/NerdFonts/JetBrainsMonoNerdFontMono-Medium.ttf";

  build.activation.zz_unfuck_proot = ''
    echo "overwriting proot-static.new with old (and working) proot executable"
    cp -v /data/data/com.termux.nix/files/usr/bin/proot-static /data/data/com.termux.nix/files/usr/bin/.proot-static.new
  '';
}
