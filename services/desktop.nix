{ config, pkgs, ... }:

{
  imports = [
    ../modules/i3.nix
  ];
  services.printing.enable = true;

  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.desktopManager.default = "none";
  services.xserver.desktopManager.gnome3.enable = true;
  services.xserver.desktopManager.xterm.enable = false;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.windowManager.default = "i3";
  services.xserver.windowManager.i3.enable = true;

  # services.crashplan.enable = true;
  services.redshift.enable = true;
  services.redshift.provider = "geoclue2";
  services.xserver.deviceSection = ''
    Option      "Backlight"  "intel_backlight"
  '';
  programs.light.enable = true;

}
