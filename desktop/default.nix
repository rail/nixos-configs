{ pkgs, ... }:

{
  imports =
    [
      ../modules
    ];

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_CA.UTF-8";
  };

  time.timeZone = "America/Toronto";
  networking.networkmanager.enable = true;
  virtualisation.docker = {
    enable = true;
    storageDriver = "overlay2";
  };

  # copy the system configuration into nix-store
  system.copySystemConfiguration = true;
  security.sudo.wheelNeedsPassword = false;
  environment.variables = {
    EDITOR = "vim";
  };
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
}
