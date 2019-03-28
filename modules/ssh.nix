{ ... }:

{
  services.openssh = {
    enable = true;
    permitRootLogin = "yes";
  };
  users.extraUsers.root.openssh.authorizedKeys.keyFiles = [ ./pubkey ];
}
