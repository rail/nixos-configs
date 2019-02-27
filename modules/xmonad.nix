{ pkgs, ... }:

{
  services.xserver.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
    extraPackages = haskelPackages: [ haskelPackages.xmobar ];
  };
}