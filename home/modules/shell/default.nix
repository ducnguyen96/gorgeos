{
  imports = [
    ./programs/bat.nix
    ./programs/dircolors.nix
    ./programs/direnv.nix
    ./programs/eza.nix
    ./programs/fzf.nix
    ./programs/git.nix
    ./programs/htop.nix
    ./programs/ranger.nix
    ./programs/starship.nix
    ./programs/zoxide.nix

    ./scripts/clean.nix
    ./scripts/lightctl.nix
    ./scripts/preview.nix
    ./scripts/run-as-service.nix
    ./scripts/vcpctl.nix
    ./scripts/volumectl.nix
    ./scripts/winrdp.nix
    ./scripts/wofi-firefox.nix
    ./scripts/wofi-ollama.nix
    ./scripts/wofi-power.nix
    ./scripts/wofi-workspace-swap.nix
    ./scripts/xrdp.nix
    ./scripts/show-and-hide.nix

    ./services/ssh.nix

    ./zsh.nix
    ./utils.nix
  ];
}
