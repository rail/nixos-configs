{ pkgs, ... }:

{
  services.xserver.windowManager.bspwm.enable = true;
  environment.systemPackages = with pkgs; [
    polybar
  ];
}
