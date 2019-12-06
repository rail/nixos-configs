{ pkgs, ... }:

{
  services.xserver.windowManager.i3 = {
    # package = unstable.i3;
    extraPackages = with pkgs; [
      feh
      i3status
      libnotify
      rofi
      python3.pkgs.py3status
      i3lock-color
    ];
  };
}
