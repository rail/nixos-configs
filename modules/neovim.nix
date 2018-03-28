{ config, pkgs, ... }:

let
  nvim = pkgs.neovim.override {
    vimAlias = true;
  };

in

{
  environment.systemPackages = [ pkgs.vim ];
}
