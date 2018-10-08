{ pkgs, ... }:

{
  nixpkgs.config.packageOverrides = pkgs: {
    neovim = pkgs.neovim.override {
      vimAlias = true;
      viAlias = true;
    };
  };
  environment.systemPackages = [ pkgs.neovim ];
  environment.variables = {
    EDITOR = "vim";
  };
}
