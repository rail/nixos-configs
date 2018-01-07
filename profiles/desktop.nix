{ config, pkgs, ... }:
let
  caffeine = pkgs.callPackage ../packages/caffeine.nix { };
  scripts = pkgs.callPackage ../packages/scripts.nix { };
in
{
  imports =
    [
      ./common.nix
      ../services/desktop.nix
      ../modules/fonts.nix
      # ../modules/firefox-overlay.nix
    ];

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    # TODO: caffeine
    # crashplan
    caffeine
    firefox-devedition-bin
    iw
    jetbrains.pycharm-professional
    libreoffice
    mc
    networkmanagerapplet
    polkit_gnome
    scripts
    simplescreenrecorder
    xorg.xbacklight
    xorg.xhost
  ];

  networking.networkmanager.enable = true;
  virtualisation.docker.enable = true;
  virtualisation.docker.storageDriver = "overlay2";

}
