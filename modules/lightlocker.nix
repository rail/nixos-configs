{ pkgs, config, ... }:

{
  environment.systemPackages = with pkgs; [
    lightlocker
  ];
  # light-locker --lock-after-screensaver=10 --late-locking --idle-hint --lock-on-suspend &
  # systemd.user.services.lightlocker = {
  #   description = "Light-locker";
  #   wantedBy = [ "graphical-session.target" ];
  #   partOf = [ "graphical-session.target" ];
  #   serviceConfig.ExecStart = "${pkgs.lightlocker}/bin/light-locker --lock-after-screensaver=10 --late-locking --idle-hint --lock-on-suspend --lock-on-lid --debug";
  # };
  # systemd.user.services.lightlocker = {
  #   description = "Light-locker";
  #   wantedBy = [ "graphical-session.target" ];
  #   partOf = [ "graphical-session.target" ];
  #   serviceConfig.ExecStart = "${pkgs.lightlocker}/bin/light-locker --lock-after-screensaver=10 --late-locking --idle-hint --lock-on-suspend --lock-on-lid --debug";
  # };
  # services.xserver.displayManager.sessionCommands = ''
  #   ${config.systemd.package}/bin/systemctl --user import-environment XDG_SESSION_PATH
  # '';
}
