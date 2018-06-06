{ ... }:

let
  pubkey = import ./pubkey.nix;
in
{
  services.openssh = {
    enable = true;
    permitRootLogin = "yes";
  };
  users.extraUsers.root.openssh.authorizedKeys.keys = [ pubkey.rail ];
}
