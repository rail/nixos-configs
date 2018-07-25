{ pkgs, ... }:

{
  services.xserver.windowManager.bspwm.enable = true;
  environment.systemPackages = with pkgs; [
    polybar
    xdotool
  ];
  # TODO:
  # pulseaudio
  # backlight
  # dynamic desktops
}
