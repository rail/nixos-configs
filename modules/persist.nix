{ ... }:
let
  persist_root = "/home/persist";
in
{

  environment.etc."NetworkManager/system-connections" = {
    source = "${persist_root}/etc/NetworkManager/system-connections/";
  };

  environment.etc."nixos" = {
    source = "${persist_root}/etc/nixos";
  };

  # systemd.tmpfiles.rules = [
  #   "L /var/lib/bluetooth - - - - ${persist_root}/var/lib/bluetooth"
  # ];

  services.openssh = {
    hostKeys = [
      {
        path = "${persist_root}/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
      {
        path = "${persist_root}/etc/ssh/ssh_host_rsa_key";
        type = "rsa";
        bits = 4096;
      }
    ];
  };
}
