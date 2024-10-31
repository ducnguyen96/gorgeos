{
  imports = [
    ./programs/bat.nix
    ./programs/dircolors.nix
    ./programs/direnv.nix
    ./programs/eza.nix
    ./programs/fzf.nix
    ./programs/starship.nix
    ./programs/zoxide.nix

    ./scripts/clean.nix
    ./scripts/preview.nix
    ./scripts/rebuild.nix
    ./scripts/run-as-service.nix
    ./scripts/volumectl.nix
    ./scripts/wofi-power.nix

    ./services/ssh.nix

    ./zsh.nix
    ./utils.nix
  ];
}