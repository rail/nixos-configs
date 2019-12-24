{ pkgs, ... }:

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
  services.timesyncd.enable = true;

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
    autoPrune.enable = true;
  };

  security.rtkit.enable = true;

  # virtualisation.virtualbox.host = {
  #   enable = true;
  # };

  services.printing = {
    enable = true;
    drivers = with pkgs; [ gutenprint gutenprintBin hplip ];
  };
  # The following part fixes the printing issues \o/
  # "Unable to locate printer"
  services.avahi = {
    enable = true;
    nssmdns = true;
    ipv6 = true;
  };

  services.xserver = {
    exportConfiguration = true;
    enable = true;
    layout = "us,ru";
    xkbOptions = "compose:ralt,grp:shifts_toggle,grp_led:caps,caps:escape";
    deviceSection = ''
      Option      "Backlight"  "intel_backlight"
    '';
    videoDrivers = [ "intel" ];
    # GDM breaks xbacklight!!! booooooo
    displayManager.gdm.enable = false;
    displayManager.lightdm = {
      enable = true;
      greeters.gtk.indicators = [ "~host" "~spacer" "~clock" "~spacer" "~a11y" "~session" "~power"];
      background = "/home/rail/.background-image";
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
    xautolock =  {
      enable = true;
      killer = null;
      extraOptions = [ "-lockaftersleep" ];
      locker = "${pkgs.i3lock-color}/bin/i3lock-color --clock --indicator";
      nowlocker = "${pkgs.i3lock-color}/bin/i3lock-color --clock --indicator";
    };
  };

  programs.xss-lock = {
    enable = true;
    lockerCommand = "${pkgs.i3lock-color}/bin/i3lock-color --clock --indicator";
  };

  environment.gnome3.excludePackages = with pkgs.gnome3; [
    evolution gnome-maps gnome-logs epiphany
  ];

  # redshift using geolocation
  location.provider = "geoclue2";
  services.geoclue2.enable = true;
  services.redshift.enable = true;

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
    defaultTarget = "laptop";
  };

  # make /dev/hidraw* devices 660
  hardware.u2f.enable = true;

  nix = {
    useSandbox = true;
    # allowedUsers = [ "rail" ];
    # trustedUsers = [ "rail" ];
  };

  programs.autojump.enable = true;

}
