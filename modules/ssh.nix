{ ... }:

let
  pubkeys = import ./pubkeys.nix;
in
{
  services.openssh = {
    enable = true;
    permitRootLogin = "yes";
  };
  users.extraUsers.root.openssh.authorizedKeys.keys = [ pubkeys.rail ];
}
