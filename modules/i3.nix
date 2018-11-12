{ pkgs, unstable, ... }:

{
  services.xserver.windowManager.i3.package = unstable.i3;
  services.xserver.windowManager.i3.extraPackages = with pkgs; [
    compton
    dunst
    feh
    unstable.i3status
    libnotify
    rofi
    python3.pkgs.py3status
  ];
}
