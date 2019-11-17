{ config, ... }:
let
  user = "rail";
  group = "users";
  home = config.users.users.${user}.home;
  localRepo = "${home}/backup/borg";
  remoteRepo = "borg@merail.ca:/home/borg/backup";
  sshKey = "${home}/.ssh/borg";

  private = {
    paths =
      [ "/boot/efi" ] ++
      map ( p: home + "/" + p ) [
        "Private"
        ".config"
        ".ssh"
        "Documents"
        ".gnupg"
        ".password-store"
      ];
    startAt = "*-*-* 20:00:00";
    inherit user group;
    prune.keep = {
      within = "1d"; # Keep all archives from the last day
      daily = 7;
      weekly = 4;
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
      startAt = "*-*-* 21:00:00";
    } // private;
  };
}
