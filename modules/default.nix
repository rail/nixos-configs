{ pkgs, config, ... }:

let
  pubkey = (import ./pubkeys.nix).rail;
in

{
  imports =
    [
      ./bspwm.nix
      ./desktop.nix
      ./dev.nix
      ./fonts.nix
      ./i3.nix
      ./mail.nix
      ./neovim.nix
      ./soft.nix
      ./tmux.nix
      (import ./ssh.nix { inherit pubkey; })
      (import ./users.nix { inherit pkgs pubkey; })
      ./zsh.nix
    ];
}

