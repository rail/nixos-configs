{ config, pkgs, ... }:

let
  unstable_local = import /home/rail/work/mozilla/git/nixpkgs {};
  unstable = import <nixos-unstable> {};
in

{

  # services.xserver.windowManager.i3.package = pkgs.i3-gaps;
  services.xserver.windowManager.i3.extraPackages = with pkgs; [
    compton
    dmenu
    dunst
    feh
    i3lock
    i3status
    libnotify
    rofi
  ];
  environment.systemPackages = [
    unstable_local.python3Packages.py3status
  ];

}
