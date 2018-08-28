{ pkgs, unstable, ... }:

{
  # services.xserver.windowManager.i3.package = pkgs.i3-gaps;
  services.xserver.windowManager.i3.extraPackages = with pkgs; [
    compton
    dunst
    feh
    i3status
    libnotify
    rofi
    unstable.python3.pkgs.py3status
  ];
}
