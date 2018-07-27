{ pkgs, config, ... }:

{
  services.printing = {
    enable = true;
    drivers = with pkgs; [ gutenprint gutenprintBin ];
  };

  services.xserver = {
    exportConfiguration = true;
    enable = true;
    layout = "us";
    deviceSection = ''
      Option      "Backlight"  "intel_backlight"
    '';
    videoDrivers = [ "intel" ];
    displayManager.gdm.enable = true;
    # displayManager.lightdm = {
    #   enable = true;
    #   greeters.gtk.indicators = [ "~host" "~spacer" "~clock" "~spacer" "~a11y" "~session" "~power"];
    # };
    desktopManager = {
      default = "none";
      gnome3.enable = true;
      xterm.enable = false;
    };
    windowManager = {
      default = "i3";
      i3.enable = true;
    };
    xautolock =  {
      enable = true;
      killer = null;
      extraOptions = [ "-lockaftersleep" ];
    };
  };

  services.redshift = {
    enable = true;
    provider = "geoclue2";
  };
  programs.light.enable = true;

  # make GDM find other WMs
  system.activationScripts.etcX11sessions = ''
    echo "setting up /etc/X11/sessions..."
    mkdir -p /etc/X11
    [[ ! -L /etc/X11/sessions ]] || rm /etc/X11/sessions
    ln -sf ${config.services.xserver.displayManager.session.desktops} /etc/X11/sessions
  '';

  # systemd.user.services.lightlocker = {
  #   description = "Light locker";
  #   wantedBy = [ "graphical-session.target" ];
  #   partOf = [ "graphical-session.target" ];
  #   serviceConfig = {
  #     ExecStart = "${pkgs.lightlocker}/bin/light-locker --lock-after-screensaver=10 --late-locking --idle-hint";
  #     RestartSec = 3;
  #     Restart = "always";
  #   };
  # };
  # systemd.user.services.xscreensaver = {
  #   description = "XScreenSaver";
  #   wantedBy = [ "graphical-session.target" ];
  #   partOf = [ "graphical-session.target" ];
  #   serviceConfig = {
  #     ExecStart = "${pkgs.xscreensaver}/bin/xscreensaver -no-splash";
  #     RestartSec = 3;
  #     Restart = "always";
  #   };
  # };


}
