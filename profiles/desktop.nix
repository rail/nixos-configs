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
    iw
    simplescreenrecorder
    # crashplan
    jetbrains.pycharm-professional
    libreoffice
    xorg.xbacklight
    xorg.xhost
    # TODO: caffeine
  ];

  virtualisation.docker.enable = true;
  virtualisation.docker.storageDriver = "overlay2";

}
