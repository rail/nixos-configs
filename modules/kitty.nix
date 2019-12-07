{ pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    kitty
  ];
  programs.zsh = {
    shellAliases = {
      icat = "kitty +kitten icat";
      kdiff = "kitty +kitten diff";
    };
  };
}
