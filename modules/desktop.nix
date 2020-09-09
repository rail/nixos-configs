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
    package = pkgs.pulseaudioFull;
    extraModules = [ pkgs.pulseaudio-modules-bt ];
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
    package = pkgs.bluezFull;
  };

  services.blueman.enable = true;

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
    displayManager.defaultSession = "none+xmonad";
    displayManager.lightdm = {
      enable = true;
      background = "/home/rail/Pictures/wallpapers/current";
      greeters.mini = {
            enable = true;
            user = "rail";
        };
    };
    displayManager.autoLogin = {
      enable = true;
      user = "rail";
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

  nix = {
    useSandbox = true;
  };

  programs.autojump.enable = true;

  fonts = {
    fontconfig.dpi = 144;
    fonts = with pkgs; [
      cantarell_fonts
      fira-code
      fira-code-symbols
      font-awesome
      material-icons
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
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
}
