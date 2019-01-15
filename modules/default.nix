{ pkgs, config, ... }:

let
  pubkey = (import ./pubkeys.nix).rail;
  unstable = (import <nixos-unstable> {});
in

{
  imports =
    [
      ./borgbackup.nix
      # ./bspwm.nix
      ./desktop.nix
      ./dev.nix
      ./dunst.nix
      (import ./fonts.nix { inherit pkgs unstable; })
      (import ./i3.nix { inherit pkgs unstable; })
      ./mail.nix
      ./neovim.nix
      ./python.nix
      ./soft.nix
      ./tmux.nix
      (import ./ssh.nix { inherit pubkey; })
      (import ./users.nix { inherit pkgs pubkey; })
      ./zsh.nix
    ];
}

