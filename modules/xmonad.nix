{ pkgs, ...}:
{
  services.xserver.windowManager.xmonad.enable = true;
  services.xserver.windowManager.xmonad.enableContribAndExtras = true;
  environment.systemPackages = with pkgs; [
    xmobar
    picom
    stalonetray
    xdotool
  ];
}
