{ pkgs, pubkey, ... }:

{

  # /dev/hidraw* devices (yubikey, as used by Firefox) are 660 root:root,
  # also /dev/usb/hiddev* (yubikey as used by yubikey-personalization-gui) are owned by the root group
  # thus has to add myself to the root group
  users.users.rail = {
    isNormalUser = true;
    uid = 1000;
    description = "Rail Aliiev";
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "docker" "root" "scanner" "lp" "vboxusers" ];
    openssh.authorizedKeys.keys = [ pubkey ];
    shell = pkgs.zsh;
  };

}
