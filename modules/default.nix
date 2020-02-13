{ ... }:

{
  imports =
    [
      ./borgbackup.nix
      ./desktop.nix
      ./dev.nix
      ./home.nix
      ./neovim.nix
      ./soft.nix
      ./ssh.nix
      # ./sway.nix
      ./tmux.nix
      ./users.nix
      ./zsh.nix
      # ./virtualbox.nix
    ];
}
