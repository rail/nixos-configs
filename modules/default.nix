{ pkgs, config, ... }:

let
  unstable = import <nixos-unstable> {};
  pubkey = (import ./pubkeys.nix).rail;
in

{
  imports =
    [
      ./desktop.nix
      ./dev.nix
      ./fonts.nix
      (import ./i3.nix { inherit unstable pkgs; })
      ./mail.nix
      (import ./neovim.nix { inherit unstable pkgs; })
      (import ./soft.nix { inherit unstable pkgs config; })
      (import ./ssh.nix { inherit pubkey; })
      ./tmux.nix
      (import ./users.nix { inherit pkgs pubkey; })
      ./zsh.nix
    ];
}

