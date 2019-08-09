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
      # (polybar.override { i3Support = true; pulseSupport = true; githubSupport = true; })
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
