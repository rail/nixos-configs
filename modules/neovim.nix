{ pkgs, ... }:

let
  unstable_local = import /home/rail/work/mozilla/git/nixpkgs {};
in

{
  nixpkgs.config.packageOverrides = pkgs: {
    neovim = unstable_local.neovim.override {
      vimAlias = true;
      viAlias = true;
    };
  };
  environment.systemPackages = [ pkgs.neovim ];
}
