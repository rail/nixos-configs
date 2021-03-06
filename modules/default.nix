{ ... }:

{
  imports =
    [
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
      ./znapzend.nix
      ./lightlocker.nix
      # ./emacs.nix # TODO: add more things
      ./fd.nix
      ./xmonad.nix
      ./persist.nix
    ];
}
