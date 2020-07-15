{ config, pkgs, ... }:
let
  nixos-unstable = import <nixos-unstable> {
    # Include the nixos config when importing nixos-unstable
    # But remove packageOverrides to avoid infinite recursion
    config = removeAttrs config.nixpkgs.config [ "packageOverrides" ];
  };
in
{
  ######## The following section can be deleted, when 20.09 is out
  # disable 20.03 outdated znapzend module
  disabledModules = [ "services/backup/znapzend.nix" ];
  # use the module from unstable
  imports = [
    <nixos-unstable/nixos/modules/services/backup/znapzend.nix>
  ];
  # the same for the package
  nixpkgs.config.packageOverrides = pkgs: {
    znapzend = nixos-unstable.znapzend;
  };
  ######## The section above can be deleted, when 20.09 is out

  services.znapzend = {
    enable = true;
    autoCreation = true;
    pure = true;
    features.sendRaw = true;
    zetup = {
      # to create: sudo zfs send -w rpool/HOME@...  | sudo zfs receive -F backup/HOME
      "rpool/HOME" = {
        plan = "4hour=>15min,2day=>1hour,7day=>1day,3week=>1week";
        enable = true;
        destinations = {
          local = {
            presend = "zpool import -Nf backup";
            postsend = "zpool export backup";
            dataset = "backup/HOME";
            plan = "4day=>1hour,1week=>1day,1year=>1week,10year=>1month";
          };
        };
      };
      # to create: sudo zfs send -w rpool/NIXOS@...  | sudo zfs receive -F backup/NIXOS
      "rpool/NIXOS" = {
        plan = "1day=>12hour,7day=>1day,3week=>1week";
        enable = true;
        destinations = {
          local = {
            presend = "zpool import -Nf backup";
            postsend = "zpool export backup";
            dataset = "backup/NIXOS";
            plan = "4days=>12hour,1week=>1day,1year=>1week,10year=>1month";
          };
        };
      };
    };
  };
}
