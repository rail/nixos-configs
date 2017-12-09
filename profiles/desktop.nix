{ config, pkgs, ... }:

let
  pubkey = import ../services/pubkey.nix;
in
{
  imports =
    [
      ./common.nix
      ../services/desktop.nix
    ];

  nixpkgs.config.allowUnfree = true;
  # install packages
  environment.systemPackages = with pkgs; [
    firefox
    simplescreenrecorder
    mc
    compton
    feh
    crashplan
  ];

  virtualisation.docker.enable = true;

  users.extraUsers.rail = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "docker" ];
    openssh.authorizedKeys.keys = [ pubkey.rail ];
  };

  services.syncthing = {
    enable = true;
    user = "rail";
    dataDir = "/home/rail/.syncthing";
  };
}
