{ pkgs, ... }:
let
  neovim = pkgs.neovim.override {
    vimAlias = true;
    viAlias = true;
    configure = import ./vim_config.nix { inherit pkgs; };
  };
in
{
  environment.systemPackages = [ neovim ];
  environment.variables = {
    EDITOR = pkgs.lib.mkForce "nvim";
    GIT_EDITOR = pkgs.lib.mkForce "nvim +startinsert +0";
  };
}
