{ config, pkgs, ... }:
let
  caffeine = pkgs.callPackage ../packages/caffeine.nix { };
in
{
  imports =
    [
      ./common.nix
      ../services/desktop.nix
      ../modules/fonts.nix
    ];

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    firefox-devedition-bin
    caffeine
    mc
    networkmanagerapplet
    iw
    simplescreenrecorder
    # crashplan
    jetbrains.pycharm-professional
    libreoffice
    polkit_gnome
    xorg.xbacklight
    xorg.xhost
    # TODO: caffeine
  ];

  networking.networkmanager.enable = true;
  virtualisation.docker.enable = true;
  virtualisation.docker.storageDriver = "overlay2";

}
