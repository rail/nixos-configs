{ pkgs, config, ... }:

let
  pubkey = (import ./pubkeys.nix).rail;
  unstable = (import <nixos-unstable> {});
in

{
  imports =
    [
      ./borgbackup.nix
      ./desktop.nix
      ./dev.nix
      ./dunst.nix
      (import ./fonts.nix { inherit pkgs unstable; })
      (import ./i3.nix { inherit pkgs unstable; })
      ./mail.nix
      (import ./neovim.nix { pkgs = unstable; } )
      ./python.nix
      (import ./soft.nix {inherit pkgs unstable config;})
      ./tmux.nix
      (import ./ssh.nix { inherit pubkey; })
      (import ./users.nix { inherit pkgs pubkey; })
      ./zsh.nix
      ./sway.nix
    ];
}
