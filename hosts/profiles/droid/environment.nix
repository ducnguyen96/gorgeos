{pkgs, ...}: {
  environment = {
    packages = with pkgs; [vim];

    # Backup etc files instead of failing to activate generation if a file already exists in /etc
    etcBackupExtension = ".bak";

    motd = null;

    sessionVariables = {};
  };
}
