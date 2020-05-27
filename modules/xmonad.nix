{ pkgs, ...}:
{
  services.xserver.windowManager.xmonad.enable = true;
  services.xserver.windowManager.xmonad.enableContribAndExtras = true;
  environment.systemPackages = with pkgs; [
    xmobar
    picom
    stalonetray
    xdotool
  ];
  home-manager.users.rail = {
    services.stalonetray = {
      enable = true;
      config = {
        background = "#343d46";
        decorations = null;
        transparent = true;
        dockapp_mode = null;
        geometry = "1x1-4-4";
        kludges = "force_icons_size";
        grow_gravity = "NE";
        icon_gravity = "NE";
        icon_size = 42;
        sticky = true;
        window_strut = null;
        window_layer = "bottom";
        no_shrink = true;
        skip_taskbar = true;
      };
    };
  };
  fonts.fonts = with pkgs; [
    weather-icons
  ];
}
