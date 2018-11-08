{ config, ... }:
let
  user = "rail";
  group = "users";
  home = config.users.users.${user}.home;
  localRepo = "${home}/borg";
  remoteRepo = "borg@merail.ca:/home/borg/backup";
  sshKey = "${home}/.ssh/borg";

  private = {
    paths =
      map ( p: home + "/" + p ) [
        "Private"
        ".config"
        ".ssh"
        "Documents"
        ".abook"
        ".gnupg"
        ".gnupg.master"
        "org"
        ".password-store"
      ];
    startAt = "daily";
    inherit user group;
    prune.keep = {
      within = "1d"; # Keep all archives from the last day
      daily = 7;
      weekly = 4;
      monthly = -1; # Keep at least one archive for each month }
    };
    encryption = {
      mode = "repokey";
      passCommand = "cat ${home}/.config/borgpass";
    };
  };

in
{
  services.borgbackup.jobs = {
    private = {
      repo = localRepo;
    } // private;
    privateRemote = {
      repo = remoteRepo;
      environment = { BORG_RSH = "ssh -p 2222 -i ${sshKey}"; };
    } // private;
  };
}
