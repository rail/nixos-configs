{ pkgs, unstable, ... }:
# let
#   emacsWithPackages = (pkgs.emacsPackagesNgGen pkgs.emacs).emacsWithPackages;
#   myEmacs = emacsWithPackages (epkgs: (with epkgs.melpaPackages; [
#     notmuch
#     undo-tree
#     zerodark-theme
#   ]));
# in
{
  environment.systemPackages = with unstable; [
    emacs
  ];

}
