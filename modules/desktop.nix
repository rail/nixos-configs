{ pkgs, config, ... }:

{
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_CA.UTF-8";
  };

  time.timeZone = "America/Toronto";
  networking.networkmanager.enable = true;

  # copy the system configuration into nix-store
  system.copySystemConfiguration = true;
  security.sudo.wheelNeedsPassword = false;
  boot = {
    cleanTmpDir = true;
    tmpOnTmpfs = true;
  };

  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
    package = pkgs.pulseaudioFull;
    tcp.enable = true;
    tcp.anonymousClients.allowAll = true;
    zeroconf.discovery.enable = true;
    zeroconf.publish.enable = true;
  };
  hardware.bluetooth.enable = true;

  virtualisation.docker = {
    enable = true;
    storageDriver = "overlay2";
  };

  services.printing = {
    enable = true;
    drivers = with pkgs; [ gutenprint gutenprintBin ];
  };
  # The following part fixes the printing issues \o/
  # "Unable to locate printer"
  services.avahi = {
    enable = true;
    nssmdns = true;
  };

  services.xserver = {
    exportConfiguration = true;
    enable = true;
    layout = "us";
    deviceSection = ''
      Option      "Backlight"  "intel_backlight"
    '';
    videoDrivers = [ "intel" ];
    # GDM breaks xbacklight!!! booooooo
    # displayManager.gdm.enable = true;
    displayManager.lightdm = {
      enable = true;
      greeters.gtk.indicators = [ "~host" "~spacer" "~clock" "~spacer" "~a11y" "~session" "~power"];
      background = "/home/rail/Pictures/wallpapers/current";
    };
    desktopManager = {
      default = "none";
      gnome3.enable = true;
      xterm.enable = false;
    };
    windowManager = {
      default = "i3";
      i3.enable = true;
    };
  };

  services.redshift = {
    enable = true;
    provider = "geoclue2";
  };

  # make GDM find other WMs
  # system.activationScripts.etcX11sessions = ''
  #   echo "setting up /etc/X11/sessions..."
  #   mkdir -p /etc/X11
  #   [[ ! -L /etc/X11/sessions ]] || rm /etc/X11/sessions
  #   ln -sf ${config.services.xserver.displayManager.session.desktops} /etc/X11/sessions
  # '';

  # TODO: make this work and remove from i3 config
  # systemd.user.services.lightlocker = {
  #   description = "Light locker";
  #   wantedBy = [ "graphical-session.target" ];
  #   partOf = [ "graphical-session.target" ];
  #   serviceConfig = {
  #     ExecStart = "${pkgs.lightlocker}/bin/light-locker --lock-after-screensaver=10 --late-locking --idle-hint --lock-on-suspend";
  #     RestartSec = 15;
  #     Restart = "always";
  #     Environment = "XDG_SESSION_PATH=/org/freedesktop/DisplayManager/Session0";
  #     PassEnvironment = "DISPLAY";
  #   };
  # };

  services.autorandr = {
    enable = true;
    # unstable only, defaultTarget = "laptop";
  };

}
