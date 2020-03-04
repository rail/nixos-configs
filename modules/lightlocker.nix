{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    lightlocker
  ];
  # light-locker --lock-after-screensaver=10 --late-locking --idle-hint --lock-on-suspend &
  # systemd.user.services.lightlocker = {
  #   description = "Light-locker";
  #   wantedBy = [ "graphical-session.target" ];
  #   partOf = [ "graphical-session.target" ];
  #   serviceConfig.ExecStart = "${pkgs.lightlocker}/bin/light-locker --lock-after-screensaver=10 --late-locking --idle-hint --lock-on-suspend --debug";
  # };
}
