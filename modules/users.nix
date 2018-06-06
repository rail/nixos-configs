{ pkgs, ... }:

let
  pubkeys = import ./pubkeys.nix;
in

{
  users.users.rail = {
    isNormalUser = true;
    uid = 1000;
    description = "Rail Aliiev";
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "docker" ];
    openssh.authorizedKeys.keys = [ pubkeys.rail ];
    shell = pkgs.zsh;
  };

}
