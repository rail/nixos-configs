{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    (emacsWithPackages (epkgs: (with epkgs.melpaStablePackages; [
      magit          # ; Integrate git <C-x g>
      zerodark-theme # ; Nicolas' theme
      nix-mode
      evil
      evil-commentary
      evil-matchit
      org-evil
    ]) ++ (with epkgs.melpaPackages; [
      #undo-tree      # ; <C-x u> to show the undo tree
      # zoom-frm       # ; increase/decrease font size for all buffers %lt;C-x C-+>
    ])))
  ];
}
