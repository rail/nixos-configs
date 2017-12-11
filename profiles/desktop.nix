{ config, pkgs, ... }:

{
  imports =
    [
      ./common.nix
      ../services/desktop.nix
      ../modules/fonts.nix
    ];

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    firefox
    mc
    iw
    simplescreenrecorder
    # crashplan
    jetbrains.pycharm-professional
  ];

  virtualisation.docker.enable = true;
  virtualisation.docker.storageDriver = "overlay2";

}
