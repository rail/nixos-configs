{ pkgs, unstable, ... }:

{
  # services.xserver.windowManager.i3.package = unstable.i3;
  services.xserver.windowManager.i3 = {
    extraPackages = with pkgs; [
      feh
      unstable.i3status
      libnotify
      rofi
      unstable.python3.pkgs.py3status
    ];
    extraSessionCommands = ''
      ${pkgs.lightlocker}/bin/light-locker --lock-after-screensaver=10 --late-locking --idle-hint --lock-on-suspend &
    '';
  };

  services.compton = {
    enable = true;
    fade = true;
    fadeDelta = 2;
    shadow = true;
    shadowExclude = [ "window_type *= 'menu'" "window_type *= 'dock'" "window_type *= 'dnd'"];
  };

}
