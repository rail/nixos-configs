{ pkgs, ... }:

# let
#   url = "https://github.com/colemickens/nixpkgs-wayland/archive/master.tar.gz";
#   waylandOverlay = (import (builtins.fetchTarball url));
# in

{
  # nixpkgs.overlays = [ waylandOverlay ];
  programs.light.enable = true;
  programs.sway = {
    enable = true;
    extraPackages = with pkgs; [
      xwayland
      i3status
      rofi
      python3.pkgs.py3status
      swayidle # used for controlling idle timeouts and triggers (screen locking, etc)
      swaylock # used for locking Wayland sessions
      grim     # screen image capture
      slurp    # screen are selection tool
      mako     # notification daemon
      # wlstream # screen recorder
      # oguri    # animated background utility
      # kanshi   # dynamic display configuration helper
      # redshift-wayland # patched to work with wayland gamma protocol
      # xdg-desktop-portal-wlr # xdg-desktop-portal backend for wlrootswaybar
      # waybar        # polybar-alike
      # i3status-rust # simpler bar written in Rust     python3.pkgs.py3status
    ];
  };
  services.xserver.displayManager.extraSessionFilePackages = [ pkgs.sway ];
}
