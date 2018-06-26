{ pkgs, ... }:

{
  services.printing = {
    enable = true;
    drivers = with pkgs; [ gutenprint gutenprintBin ];
  };

  services.xserver = {
    enable = true;
    layout = "us";
    deviceSection = ''
      Option      "Backlight"  "intel_backlight"
    '';
    videoDrivers = [ "intel" ];
    displayManager.gdm.enable = true;
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

  # services.crashplan.enable = true;
  services.redshift = {
    enable = true;
    provider = "geoclue2";
  };
  programs.light.enable = true;
}
