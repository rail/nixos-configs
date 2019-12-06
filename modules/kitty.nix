{ pkgs, ...}:

{
  programs.zsh = {
    shellAliases = {
      icat = "kitty +kitten icat";
      kdiff = "kitty +kitten diff";
    };
  };
}
