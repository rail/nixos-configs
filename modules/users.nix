{ pkgs, pubkey, ... }:

{
  users.groups.yubikey = { };

  users.users.rail = {
    isNormalUser = true;
    uid = 1000;
    description = "Rail Aliiev";
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "docker" "root" "yubikey" ];
    openssh.authorizedKeys.keys = [ pubkey ];
    shell = pkgs.zsh;
  };

}
