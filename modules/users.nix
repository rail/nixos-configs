{ pkgs, ... }:

let
  pubkey = import ../services/pubkey.nix;
in

{
  users.users.rail = {
    isNormalUser = true;
    uid = 1000;
    description = "Rail Aliiev";
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "docker" ];
    openssh.authorizedKeys.keys = [ pubkey.rail ];
    shell = pkgs.zsh;
  };

}
