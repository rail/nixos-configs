{ pkgs, lib, ... }:

{
  # Disabled due to https://github.com/NixOS/nixpkgs/issues/44965
  # boot.plymouth.enable = true;

  i18n = {
    defaultLocale = "en_CA.UTF-8";
  };

  time.timeZone = "America/Toronto";
  networking.networkmanager.enable = true;

  # copy the system configuration into nix-store
  system.copySystemConfiguration = true;
  security.sudo.wheelNeedsPassword = false;
  security.rtkit.enable = true;

  boot = {
    cleanTmpDir = true;
    tmpOnTmpfs = true;
  };

  console = {
    earlySetup = true;
    packages = [ pkgs.terminus_font ];
    font = "ter-132n";
    keyMap = "us";
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

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
    package = pkgs.bluezFull;
  };

  virtualisation.docker = {
    enable = true;
    storageDriver = "zfs";
    autoPrune.enable = true;
  };

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
    displayManager.defaultSession = "none+i3";
    displayManager.lightdm = {
      enable = true;
      background = "/home/rail/Pictures/wallpapers/current";
      greeters.mini = {
            enable = true;
            user = "rail";
        };
      autoLogin = {
        enable = true;
        user = "rail";
      };
    };
    desktopManager = {
      gnome3.enable = true;
      xterm.enable = false;
    };
    windowManager = {
      i3.enable = true;
    };
  };

  environment.gnome3.excludePackages = with pkgs.gnome3; [
    evolution gnome-maps gnome-logs epiphany
  ];

  # redshift using geolocation
  location.provider = "geoclue2";
  services.geoclue2.enable = true;
  services.redshift.enable = true;

  services.autorandr = {
    enable = true;
    defaultTarget = "laptop";
  };

  # make /dev/hidraw* devices 660
  hardware.u2f.enable = true;

  nix = {
    useSandbox = true;
  };

  programs.autojump.enable = true;

  fonts = {
    fontconfig.dpi = 144;
    fontconfig.penultimate.enable = true;
    fonts = with pkgs; [
      anonymousPro
      cantarell_fonts
      corefonts
      dejavu_fonts
      fira-code
      fira-code-symbols
      font-awesome_4
      freefont_ttf
      hack-font
      liberation_ttf
      material-icons
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      powerline-fonts
      source-code-pro
      weather-icons
    ];
  };

  services.xserver.windowManager.i3 = {
    extraPackages = with pkgs; [
      feh
      i3status
      i3status-rust
      libnotify
      rofi
      python3.pkgs.py3status
      xkblayout-state
    ];
  };

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  services.flatpak.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
}
