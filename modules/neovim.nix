{ pkgs, ... }:
let
  pkgs = (import <nixos-unstable> { config = {allowUnfree = true; };});
  neovim = pkgs.neovim.override {
    vimAlias = true;
    viAlias = true;
    configure = import ./vim_config.nix { inherit pkgs; };
  };
in
{
  environment.systemPackages = [
    neovim
    pkgs.bat # fzf syntax highlite
  ];
  environment.variables = {
    EDITOR = pkgs.lib.mkForce "nvim";
  };
}
