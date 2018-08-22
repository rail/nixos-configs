{ pubkey, ... }:

{
  services.openssh = {
    enable = true;
    permitRootLogin = "yes";
  };
  users.extraUsers.root.openssh.authorizedKeys.keys = [ pubkey ];
}
