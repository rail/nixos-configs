{ pkgs, ... }:

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

  # services.crashplan.enable = true;
  services.redshift = {
    enable = true;
    provider = "geoclue2";
  };
  programs.light.enable = true;

  # nixpkgs.config.packageOverrides = super: let self = super.pkgs; in
  # {
  #   xorg = super.xorg // {
  #     xorgserver = super.xorg.xorgserver.overrideAttrs (old: {
  #       postInstall = old.postInstall + "rm -rf $out/lib/xorg/modules/drivers";
  #     });
  #   };
  # };
}
