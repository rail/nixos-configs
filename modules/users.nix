{ config, pkgs, ... }:

let
  pubkey = import ../services/pubkey.nix;
in

{
  users.extraUsers.rail = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "docker" ];
    openssh.authorizedKeys.keys = [ pubkey.rail ];
    shell = pkgs.zsh;
  };

  services.syncthing = {
    enable = true;
    user = "rail";
    dataDir = "/home/rail/.syncthing";
  };

}
