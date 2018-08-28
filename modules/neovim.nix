{ pkgs, unstable, ... }:

{
  nixpkgs.config.packageOverrides = pkgs: {
    neovim = unstable.neovim.override {
      vimAlias = true;
      viAlias = true;
    };
  };
  environment.systemPackages = [ pkgs.neovim ];
  environment.variables = {
    EDITOR = "vim";
  };
}
