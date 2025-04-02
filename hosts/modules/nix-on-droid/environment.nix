{pkgs, ...}: {
  environment = {
    # Remove welcome
    motd = null;

    # Backup etc files instead of failing to activate generation if a file already exists in /etc
    etcBackupExtension = ".bak";

    # Root packags
    packages = with pkgs; [
    ];
  };
}
