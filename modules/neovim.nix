{ pkgs, ... }:

let
  nvim = pkgs.neovim.override {
    vimAlias = true;
    viAlias = true;
  };

in

{
  environment.systemPackages = [ nvim ];
}
