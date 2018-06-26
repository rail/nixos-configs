{ pkgs, ... }:

let
  unstable_local = import /home/rail/work/mozilla/git/nixpkgs {};
  # nvim = pkgs.neovim.override {
  nvim = unstable_local.neovim.override {
    vimAlias = true;
    viAlias = true;
  };

in

{
  environment.systemPackages = [ nvim ];
}
